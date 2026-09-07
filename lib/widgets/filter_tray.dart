import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../core/theme/app_colors.dart';
import '../controllers/car_controller.dart';

class FilterTray extends StatelessWidget {
  const FilterTray({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CarController>();
    final currencyFormatter = NumberFormat.currency(symbol: '\$', decimalDigits: 0);

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.only(
        top: 12,
        left: 20,
        right: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Center(
              child: Container(
                width: 48,
                height: 5,
                decoration: BoxDecoration(
                  color: AppColors.outlineVariant,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.primaryContainer,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.tune, color: Colors.white, size: 20),
                    ),
                    const SizedBox(width: 12),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Advanced Showroom Filter',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Plus Jakarta Sans',
                            color: AppColors.onSurface,
                          ),
                        ),
                        Text(
                          'Calibrated for Certified Luxury Inventory',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                TextButton(
                  onPressed: controller.resetFilters,
                  child: const Text('Reset All'),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Sort By Section
            const Text(
              'Sort By',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.onSurface),
            ),
            const SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Obx(() {
                final options = [
                  'Recommended',
                  'Price: Low to High',
                  'Price: High to Low',
                  'Lowest Mileage',
                  'Newest Year',
                ];
                return Row(
                  children: options.map((opt) {
                    final isSelected = controller.sortBy.value == opt;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        label: Text(opt),
                        selected: isSelected,
                        onSelected: (val) {
                          if (val) controller.setSortBy(opt);
                        },
                        selectedColor: AppColors.primaryContainer,
                        labelStyle: TextStyle(
                          color: isSelected ? Colors.white : AppColors.onSurface,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  }).toList(),
                );
              }),
            ),
            const SizedBox(height: 24),

            // Body Style Section
            const Text(
              'Body Style',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.onSurface),
            ),
            const SizedBox(height: 10),
            Obx(() {
              final styles = [
                {'name': 'All', 'icon': Icons.directions_car},
                {'name': 'Coupe', 'icon': Icons.speed},
                {'name': 'Sedan', 'icon': Icons.car_rental},
                {'name': 'SUV', 'icon': Icons.airport_shuttle},
                {'name': 'Convertible', 'icon': Icons.wb_sunny},
              ];
              return Wrap(
                spacing: 8,
                runSpacing: 8,
                children: styles.map((s) {
                  final name = s['name'] as String;
                  final icon = s['icon'] as IconData;
                  final isSelected = controller.selectedBodyStyle.value == name;
                  return InkWell(
                    onTap: () => controller.setBodyStyle(name),
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.primaryContainer : AppColors.surfaceContainerLow,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected ? AppColors.primaryContainer : AppColors.outlineVariant,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            icon,
                            size: 16,
                            color: isSelected ? Colors.white : AppColors.onSurfaceVariant,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            name,
                            style: TextStyle(
                              color: isSelected ? Colors.white : AppColors.onSurface,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              );
            }),
            const SizedBox(height: 24),

            // Maximum Price Slider
            Obx(() {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Budget Cap',
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.onSurface),
                      ),
                      Text(
                        'Up to ${currencyFormatter.format(controller.maxPrice.value)}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColors.secondary,
                          fontFamily: 'Plus Jakarta Sans',
                        ),
                      ),
                    ],
                  ),
                  Slider(
                    value: controller.maxPrice.value,
                    min: 50000,
                    max: 200000,
                    divisions: 30,
                    activeColor: AppColors.secondary,
                    inactiveColor: AppColors.surfaceContainerHigh,
                    onChanged: (val) {
                      controller.setMaxPrice(val);
                    },
                  ),
                ],
              );
            }),
            const SizedBox(height: 20),

            // Apply CTA Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                child: Obx(() => Text('View ${controller.filteredCars.length} Verified Vehicles')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
