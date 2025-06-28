import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:riderapp/screens/trip_history_screen.dart';
import '../providers/auth_provider.dart';
import '../widgets/animated_taxi_road.dart';
import 'trip_request_screen.dart';
import 'about_screen.dart';
// import '../utils/api_test.dart'; // Uncomment when needed
// import '../widgets/simple_test_map.dart'; // Uncomment when needed

// Global navigator key to access context from anywhere
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.local_taxi, size: 24),
            SizedBox(width: 8),
            Text('Ismail Taxi'),
          ],
        ),
        backgroundColor: Colors.amber,
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              // Navigate to profile screen or show profile dialog
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('User Profile'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Email: ${authProvider.user?.email ?? "Not signed in"}',
                      ),
                      const SizedBox(height: 8),
                      const Text('Member since: May 2023'),
                    ],
                  ),
                  actions: [
                    TextButton(
                      child: const Text('Close'),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    TextButton(
                      child: const Text('Sign Out'),
                      onPressed: () {
                        Navigator.of(context).pop();
                        authProvider.signOut();
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Add our custom animated taxi on road
          const AnimatedTaxiRoad(),

          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 12),
                    Text(
                      'Welcome to Ismail Taxi',
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.amber.shade800,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Where do you want to go?',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.grey.shade700,
                      ),
                    ),
                    const SizedBox(height: 30),
                    // Quick destination options
                    _buildDestinationOptions(),
                    const SizedBox(height: 40),
                    // CTA button
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const TripRequestScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber,
                          foregroundColor: Colors.black87,
                          elevation: 4,
                          shadowColor: Colors.amberAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.search_rounded, size: 28),
                            SizedBox(width: 8),
                            Text(
                              'BOOK A TAXI',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Bottom options
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildCircleButton(
                          icon: Icons.history,
                          label: 'My Trips',
                          onPressed: () {
                            // Navigate to trip history screen
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const TripHistoryScreen(),
                              ),
                            );
                          },
                        ),
                        _buildCircleButton(
                          icon: Icons.card_giftcard,
                          label: 'Promotions',
                          onPressed: () {
                            // Navigate to promotions screen
                          },
                        ),
                        _buildCircleButton(
                          icon: Icons.info_outline,
                          label: 'About',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AboutScreen(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    // const SizedBox(height: 20),
                    // // Test API Button
                    // ElevatedButton(
                    //   onPressed: () async {
                    //     ScaffoldMessenger.of(context).showSnackBar(
                    //       const SnackBar(
                    //         content: Text('Testing Google Maps API...'),
                    //       ),
                    //     );

                    //     await ApiTest.runAllTests();

                    //     ScaffoldMessenger.of(context).showSnackBar(
                    //       const SnackBar(
                    //         content: Text(
                    //           'API test completed. Check console for results.',
                    //         ),
                    //       ),
                    //     );
                    //   },
                    //   style: ElevatedButton.styleFrom(
                    //     backgroundColor: Colors.blue,
                    //     foregroundColor: Colors.white,
                    //   ),
                    //   child: const Text('Test Google Maps API'),
                    // ),
                    // const SizedBox(height: 10),
                    // // Simple Map Test Button
                    // ElevatedButton(
                    //   onPressed: () {
                    //     Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //         builder: (context) => const SimpleTestMap(),
                    //       ),
                    //     );
                    //   },
                    //   style: ElevatedButton.styleFrom(
                    //     backgroundColor: Colors.green,
                    //     foregroundColor: Colors.white,
                    //   ),
                    //   child: const Text('Test Simple Map'),
                    // ),
                    // const SizedBox(height: 20),
                    // ElevatedButton(
                    //   onPressed: () {
                    //     // First time, create test drivers
                    //     // firestoreProvider.createTestDrivers();

                    //     // Test the cloud function
                    //     testFindNearbyDriversFunction();
                    //   },
                    //   child: Text('Test Cloud Function'),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDestinationOptions() {
    return Builder(
      builder: (context) => Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildDestinationCard(
                  icon: Icons.flight,
                  title: 'Flight Booking',
                  address: 'Airport transfers',
                  onTap: () => _showComingSoonDialog(context),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildDestinationCard(
                  icon: Icons.hotel,
                  title: 'Hotel',
                  address: 'Hotel transfers',
                  onTap: () => _showComingSoonDialog(context),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildDestinationCard(
                  icon: Icons.shopping_bag,
                  title: 'Shopping',
                  address: 'Mall & Shopping Centers',
                  onTap: () => _showComingSoonDialog(context),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildDestinationCard(
                  icon: Icons.restaurant,
                  title: 'Restaurant',
                  address: 'Food & Dining',
                  onTap: () => _showComingSoonDialog(context),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDestinationCard({
    required IconData icon,
    required String title,
    required String address,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon, color: Colors.amber.shade700, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                address,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCircleButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Icon(icon, color: Colors.amber.shade800, size: 28),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade800),
          ),
        ],
      ),
    );
  }

  // Show "Coming Soon" toast message
  void _showComingSoonDialog(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.info_outline, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            const Expanded(
              child: Text(
                'Coming Soon! This feature is currently under development.',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.amber.shade700,
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  // Add this to your main app to trigger a test trip
  Future<void> testFindNearbyDriversFunction() async {
    try {
      final firestore = FirebaseFirestore.instance;

      // First, create test drivers
      print('Creating test drivers...');
      await _createTestDrivers();

      // Create a test trip with 'searching' status
      final tripData = {
        'pickup': {
          'latitude': 37.7749,
          'longitude': -122.4194,
          'address': '123 Test St, San Francisco, CA',
        },
        'dropoff': {
          'latitude': 37.7833,
          'longitude': -122.4167,
          'address': '456 Demo Ave, San Francisco, CA',
        },
        'distance': 2.5, // km
        'duration': 10, // minutes
        'fare': 15.0, // dollars
        'status': 'searching', // This is crucial
        'createdAt': FieldValue.serverTimestamp(),
        'userId':
            firebase_auth.FirebaseAuth.instance.currentUser?.uid ?? 'test-user',
      };

      print('Creating test trip...');
      final tripRef = await firestore.collection('trips').add(tripData);
      print('Test trip created with ID: ${tripRef.id}');

      // // Listen for updates on this trip
      // tripRef.snapshots().listen((snapshot) {
      //   if (snapshot.exists) {
      //     final data = snapshot.data()!;
      //     print('Trip updated: ${jsonEncode(data)}');

      //     if (data['nearbyDrivers'] != null) {
      //       print('Found nearby drivers: ${data['nearbyDrivers'].length}');

      //       if (data['notifiedDriverId'] != null) {
      //         print('Driver was notified! Function worked!');
      //         _showDriverAcceptDialog(data['notifiedDriverId']);
      //       }
      //     }

      //     if (data['noDriversAvailable'] == true) {
      //       print('No drivers available. Function processed the trip but found no drivers.');
      //     }
      //   }
      // });
    } catch (e) {
      print('Error testing function: $e');
    }
  }

  // Helper method to create test drivers
  Future<void> _createTestDrivers() async {
    try {
      final firestore = FirebaseFirestore.instance;

      // Check if test drivers already exist
      final existingDrivers = await firestore
          .collection('drivers')
          .where('isTestDriver', isEqualTo: true)
          .get();

      if (existingDrivers.docs.isNotEmpty) {
        print(
          'Test drivers already exist (${existingDrivers.docs.length} drivers)',
        );
        return;
      }

      // Create a batch for adding multiple drivers efficiently
      final batch = firestore.batch();

      // Driver 1 - Very close to the pickup location
      final driver1Ref = firestore.collection('drivers').doc('test-driver-1');
      batch.set(driver1Ref, {
        'displayName': 'Test Driver 1',
        'isOnline': true,
        'isAvailable': true,
        'isTestDriver': true,
        'location': {
          'latitude': 37.7751, // Very close to pickup
          'longitude': -122.4196,
        },
        'fcmToken': 'test-token-1',
        'rating': 4.8,
        'carDetails': {
          'model': 'Toyota Camry',
          'color': 'Black',
          'plateNumber': 'TEST-123',
        },
      });

      // Driver 2 - A bit further away
      final driver2Ref = firestore.collection('drivers').doc('test-driver-2');
      batch.set(driver2Ref, {
        'displayName': 'Test Driver 2',
        'isOnline': true,
        'isAvailable': true,
        'isTestDriver': true,
        'location': {
          'latitude': 37.7780, // ~0.5km away
          'longitude': -122.4220,
        },
        'fcmToken': 'test-token-2',
        'rating': 4.5,
        'carDetails': {
          'model': 'Honda Accord',
          'color': 'White',
          'plateNumber': 'TEST-456',
        },
      });

      // Driver 3 - Even further away
      final driver3Ref = firestore.collection('drivers').doc('test-driver-3');
      batch.set(driver3Ref, {
        'displayName': 'Test Driver 3',
        'isOnline': true,
        'isAvailable': true,
        'isTestDriver': true,
        'location': {
          'latitude': 37.7700, // ~1km away
          'longitude': -122.4150,
        },
        'fcmToken': 'test-token-3',
        'rating': 4.9,
        'carDetails': {
          'model': 'Tesla Model 3',
          'color': 'Red',
          'plateNumber': 'TEST-789',
        },
      });

      // Commit the batch
      await batch.commit();
      print('Successfully created 3 test drivers');
    } catch (e) {
      print('Error creating test drivers: $e');
    }
  }
}
