import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import '../../core/theme/app_colors.dart';
import '../../models/car_model.dart';
import '../../controllers/booking_controller.dart';
import '../../controllers/auth_controller.dart';

class TestDriveScreen extends StatelessWidget {
  final CarModel car;

  const TestDriveScreen({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    final bookingController = Get.put(BookingController());
    final authController = Get.find<AuthController>();
    final currencyFormatter = NumberFormat.currency(symbol: '\$', decimalDigits: 0);

    final nameController = TextEditingController(text: authController.currentUser.value.name);
    final phoneController = TextEditingController(text: authController.currentUser.value.phone);
    final addressController = TextEditingController(text: '9440 Wilshire Blvd, Beverly Hills, CA');

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Schedule VIP Test Drive'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Vehicle Snapshot Card
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.outlineVariant),
                boxShadow: const [AppColors.cardShadow],
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: car.images.isNotEmpty ? car.images.first : '',
                      width: 80,
                      height: 56,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          car.title,
                          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, fontFamily: 'Plus Jakarta Sans'),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          currencyFormatter.format(car.price),
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: AppColors.primaryContainer),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Seller: ${car.sellerName}',
                          style: const TextStyle(fontSize: 11, color: AppColors.onSurfaceVariant),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Step 1: Select Date
            const Text(
              '1. Select Appointment Date',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.onSurface),
            ),
            const SizedBox(height: 10),
            Obx(() {
              final dates = [
                'Today, 3:00 PM',
                'Tomorrow, 10:30 AM',
                'Saturday, 11:00 AM',
                'Sunday, 2:00 PM',
              ];
              return Wrap(
                spacing: 8,
                runSpacing: 8,
                children: dates.map((d) {
                  final isSelected = bookingController.selectedDate.value == d;
                  return ChoiceChip(
                    label: Text(d),
                    selected: isSelected,
                    onSelected: (val) {
                      if (val) bookingController.selectedDate.value = d;
                    },
                    selectedColor: AppColors.primaryContainer,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : AppColors.onSurface,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  );
                }).toList(),
              );
            }),
            const SizedBox(height: 24),

            // Step 2: Time Slot
            const Text(
              '2. Select Preferred Time Window',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.onSurface),
            ),
            const SizedBox(height: 10),
            Obx(() {
              final slots = [
                '10:00 AM - 11:00 AM',
                '11:30 AM - 12:30 PM',
                '2:00 PM - 3:00 PM',
                '4:30 PM - 5:30 PM',
              ];
              return Column(
                children: slots.map((s) {
                  final isSelected = bookingController.selectedTimeSlot.value == s;
                  return InkWell(
                    onTap: () => bookingController.selectedTimeSlot.value = s,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.secondaryContainer.withValues(alpha: 0.15) : AppColors.surface,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected ? AppColors.secondary : AppColors.outlineVariant,
                          width: isSelected ? 1.5 : 1,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            s,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                              color: isSelected ? AppColors.secondary : AppColors.onSurface,
                            ),
                          ),
                          Icon(
                            isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
                            color: isSelected ? AppColors.secondary : AppColors.outline,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              );
            }),
            const SizedBox(height: 24),

            // Step 3: Location / Delivery Type
            const Text(
              '3. Delivery or Dealership Location',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.onSurface),
            ),
            const SizedBox(height: 10),
            Obx(() {
              final deliveryTypes = [
                {'type': 'Dealership VIP Showroom', 'desc': 'Private inspection lounge & track testing'},
                {'type': 'Concierge Home Delivery', 'desc': 'Vehicle delivered to your doorstep by specialist'},
              ];
              return Column(
                children: deliveryTypes.map((t) {
                  final type = t['type'] as String;
                  final desc = t['desc'] as String;
                  final isSelected = bookingController.selectedDeliveryType.value == type;
                  return InkWell(
                    onTap: () => bookingController.selectedDeliveryType.value = type,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.primaryContainer : AppColors.surface,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected ? AppColors.primaryContainer : AppColors.outlineVariant,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            type.contains('Home') ? Icons.home_work : Icons.storefront,
                            color: isSelected ? Colors.white : AppColors.secondary,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  type,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: isSelected ? Colors.white : AppColors.onSurface,
                                  ),
                                ),
                                Text(
                                  desc,
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: isSelected ? Colors.white70 : AppColors.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            isSelected ? Icons.check_circle : Icons.circle_outlined,
                            color: isSelected ? AppColors.secondaryContainer : AppColors.outline,
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              );
            }),
            const SizedBox(height: 24),

            // Step 4: Contact & Verification
            const Text(
              '4. Driver Verification & Contact Details',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.onSurface),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.outlineVariant),
              ),
              child: Column(
                children: [
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(labelText: 'Full Name', prefixIcon: Icon(Icons.person)),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: phoneController,
                    decoration: const InputDecoration(labelText: 'Phone Number', prefixIcon: Icon(Icons.phone)),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: addressController,
                    decoration: const InputDecoration(labelText: 'Delivery/Pickup Address', prefixIcon: Icon(Icons.location_on)),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.successContainer,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.shield, color: AppColors.success, size: 20),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Valid Driver\'s License Verified for Luxury Fleet Test Drives',
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF065F46)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Submit Button
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () async {
                  await bookingController.bookTestDrive(
                    car: car,
                    name: nameController.text,
                    phone: phoneController.text,
                    address: addressController.text,
                  );
                  Get.defaultDialog(
                    title: 'Appointment Confirmed! 🚗',
                    titleStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, fontFamily: 'Plus Jakarta Sans'),
                    middleText:
                        'Your test drive for ${car.title} is confirmed for ${bookingController.selectedDate.value}.\nOur showroom team will welcome you at ${addressController.text}.',
                    textConfirm: 'Done',
                    confirmTextColor: Colors.white,
                    buttonColor: AppColors.secondary,
                    onConfirm: () {
                      Get.back();
                      Get.back();
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondary,
                ),
                child: const Text('Confirm VIP Test Drive Reservation', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
