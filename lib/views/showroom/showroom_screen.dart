import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/app_colors.dart';
import '../../controllers/car_controller.dart';
import '../../widgets/car_card.dart';
import '../../widgets/filter_tray.dart';

class ShowroomScreen extends StatelessWidget {
  const ShowroomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CarController>();
    final searchInputController = TextEditingController();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        titleSpacing: 16,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppColors.primaryContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.directions_car, color: Colors.white, size: 18),
            ),
            const SizedBox(width: 8),
            const Text(
              'AutoElite',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w800,
                color: AppColors.primaryContainer,
                fontFamily: 'Plus Jakarta Sans',
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerLow,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                children: [
                  Icon(Icons.location_on, size: 12, color: AppColors.secondary),
                  SizedBox(width: 2),
                  Text(
                    'Los Angeles, CA',
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.onSurfaceVariant),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.snackbar('Notifications', 'You have no new alerts.');
            },
            icon: const Stack(
              children: [
                Icon(Icons.notifications_outlined, color: AppColors.onSurface),
                Positioned(
                  right: 0,
                  top: 0,
                  child: CircleAvatar(radius: 4, backgroundColor: AppColors.secondary),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => controller.loadCars(),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Bar & Filter Button
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppColors.surfaceContainerLow,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.outlineVariant),
                      ),
                      child: TextField(
                        controller: searchInputController,
                        onChanged: (val) => controller.setSearchQuery(val),
                        decoration: InputDecoration(
                          hintText: 'Make, model, or body style...',
                          prefixIcon: const Icon(Icons.search, color: AppColors.secondary, size: 22),
                          suffixIcon: Obx(() => controller.searchQuery.isNotEmpty
                              ? IconButton(
                                  icon: const Icon(Icons.clear, size: 18),
                                  onPressed: () {
                                    searchInputController.clear();
                                    controller.setSearchQuery('');
                                  },
                                )
                              : const SizedBox.shrink()),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  InkWell(
                    onTap: () {
                      Get.bottomSheet(
                        const FilterTray(),
                        isScrollControlled: true,
                      );
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppColors.primaryContainer,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [AppColors.cardShadow],
                      ),
                      child: const Icon(Icons.tune, color: Colors.white, size: 22),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),

              // Filter Make Horizontal Bar
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Obx(() {
                  final makes = ['All', 'BMW', 'Porsche', 'Mercedes-Benz', 'Audi', 'Tesla', 'Chevrolet'];
                  return Row(
                    children: makes.map((m) {
                      final isSelected = controller.selectedMake.value == m;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ChoiceChip(
                          label: Text(m),
                          selected: isSelected,
                          onSelected: (val) {
                            if (val) controller.setMake(m);
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
              const SizedBox(height: 16),

              // Results Count Bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(() => Text(
                        'Showing ${controller.filteredCars.length} Verified Vehicles',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColors.onSurface,
                          fontFamily: 'Plus Jakarta Sans',
                        ),
                      )),
                  TextButton.icon(
                    onPressed: () {
                      Get.bottomSheet(const FilterTray(), isScrollControlled: true);
                    },
                    icon: const Icon(Icons.sort, size: 16, color: AppColors.secondary),
                    label: Obx(() => Text(
                          controller.sortBy.value,
                          style: const TextStyle(fontSize: 12, color: AppColors.secondary, fontWeight: FontWeight.w600),
                        )),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Vehicle List View
              Obx(() {
                if (controller.isLoading.value) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(40),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                if (controller.filteredCars.isEmpty) {
                  return Container(
                    padding: const EdgeInsets.all(40),
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        const Icon(Icons.car_crash_outlined, size: 60, color: AppColors.outline),
                        const SizedBox(height: 12),
                        const Text(
                          'No vehicles match your criteria',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.onSurface),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'Try adjusting your price filter or selecting "All" body styles.',
                          style: TextStyle(fontSize: 13, color: AppColors.onSurfaceVariant),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: controller.resetFilters,
                          style: ElevatedButton.styleFrom(minimumSize: const Size(140, 40)),
                          child: const Text('Reset All Filters'),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.filteredCars.length,
                  itemBuilder: (context, index) {
                    final car = controller.filteredCars[index];
                    return CarCard(car: car);
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
