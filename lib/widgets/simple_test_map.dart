import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../config/app_config.dart';

class SimpleTestMap extends StatefulWidget {
  const SimpleTestMap({Key? key}) : super(key: key);

  @override
  State<SimpleTestMap> createState() => _SimpleTestMapState();
}

class _SimpleTestMapState extends State<SimpleTestMap> {
  GoogleMapController? _controller;
  String _status = 'Initializing map...';
  bool _hasError = false;

  // Static location for Beirut, Lebanon
  static const LatLng _center = LatLng(33.8938, 35.5018);

  // Simple marker for testing
  final Set<Marker> _markers = {
    const Marker(
      markerId: MarkerId('beirut'),
      position: _center,
      infoWindow: InfoWindow(title: 'Beirut', snippet: 'Lebanon'),
    ),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple Map Test'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          // Status bar
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            color: _hasError ? Colors.red.shade100 : Colors.green.shade100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      _hasError ? Icons.error : Icons.check_circle,
                      color: _hasError ? Colors.red : Colors.green,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _status,
                      style: TextStyle(
                        color: _hasError ? Colors.red : Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'API Key: ${AppConfig.googleMapsApiKey.substring(0, 20)}...',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                Text(
                  'Bundle ID: com.example.riderapp',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
          // Map
          Expanded(
            child: GoogleMap(
              onMapCreated: (GoogleMapController controller) {
                _controller = controller;
                setState(() {
                  _status = 'Map loaded successfully!';
                  _hasError = false;
                });
                print('✅ Google Map created successfully');
              },
              initialCameraPosition: const CameraPosition(
                target: _center,
                zoom: 14.0,
              ),
              markers: _markers,
              myLocationEnabled: false,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: true,
              mapToolbarEnabled: true,
              compassEnabled: true,
              rotateGesturesEnabled: true,
              scrollGesturesEnabled: true,
              tiltGesturesEnabled: true,
              zoomGesturesEnabled: true,
              onTap: (LatLng position) {
                print('Map tapped at: ${position.latitude}, ${position.longitude}');
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Tapped: ${position.latitude.toStringAsFixed(4)}, ${position.longitude.toStringAsFixed(4)}'),
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'zoom_in',
            onPressed: () {
              _controller?.animateCamera(CameraUpdate.newLatLngZoom(_center, 16.0));
            },
            child: const Icon(Icons.zoom_in),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            heroTag: 'zoom_out',
            onPressed: () {
              _controller?.animateCamera(CameraUpdate.newLatLngZoom(_center, 12.0));
            },
            child: const Icon(Icons.zoom_out),
          ),
        ],
      ),
    );
  }
}
