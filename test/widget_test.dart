import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:car_rental/main.dart';
import 'package:car_rental/controllers/auth_controller.dart';
import 'package:car_rental/controllers/car_controller.dart';
import 'package:car_rental/controllers/booking_controller.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    Get.put(AuthController());
    Get.put(CarController());
    Get.put(BookingController());

    await tester.pumpWidget(const AutoEliteApp());
    expect(find.byType(AutoEliteApp), findsOneWidget);
  });
}
