class OfferModel {
  final String id;
  final String carId;
  final String carTitle;
  final double listedPrice;
  final double offerAmount;
  final double? counterAmount;
  final String buyerId;
  final String buyerName;
  final String sellerId;
  final String status; // "Pending", "Accepted", "Countered", "Declined"
  final DateTime updatedAt;

  OfferModel({
    required this.id,
    required this.carId,
    required this.carTitle,
    required this.listedPrice,
    required this.offerAmount,
    this.counterAmount,
    required this.buyerId,
    required this.buyerName,
    required this.sellerId,
    this.status = "Pending",
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'carId': carId,
      'carTitle': carTitle,
      'listedPrice': listedPrice,
      'offerAmount': offerAmount,
      'counterAmount': counterAmount,
      'buyerId': buyerId,
      'buyerName': buyerName,
      'sellerId': sellerId,
      'status': status,
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory OfferModel.fromMap(Map<String, dynamic> map, String docId) {
    return OfferModel(
      id: docId,
      carId: map['carId'] ?? '',
      carTitle: map['carTitle'] ?? '',
      listedPrice: (map['listedPrice'] ?? 0).toDouble(),
      offerAmount: (map['offerAmount'] ?? 0).toDouble(),
      counterAmount: map['counterAmount'] != null ? (map['counterAmount']).toDouble() : null,
      buyerId: map['buyerId'] ?? '',
      buyerName: map['buyerName'] ?? '',
      sellerId: map['sellerId'] ?? '',
      status: map['status'] ?? 'Pending',
      updatedAt: map['updatedAt'] != null
          ? DateTime.tryParse(map['updatedAt']) ?? DateTime.now()
          : DateTime.now(),
    );
  }
}
