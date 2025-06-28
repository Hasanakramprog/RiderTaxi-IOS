import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../services/location_service.dart';
import 'package:geolocator/geolocator.dart';

class MapDemoScreen extends StatefulWidget {
  const MapDemoScreen({super.key});

  @override
  State<MapDemoScreen> createState() => _MapDemoScreenState();
}

class _MapDemoScreenState extends State<MapDemoScreen> {
  GoogleMapController? _controller;
  LatLng? _currentLocation;
  String _statusMessage = 'Ready to get location';
  bool _isLoading = false;
  final Set<Marker> _markers = {};

  // Static Beirut location as fallback
  static const LatLng _beirutLocation = LatLng(33.8938, 35.5018);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map Demo - Location Test'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          // Status panel
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            color: Colors.grey.shade100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    if (_isLoading)
                      const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    else
                      Icon(
                        _currentLocation != null
                            ? Icons.location_on
                            : Icons.location_off,
                        color: _currentLocation != null
                            ? Colors.green
                            : Colors.red,
                      ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _statusMessage,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                if (_currentLocation != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    'Lat: ${_currentLocation!.latitude.toStringAsFixed(6)}',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  Text(
                    'Lng: ${_currentLocation!.longitude.toStringAsFixed(6)}',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ],
            ),
          ),
          // Map
          Expanded(
            child: GoogleMap(
              onMapCreated: (GoogleMapController controller) {
                _controller = controller;
                setState(() {
                  _statusMessage = 'Map loaded successfully!';
                });
              },
              initialCameraPosition: const CameraPosition(
                target: _beirutLocation,
                zoom: 14.0,
              ),
              markers: _markers,
              myLocationEnabled: false, // We'll handle this manually
              myLocationButtonEnabled: false,
              onTap: (LatLng position) {
                _addMarker(position, 'Tapped Location');
              },
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'get_location',
            onPressed: _getCurrentLocation,
            backgroundColor: Colors.green,
            child: const Icon(Icons.my_location),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            heroTag: 'clear_markers',
            onPressed: _clearMarkers,
            backgroundColor: Colors.red,
            child: const Icon(Icons.clear),
          ),
        ],
      ),
    );
  }

  Future<void> _getCurrentLocation() async {
    setState(() {
      _isLoading = true;
      _statusMessage = 'Starting location request...';
    });

    try {
      // Use LocationService instead of direct location package
      LocationService locationService = LocationService();

      setState(() {
        _statusMessage = 'Getting current location using LocationService...';
      });

      // Try multiple approaches with different timeouts
      Position? position;

      // Approach 1: Try with reduced timeout first
      try {
        setState(() {
          _statusMessage = 'Trying quick location fix (10 seconds)...';
        });

        position = await locationService.getCurrentLocation().timeout(
          const Duration(seconds: 10),
        );
        print('✅ Quick location succeeded');
      } catch (e) {
        print('⚠️ Quick location failed: $e');

        // Approach 2: Try with longer timeout
        try {
          setState(() {
            _statusMessage = 'Extended location attempt (30 seconds)...';
          });

          position = await locationService.getCurrentLocation().timeout(
            const Duration(seconds: 30),
            onTimeout: () {
              throw Exception(
                'Location request timed out after 30 seconds. This might be due to:\n'
                '- GPS is disabled\n'
                '- Poor GPS signal (try going outside)\n'
                '- Device location services issues\n'
                '- Simulator limitations',
              );
            },
          );
          print('✅ Extended location succeeded');
        } catch (e2) {
          print('⚠️ Extended location failed: $e2');
          throw e2; // Re-throw the error
        }
      }

      if (position != null) {
        LatLng newLocation = LatLng(position.latitude, position.longitude);

        setState(() {
          _currentLocation = newLocation;
          _statusMessage = 'Location found successfully!';
          _isLoading = false;
        });

        // Add marker for current location
        _addMarker(newLocation, 'Current Location');

        // Move camera to current location
        if (_controller != null) {
          await _controller!.animateCamera(
            CameraUpdate.newLatLngZoom(newLocation, 15),
          );
        }

        print(
          '✅ Location found: ${newLocation.latitude}, ${newLocation.longitude}',
        );
        print('📊 Accuracy: ${position.accuracy}m');
        print(
          '⏰ Time: ${DateTime.fromMillisecondsSinceEpoch(position.timestamp.millisecondsSinceEpoch)}',
        );

        // Try to get address using LocationService
        try {
          setState(() {
            _statusMessage = 'Getting address for location...';
          });

          String address = await locationService.getAddressFromLatLng(
            newLocation,
          );
          print('📍 Address: $address');

          setState(() {
            _statusMessage = 'Location found: $address';
          });
        } catch (e) {
          print('⚠️ Could not get address: $e');
          setState(() {
            _statusMessage = 'Location found successfully!';
          });
        }
      } else {
        setState(() {
          _statusMessage = 'Could not get location data';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _statusMessage = 'Error: ${e.toString()}';
        _isLoading = false;
      });

      print('❌ Location error: $e');

      // Show more specific error messages and solutions
      String errorMessage = '';
      String solution = '';

      if (e.toString().contains('timed out')) {
        errorMessage = 'Location request timed out';
        solution =
            'Try:\n• Go outside for better GPS signal\n• Enable high accuracy mode in device settings\n• Restart location services\n• Use a real device instead of simulator';
      } else if (e.toString().contains('permission')) {
        errorMessage = 'Location permission issue';
        solution = 'Please enable location permissions in device settings';
      } else if (e.toString().contains('disabled')) {
        errorMessage = 'Location services disabled';
        solution = 'Please enable location services in device settings';
      } else {
        errorMessage = 'Unknown location error';
        solution = 'Try restarting the app or device';
      }

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Row(
            children: [
              const Icon(Icons.error, color: Colors.red),
              const SizedBox(width: 8),
              const Text('Location Error'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                errorMessage,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const Text('Possible solutions:'),
              const SizedBox(height: 8),
              Text(solution),
              const SizedBox(height: 16),
              const Text(
                'For testing purposes, you can use the Beirut location as a fallback.',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _useFallbackLocation();
              },
              child: const Text('Use Beirut Location'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _getCurrentLocation(); // Retry
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }
  }

  void _addMarker(LatLng position, String title) {
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId('marker_${_markers.length}'),
          position: position,
          infoWindow: InfoWindow(
            title: title,
            snippet:
                '${position.latitude.toStringAsFixed(6)}, ${position.longitude.toStringAsFixed(6)}',
          ),
          icon: title == 'Current Location'
              ? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue)
              : BitmapDescriptor.defaultMarker,
        ),
      );
    });
  }

  void _clearMarkers() {
    setState(() {
      _markers.clear();
      _currentLocation = null;
      _statusMessage = 'Markers cleared. Ready to get location.';
    });
  }

  void _useFallbackLocation() {
    setState(() {
      _currentLocation = _beirutLocation;
      _statusMessage = 'Using fallback location: Beirut, Lebanon';
      _isLoading = false;
    });

    // Add marker for fallback location
    _addMarker(_beirutLocation, 'Fallback Location (Beirut)');

    // Move camera to fallback location
    if (_controller != null) {
      _controller!.animateCamera(
        CameraUpdate.newLatLngZoom(_beirutLocation, 15),
      );
    }

    print(
      '📍 Using fallback location: ${_beirutLocation.latitude}, ${_beirutLocation.longitude}',
    );
  }
}
