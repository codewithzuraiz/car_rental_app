import 'package:get/get.dart';
import '../models/car_model.dart';
import '../services/firebase_service.dart';

class CarController extends GetxController {
  final FirebaseService _service = FirebaseService();

  final RxList<CarModel> allCars = <CarModel>[].obs;
  final RxList<CarModel> filteredCars = <CarModel>[].obs;
  final RxList<CarModel> savedCars = <CarModel>[].obs;
  final RxList<CarModel> compareCars = <CarModel>[].obs;

  final RxString searchQuery = ''.obs;
  final RxString selectedMake = 'All'.obs;
  final RxString selectedBodyStyle = 'All'.obs;
  final RxDouble maxPrice = 200000.0.obs;
  final RxString sortBy = 'Recommended'.obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadCars();
  }

  Future<void> loadCars() async {
    isLoading.value = true;
    try {
      final cars = await _service.getCars();
      allCars.assignAll(cars);
      // Pre-save 2 cars for initial demo
      if (cars.length >= 2 && savedCars.isEmpty) {
        savedCars.addAll([cars[0], cars[1]]);
      }
      applyFilters();
    } finally {
      isLoading.value = false;
    }
  }

  void setSearchQuery(String query) {
    searchQuery.value = query;
    applyFilters();
  }

  void setMake(String make) {
    selectedMake.value = make;
    applyFilters();
  }

  void setBodyStyle(String style) {
    selectedBodyStyle.value = style;
    applyFilters();
  }

  void setMaxPrice(double price) {
    maxPrice.value = price;
    applyFilters();
  }

  void setSortBy(String sort) {
    sortBy.value = sort;
    applyFilters();
  }

  void resetFilters() {
    searchQuery.value = '';
    selectedMake.value = 'All';
    selectedBodyStyle.value = 'All';
    maxPrice.value = 200000.0;
    sortBy.value = 'Recommended';
    applyFilters();
  }

  void applyFilters() {
    var list = allCars.where((car) {
      final matchQuery = searchQuery.value.isEmpty ||
          car.title.toLowerCase().contains(searchQuery.value.toLowerCase()) ||
          car.make.toLowerCase().contains(searchQuery.value.toLowerCase()) ||
          car.model.toLowerCase().contains(searchQuery.value.toLowerCase());

      final matchMake = selectedMake.value == 'All' || car.make.toLowerCase() == selectedMake.value.toLowerCase();
      final matchBody = selectedBodyStyle.value == 'All' || car.bodyStyle.toLowerCase() == selectedBodyStyle.value.toLowerCase();
      final matchPrice = car.price <= maxPrice.value;

      return matchQuery && matchMake && matchBody && matchPrice;
    }).toList();

    if (sortBy.value == 'Price: Low to High') {
      list.sort((a, b) => a.price.compareTo(b.price));
    } else if (sortBy.value == 'Price: High to Low') {
      list.sort((a, b) => b.price.compareTo(a.price));
    } else if (sortBy.value == 'Lowest Mileage') {
      list.sort((a, b) => a.mileage.compareTo(b.mileage));
    } else if (sortBy.value == 'Newest Year') {
      list.sort((a, b) => b.year.compareTo(a.year));
    }

    filteredCars.assignAll(list);
  }

  void toggleSave(CarModel car) {
    if (isSaved(car)) {
      savedCars.removeWhere((c) => c.id == car.id);
      Get.snackbar(
        'Removed from Wishlist',
        '${car.title} was removed.',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
    } else {
      savedCars.add(car);
      Get.snackbar(
        'Saved to Wishlist',
        '${car.title} is now in your saved showroom.',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
    }
  }

  bool isSaved(CarModel car) {
    return savedCars.any((c) => c.id == car.id);
  }

  void toggleCompare(CarModel car) {
    if (isCompared(car)) {
      compareCars.removeWhere((c) => c.id == car.id);
    } else {
      if (compareCars.length >= 3) {
        Get.snackbar(
          'Comparison Limit',
          'You can compare up to 3 vehicles at a time.',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }
      compareCars.add(car);
      Get.snackbar(
        'Added to Comparison',
        '${car.title} added.',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
    }
  }

  bool isCompared(CarModel car) {
    return compareCars.any((c) => c.id == car.id);
  }
}
