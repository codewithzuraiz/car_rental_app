import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import '../models/car_model.dart';
import '../core/theme/app_colors.dart';
import '../controllers/car_controller.dart';
import '../views/showroom/car_detail_screen.dart';

class CarCard extends StatelessWidget {
  final CarModel car;
  final bool showCompareAction;

  const CarCard({
    super.key,
    required this.car,
    this.showCompareAction = true,
  });

  @override
  Widget build(BuildContext context) {
    final currencyFormatter = NumberFormat.currency(symbol: '\$', decimalDigits: 0);
    final numberFormatter = NumberFormat.decimalPattern();
    final carController = Get.find<CarController>();

    return GestureDetector(
      onTap: () {
        Get.to(() => CarDetailScreen(car: car));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.outlineVariant),
          boxShadow: const [AppColors.cardShadow],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Vehicle Image & Floating Badges
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                  child: AspectRatio(
                    aspectRatio: 16 / 9.5,
                    child: car.images.isNotEmpty
                        ? CachedNetworkImage(
                            imageUrl: car.images.first,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Container(
                              color: AppColors.surfaceContainerLow,
                              child: const Center(
                                child: CircularProgressIndicator(strokeWidth: 2),
                              ),
                            ),
                            errorWidget: (context, url, error) => Container(
                              color: AppColors.surfaceContainerLow,
                              child: const Icon(Icons.directions_car, size: 48, color: AppColors.outline),
                            ),
                          )
                        : Container(
                            color: AppColors.surfaceContainerLow,
                            child: const Icon(Icons.directions_car, size: 48, color: AppColors.outline),
                          ),
                  ),
                ),
                // Certified Trust Badge
                if (car.isCertified)
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: AppColors.primaryContainer.withValues(alpha: 0.9),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.2),
                            blurRadius: 6,
                          )
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.verified, size: 14, color: AppColors.secondaryContainer),
                          const SizedBox(width: 4),
                          Text(
                            'Score ${car.inspectionScore}/100',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                // Wishlist Toggle Button
                Positioned(
                  top: 12,
                  right: 12,
                  child: Obx(() {
                    final saved = carController.isSaved(car);
                    return GestureDetector(
                      onTap: () => carController.toggleSave(car),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.9),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 6,
                            )
                          ],
                        ),
                        child: Icon(
                          saved ? Icons.favorite : Icons.favorite_border,
                          size: 18,
                          color: saved ? Colors.redAccent : AppColors.onSurface,
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),

            // Card Body Information
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title & Year
                  Text(
                    car.title,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: AppColors.onSurface,
                      fontFamily: 'Plus Jakarta Sans',
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 10),

                  // Spec Pill Strip
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: [
                      _buildSpecPill(Icons.speed, '${numberFormatter.format(car.mileage)} mi'),
                      _buildSpecPill(Icons.local_gas_station, car.fuelType),
                      _buildSpecPill(Icons.settings, car.transmission),
                      _buildSpecPill(Icons.bolt, '${car.horsePower} HP'),
                    ],
                  ),
                  const SizedBox(height: 14),

                  const Divider(color: AppColors.divider, height: 1),
                  const SizedBox(height: 12),

                  // Pricing & Compare Action
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            currencyFormatter.format(car.price),
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              color: AppColors.primaryContainer,
                              fontFamily: 'Plus Jakarta Sans',
                            ),
                          ),
                          Text(
                            'Est. ${currencyFormatter.format(car.emi)}/mo',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: AppColors.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                      if (showCompareAction)
                        Obx(() {
                          final compared = carController.isCompared(car);
                          return OutlinedButton.icon(
                            onPressed: () => carController.toggleCompare(car),
                            icon: Icon(
                              compared ? Icons.check_circle : Icons.compare_arrows,
                              size: 16,
                              color: compared ? AppColors.secondary : AppColors.onSurfaceVariant,
                            ),
                            label: Text(
                              compared ? 'Comparing' : 'Compare',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: compared ? AppColors.secondary : AppColors.onSurface,
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              backgroundColor: compared
                                  ? AppColors.secondaryContainer.withValues(alpha: 0.15)
                                  : Colors.transparent,
                              side: BorderSide(
                                color: compared ? AppColors.secondary : AppColors.outlineVariant,
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                              minimumSize: Size.zero,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          );
                        }),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpecPill(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: AppColors.onSurfaceVariant),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: AppColors.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
