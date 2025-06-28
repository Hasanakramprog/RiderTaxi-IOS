class RideRequest {
  final String id;
  final String pickupLocation;
  final String dropoffLocation;
  final String userId;
  final String status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  RideRequest({
    required this.id,
    required this.pickupLocation,
    required this.dropoffLocation,
    required this.userId,
    required this.status,
    this.createdAt,
    this.updatedAt,
  });

  // Create RideRequest from Firestore document
  factory RideRequest.fromFirestore(Map<String, dynamic> data, String id) {
    return RideRequest(
      id: id,
      pickupLocation: data['pickupLocation'] ?? '',
      dropoffLocation: data['dropoffLocation'] ?? '',
      userId: data['userId'] ?? '',
      status: data['status'] ?? 'pending',
      createdAt: data['createdAt']?.toDate(),
      updatedAt: data['updatedAt']?.toDate(),
    );
  }

  // Convert RideRequest to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'pickupLocation': pickupLocation,
      'dropoffLocation': dropoffLocation,
      'userId': userId,
      'status': status,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  // Create a copy with updated fields
  RideRequest copyWith({
    String? id,
    String? pickupLocation,
    String? dropoffLocation,
    String? userId,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return RideRequest(
      id: id ?? this.id,
      pickupLocation: pickupLocation ?? this.pickupLocation,
      dropoffLocation: dropoffLocation ?? this.dropoffLocation,
      userId: userId ?? this.userId,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  String toString() {
    return 'RideRequest(id: $id, pickup: $pickupLocation, dropoff: $dropoffLocation, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RideRequest &&
        other.id == id &&
        other.pickupLocation == pickupLocation &&
        other.dropoffLocation == dropoffLocation &&
        other.userId == userId &&
        other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        pickupLocation.hashCode ^
        dropoffLocation.hashCode ^
        userId.hashCode ^
        status.hashCode;
  }
}
