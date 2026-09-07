class BookingModel {
  final String id;
  final String carId;
  final String carTitle;
  final String carImage;
  final double carPrice;
  final String buyerName;
  final String buyerPhone;
  final String buyerEmail;
  final String date;
  final String timeSlot;
  final String deliveryType; // "Dealership Pickup" or "Home Delivery"
  final String address;
  final String status; // "Confirmed", "Pending Approval", "Completed", "Cancelled"
  final DateTime createdAt;

  BookingModel({
    required this.id,
    required this.carId,
    required this.carTitle,
    required this.carImage,
    required this.carPrice,
    required this.buyerName,
    required this.buyerPhone,
    required this.buyerEmail,
    required this.date,
    required this.timeSlot,
    required this.deliveryType,
    required this.address,
    this.status = "Confirmed",
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'carId': carId,
      'carTitle': carTitle,
      'carImage': carImage,
      'carPrice': carPrice,
      'buyerName': buyerName,
      'buyerPhone': buyerPhone,
      'buyerEmail': buyerEmail,
      'date': date,
      'timeSlot': timeSlot,
      'deliveryType': deliveryType,
      'address': address,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory BookingModel.fromMap(Map<String, dynamic> map, String docId) {
    return BookingModel(
      id: docId,
      carId: map['carId'] ?? '',
      carTitle: map['carTitle'] ?? '',
      carImage: map['carImage'] ?? '',
      carPrice: (map['carPrice'] ?? 0).toDouble(),
      buyerName: map['buyerName'] ?? '',
      buyerPhone: map['buyerPhone'] ?? '',
      buyerEmail: map['buyerEmail'] ?? '',
      date: map['date'] ?? '',
      timeSlot: map['timeSlot'] ?? '',
      deliveryType: map['deliveryType'] ?? 'Dealership Pickup',
      address: map['address'] ?? '',
      status: map['status'] ?? 'Confirmed',
      createdAt: map['createdAt'] != null
          ? DateTime.tryParse(map['createdAt']) ?? DateTime.now()
          : DateTime.now(),
    );
  }
}
