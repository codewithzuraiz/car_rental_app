import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';
import 'core/theme/app_theme.dart';
import 'controllers/car_controller.dart';
import 'controllers/auth_controller.dart';
import 'controllers/booking_controller.dart';
import 'views/navigation/main_nav_scaffold.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    debugPrint('Firebase init notice: $e');
  }

  // Register core GetX controllers
  Get.put(AuthController());
  Get.put(CarController());
  Get.put(BookingController());

  runApp(const AutoEliteApp());
}

class AutoEliteApp extends StatelessWidget {
  const AutoEliteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'AutoElite - Luxury Marketplace',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const MainNavScaffold(),
    );
  }
}
