import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import '../../core/theme/app_colors.dart';
import '../../controllers/car_controller.dart';
import '../../models/car_model.dart';
import 'car_detail_screen.dart';

class CompareScreen extends StatelessWidget {
  const CompareScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CarController>();
    final currencyFormatter = NumberFormat.currency(symbol: '\$', decimalDigits: 0);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Compare Vehicles'),
        actions: [
          Obx(() => controller.compareCars.isNotEmpty
              ? TextButton(
                  onPressed: () => controller.compareCars.clear(),
                  child: const Text('Clear All'),
                )
              : const SizedBox.shrink()),
        ],
      ),
      body: Obx(() {
        final cars = controller.compareCars;

        if (cars.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceContainerLow,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.compare_arrows, size: 54, color: AppColors.secondary),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'No Vehicles Selected for Comparison',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Plus Jakarta Sans',
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Tap the "Compare" button on any vehicle in the showroom to inspect telemetry and specs side-by-side.',
                    style: TextStyle(fontSize: 13, color: AppColors.onSurfaceVariant),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      // Seed with 2 cars to demonstrate immediately
                      if (controller.allCars.length >= 2) {
                        controller.compareCars.addAll([controller.allCars[0], controller.allCars[1]]);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(200, 48),
                    ),
                    child: const Text('Compare Sample Vehicles'),
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
              // Vehicle Header Cards (Horizontal scroll)
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: cars.map((car) {
                    return Container(
                      width: 200,
                      margin: const EdgeInsets.only(right: 12),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.outlineVariant),
                        boxShadow: const [AppColors.cardShadow],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                                child: AspectRatio(
                                  aspectRatio: 16 / 10,
                                  child: CachedNetworkImage(
                                    imageUrl: car.images.isNotEmpty ? car.images.first : '',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 6,
                                right: 6,
                                child: GestureDetector(
                                  onTap: () => controller.toggleCompare(car),
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: const BoxDecoration(
                                      color: Colors.black54,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(Icons.close, size: 14, color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  car.title,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Plus Jakarta Sans',
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  currencyFormatter.format(car.price),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.primaryContainer,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                SizedBox(
                                  width: double.infinity,
                                  child: OutlinedButton(
                                    onPressed: () => Get.to(() => CarDetailScreen(car: car)),
                                    style: OutlinedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(vertical: 4),
                                      minimumSize: Size.zero,
                                    ),
                                    child: const Text('View', style: TextStyle(fontSize: 12)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 24),

              // Comparison Specs Matrix
              const Text(
                'Comparative Telemetry Matrix',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: AppColors.onSurface),
              ),
              const SizedBox(height: 12),

              _buildComparisonRow('Horsepower', cars, (c) => '${c.horsePower} HP'),
              _buildComparisonRow('0-60 Acceleration', cars, (c) => c.acceleration),
              _buildComparisonRow('Top Speed', cars, (c) => c.topSpeed),
              _buildComparisonRow('Mileage', cars, (c) => '${c.mileage} mi'),
              _buildComparisonRow('Transmission', cars, (c) => c.transmission),
              _buildComparisonRow('Fuel Type', cars, (c) => c.fuelType),
              _buildComparisonRow('Inspection Score', cars, (c) => '${c.inspectionScore}/100'),
              _buildComparisonRow('Body Style', cars, (c) => c.bodyStyle),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildComparisonRow(String metric, List<CarModel> cars, String Function(CarModel) extractor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            metric,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.onSurfaceVariant),
          ),
          const SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: cars.map((c) {
                return Container(
                  width: 200,
                  margin: const EdgeInsets.only(right: 12),
                  child: Text(
                    extractor(c),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.onSurface,
                      fontFamily: 'Plus Jakarta Sans',
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
