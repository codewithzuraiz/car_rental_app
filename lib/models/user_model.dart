class UserModel {
  final String uid;
  final String email;
  final String name;
  final String phone;
  final String avatarUrl;
  final String role; // "Buyer", "Seller", "Admin"
  final String kycStatus; // "Tier 2 Verified", "Pending", "Unverified"
  final int savedCarsCount;
  final int activeBookingsCount;

  UserModel({
    required this.uid,
    required this.email,
    required this.name,
    required this.phone,
    required this.avatarUrl,
    this.role = "Buyer",
    this.kycStatus = "Tier 2 Verified",
    this.savedCarsCount = 5,
    this.activeBookingsCount = 2,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'phone': phone,
      'avatarUrl': avatarUrl,
      'role': role,
      'kycStatus': kycStatus,
      'savedCarsCount': savedCarsCount,
      'activeBookingsCount': activeBookingsCount,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map, String docId) {
    return UserModel(
      uid: docId,
      email: map['email'] ?? '',
      name: map['name'] ?? 'Alex Mitchell',
      phone: map['phone'] ?? '+1 (310) 982-1204',
      avatarUrl: map['avatarUrl'] ??
          'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=400&q=80',
      role: map['role'] ?? 'Buyer',
      kycStatus: map['kycStatus'] ?? 'Tier 2 Verified',
      savedCarsCount: (map['savedCarsCount'] ?? 0).toInt(),
      activeBookingsCount: (map['activeBookingsCount'] ?? 0).toInt(),
    );
  }
}
