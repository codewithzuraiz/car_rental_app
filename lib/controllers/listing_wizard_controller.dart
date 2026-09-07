import 'package:get/get.dart';
import '../models/car_model.dart';
import '../services/firebase_service.dart';
import 'car_controller.dart';

class ListingWizardController extends GetxController {
  final FirebaseService _service = FirebaseService();

  final RxInt currentStep = 0.obs;

  // Form Fields
  final RxString vin = 'WBA33AY08PFP99182'.obs;
  final RxString make = 'BMW'.obs;
  final RxString model = 'M3 CS'.obs;
  final RxInt year = 2024.obs;
  final RxString bodyStyle = 'Sedan'.obs;
  final RxInt mileage = 1200.obs;

  final RxString transmission = 'Automatic'.obs;
  final RxString fuelType = 'Petrol'.obs;
  final RxInt horsePower = 543.obs;
  final RxString acceleration = '3.2s (0-60)'.obs;
  final RxString topSpeed = '188 mph'.obs;

  final RxString imageUrl = 'https://images.unsplash.com/photo-1607860108855-64acf2078ed9?auto=format&fit=crop&w=1200&q=80'.obs;
  final RxDouble price = 118000.0.obs;
  final RxBool enableEscrow = true.obs;

  void nextStep() {
    if (currentStep.value < 3) {
      currentStep.value++;
    }
  }

  void prevStep() {
    if (currentStep.value > 0) {
      currentStep.value--;
    }
  }

  Future<bool> publishListing() async {
    final newCar = CarModel(
      id: 'car_${DateTime.now().millisecondsSinceEpoch}',
      title: '${year.value} ${make.value} ${model.value}',
      make: make.value,
      model: model.value,
      year: year.value,
      price: price.value,
      emi: (price.value / 72),
      mileage: mileage.value,
      bodyStyle: bodyStyle.value,
      fuelType: fuelType.value,
      transmission: transmission.value,
      horsePower: horsePower.value,
      acceleration: acceleration.value,
      topSpeed: topSpeed.value,
      location: 'Los Angeles, CA',
      images: [imageUrl.value],
      isCertified: true,
      inspectionScore: 99,
      sellerName: 'AutoElite Certified Dealership',
      sellerType: 'Certified Dealer',
      sellerRating: 4.9,
      vin: vin.value,
      status: 'Available',
      isFeatured: true,
    );

    await _service.addCar(newCar);
    final carController = Get.find<CarController>();
    carController.allCars.insert(0, newCar);
    carController.applyFilters();
    return true;
  }
}
