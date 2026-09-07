import 'package:get/get.dart';
import '../models/user_model.dart';
import '../services/dummy_data_seeder.dart';

class AuthController extends GetxController {
  final Rx<UserModel> currentUser = DummyDataSeeder.defaultBuyer.obs;
  final RxBool isLoggedIn = true.obs;

  void upgradeKyc() {
    currentUser.value = UserModel(
      uid: currentUser.value.uid,
      email: currentUser.value.email,
      name: currentUser.value.name,
      phone: currentUser.value.phone,
      avatarUrl: currentUser.value.avatarUrl,
      role: currentUser.value.role,
      kycStatus: 'Tier 3 VIP Verified',
      savedCarsCount: currentUser.value.savedCarsCount,
      activeBookingsCount: currentUser.value.activeBookingsCount,
    );
    Get.snackbar(
      'KYC Verified',
      'Your account is now Tier 3 VIP Verified for high-value escrow.',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
