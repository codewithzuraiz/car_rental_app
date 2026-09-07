import 'package:get/get.dart';
import '../models/booking_model.dart';
import '../models/car_model.dart';
import '../services/firebase_service.dart';
import '../services/dummy_data_seeder.dart';

class BookingController extends GetxController {
  final FirebaseService _service = FirebaseService();
  final RxList<BookingModel> bookings = <BookingModel>[].obs;

  final RxString selectedDate = 'Tomorrow, 10:30 AM'.obs;
  final RxString selectedTimeSlot = '10:30 AM - 11:30 AM'.obs;
  final RxString selectedDeliveryType = 'Dealership VIP Showroom'.obs;
  final RxBool hasDriversLicenseVerified = true.obs;

  @override
  void onInit() {
    super.onInit();
    bookings.assignAll(DummyDataSeeder.initialBookings);
  }

  Future<bool> bookTestDrive({
    required CarModel car,
    required String name,
    required String phone,
    required String address,
  }) async {
    final newBooking = BookingModel(
      id: 'booking_${DateTime.now().millisecondsSinceEpoch}',
      carId: car.id,
      carTitle: car.title,
      carImage: car.images.isNotEmpty ? car.images.first : '',
      carPrice: car.price,
      buyerName: name,
      buyerPhone: phone,
      buyerEmail: 'alex.mitchell@luxurymail.com',
      date: selectedDate.value,
      timeSlot: selectedTimeSlot.value,
      deliveryType: selectedDeliveryType.value,
      address: address.isEmpty ? '9440 Wilshire Blvd, Beverly Hills, CA' : address,
      status: 'Confirmed',
      createdAt: DateTime.now(),
    );

    bookings.insert(0, newBooking);
    await _service.createBooking(newBooking);
    return true;
  }
}
