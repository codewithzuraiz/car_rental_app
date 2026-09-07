class CarModel {
  final String id;
  final String title;
  final String make;
  final String model;
  final int year;
  final double price;
  final double emi;
  final int mileage;
  final String bodyStyle;
  final String fuelType;
  final String transmission;
  final int horsePower;
  final String acceleration;
  final String topSpeed;
  final String location;
  final List<String> images;
  final bool isCertified;
  final int inspectionScore;
  final List<String> inspectionHighlights;
  final String sellerName;
  final String sellerType;
  final double sellerRating;
  final String sellerPhone;
  final String vin;
  final String status;
  final bool isFeatured;

  CarModel({
    required this.id,
    required this.title,
    required this.make,
    required this.model,
    required this.year,
    required this.price,
    required this.emi,
    required this.mileage,
    required this.bodyStyle,
    required this.fuelType,
    required this.transmission,
    required this.horsePower,
    required this.acceleration,
    required this.topSpeed,
    required this.location,
    required this.images,
    this.isCertified = true,
    this.inspectionScore = 96,
    this.inspectionHighlights = const [
      "Engine & Transmission 100% Passed",
      "Factory OEM Brakes & Suspension",
      "Zero Accident History Reported",
      "Full Dealer Service Records",
    ],
    required this.sellerName,
    this.sellerType = "Certified Dealer",
    this.sellerRating = 4.9,
    this.sellerPhone = "+1 (310) 555-0199",
    required this.vin,
    this.status = "Available",
    this.isFeatured = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'make': make,
      'model': model,
      'year': year,
      'price': price,
      'emi': emi,
      'mileage': mileage,
      'bodyStyle': bodyStyle,
      'fuelType': fuelType,
      'transmission': transmission,
      'horsePower': horsePower,
      'acceleration': acceleration,
      'topSpeed': topSpeed,
      'location': location,
      'images': images,
      'isCertified': isCertified,
      'inspectionScore': inspectionScore,
      'inspectionHighlights': inspectionHighlights,
      'sellerName': sellerName,
      'sellerType': sellerType,
      'sellerRating': sellerRating,
      'sellerPhone': sellerPhone,
      'vin': vin,
      'status': status,
      'isFeatured': isFeatured,
    };
  }

  factory CarModel.fromMap(Map<String, dynamic> map, String docId) {
    return CarModel(
      id: docId,
      title: map['title'] ?? '',
      make: map['make'] ?? '',
      model: map['model'] ?? '',
      year: (map['year'] ?? 2024).toInt(),
      price: (map['price'] ?? 0).toDouble(),
      emi: (map['emi'] ?? (map['price'] ?? 0) / 72).toDouble(),
      mileage: (map['mileage'] ?? 0).toInt(),
      bodyStyle: map['bodyStyle'] ?? 'Sedan',
      fuelType: map['fuelType'] ?? 'Petrol',
      transmission: map['transmission'] ?? 'Automatic',
      horsePower: (map['horsePower'] ?? 400).toInt(),
      acceleration: map['acceleration'] ?? '4.0s',
      topSpeed: map['topSpeed'] ?? '160 mph',
      location: map['location'] ?? 'Los Angeles, CA',
      images: List<String>.from(map['images'] ?? []),
      isCertified: map['isCertified'] ?? true,
      inspectionScore: (map['inspectionScore'] ?? 95).toInt(),
      inspectionHighlights: List<String>.from(map['inspectionHighlights'] ?? []),
      sellerName: map['sellerName'] ?? 'AutoElite Showroom',
      sellerType: map['sellerType'] ?? 'Certified Dealer',
      sellerRating: (map['sellerRating'] ?? 4.8).toDouble(),
      sellerPhone: map['sellerPhone'] ?? '+1 (310) 555-0199',
      vin: map['vin'] ?? 'WBA33AY08PFP12345',
      status: map['status'] ?? 'Available',
      isFeatured: map['isFeatured'] ?? false,
    );
  }
}
