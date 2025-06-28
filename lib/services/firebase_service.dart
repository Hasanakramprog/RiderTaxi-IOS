import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = 'counter';
  final String _documentId = 'main_counter';

  // Get current counter value
  Future<int> getCounter() async {
    try {
      DocumentSnapshot doc = await _firestore
          .collection(_collection)
          .doc(_documentId)
          .get();

      if (doc.exists) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return data['value'] ?? 0;
      } else {
        // Initialize with 0 if document doesn't exist
        await updateCounter(0);
        return 0;
      }
    } catch (e) {
      throw Exception('Failed to get counter: $e');
    }
  }

  // Update counter value
  Future<void> updateCounter(int value) async {
    try {
      await _firestore.collection(_collection).doc(_documentId).set({
        'value': value,
        'lastUpdated': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Failed to update counter: $e');
    }
  }

  // Get real-time counter updates
  Stream<QuerySnapshot> getCounterStream() {
    return _firestore
        .collection(_collection)
        .where(FieldPath.documentId, isEqualTo: _documentId)
        .snapshots();
  }

  // Add a new ride request (example for future taxi functionality)
  Future<String> addRideRequest({
    required String pickupLocation,
    required String dropoffLocation,
    required String userId,
  }) async {
    try {
      DocumentReference docRef = await _firestore
          .collection('ride_requests')
          .add({
            'pickupLocation': pickupLocation,
            'dropoffLocation': dropoffLocation,
            'userId': userId,
            'status': 'pending',
            'createdAt': FieldValue.serverTimestamp(),
          });
      return docRef.id;
    } catch (e) {
      throw Exception('Failed to add ride request: $e');
    }
  }

  // Get ride requests stream (example for future taxi functionality)
  Stream<QuerySnapshot> getRideRequestsStream({String? userId}) {
    Query query = _firestore.collection('ride_requests');

    if (userId != null) {
      query = query.where('userId', isEqualTo: userId);
    }

    return query.orderBy('createdAt', descending: true).snapshots();
  }

  // Update ride status (example for future taxi functionality)
  Future<void> updateRideStatus(String rideId, String status) async {
    try {
      await _firestore.collection('ride_requests').doc(rideId).update({
        'status': status,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Failed to update ride status: $e');
    }
  }
}
