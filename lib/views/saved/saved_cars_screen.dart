import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/app_colors.dart';
import '../../controllers/car_controller.dart';
import '../../widgets/car_card.dart';

class SavedCarsScreen extends StatelessWidget {
  const SavedCarsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CarController>();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Saved Vehicles & Wishlist'),
        actions: [
          Obx(() => controller.savedCars.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.delete_sweep_outlined),
                  tooltip: 'Clear Wishlist',
                  onPressed: () {
                    controller.savedCars.clear();
                    Get.snackbar('Wishlist Cleared', 'All saved items removed.');
                  },
                )
              : const SizedBox.shrink()),
        ],
      ),
      body: Obx(() {
        final cars = controller.savedCars;

        if (cars.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      color: AppColors.surfaceContainerLow,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.favorite_border, size: 54, color: AppColors.secondary),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Your Wishlist is Empty',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Plus Jakarta Sans',
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Bookmark your dream cars to track price drops, reserve test drives, and receive instant seller availability alerts.',
                    style: TextStyle(fontSize: 13, color: AppColors.onSurfaceVariant),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      // Pre-save 2 cars
                      if (controller.allCars.isNotEmpty) {
                        controller.savedCars.add(controller.allCars.first);
                      }
                    },
                    child: const Text('Explore Showroom'),
                  ),
                ],
              ),
            ),
          );
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Price Drop Notification Banner
              Container(
                padding: const EdgeInsets.all(14),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: AppColors.secondaryContainer.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.secondaryContainer),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.trending_down, color: AppColors.secondary, size: 22),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Active Price Drop Alerts',
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.primaryContainer),
                          ),
                          Text(
                            'You will be notified immediately if any saved vehicle undergoes a certified price adjustment.',
                            style: TextStyle(fontSize: 12, color: AppColors.onSurfaceVariant),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Text(
                '${cars.length} Saved in Showroom',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.onSurface,
                  fontFamily: 'Plus Jakarta Sans',
                ),
              ),
              const SizedBox(height: 12),

              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: cars.length,
                itemBuilder: (context, index) {
                  return CarCard(car: cars[index]);
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}
