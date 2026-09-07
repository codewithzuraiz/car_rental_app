import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import '../../core/theme/app_colors.dart';
import '../../controllers/car_controller.dart';
import 'add_car_wizard_screen.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  String _selectedTab = 'All';

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CarController>();
    final currencyFormatter = NumberFormat.currency(symbol: '\$', decimalDigits: 0);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Inventory Management'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Add Car',
            onPressed: () => Get.to(() => const AddCarWizardScreen()),
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter Tabs
          Container(
            color: AppColors.surface,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: ['All', 'Available', 'Under Escrow', 'Pending Moderation'].map((tab) {
                  final isSelected = _selectedTab == tab;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(tab),
                      selected: isSelected,
                      onSelected: (val) {
                        setState(() {
                          _selectedTab = tab;
                        });
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
              ),
            ),
          ),

          // Inventory Car List
          Expanded(
            child: Obx(() {
              final cars = controller.allCars;

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: cars.length,
                itemBuilder: (context, index) {
                  final car = cars[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.outlineVariant),
                      boxShadow: const [AppColors.cardShadow],
                    ),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                imageUrl: car.images.isNotEmpty ? car.images.first : '',
                                width: 90,
                                height: 65,
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
                                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    currencyFormatter.format(car.price),
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800,
                                      color: AppColors.primaryContainer,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: AppColors.successContainer,
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        child: Text(
                                          car.status,
                                          style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: AppColors.success),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        '${car.inspectionScore}/100 Score',
                                        style: const TextStyle(fontSize: 11, color: AppColors.onSurfaceVariant),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        const Divider(color: AppColors.divider, height: 1),
                        const SizedBox(height: 8),

                        // Action Controls
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.person_pin, size: 16, color: AppColors.secondary),
                                const SizedBox(width: 4),
                                Text(
                                  '${(index * 3) + 2} Qualified Inquiries',
                                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.onSurface),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Get.snackbar('Price Adjustment', 'Updated certified price for ${car.title}');
                                  },
                                  child: const Text('Edit Price', style: TextStyle(fontSize: 12)),
                                ),
                                OutlinedButton(
                                  onPressed: () {
                                    Get.snackbar('Status', '${car.title} marked as Sold.');
                                  },
                                  style: OutlinedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                    minimumSize: Size.zero,
                                  ),
                                  child: const Text('Mark Sold', style: TextStyle(fontSize: 11)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Get.to(() => const AddCarWizardScreen()),
        backgroundColor: AppColors.primaryContainer,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('Add Vehicle', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
