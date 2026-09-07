import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../core/theme/app_colors.dart';
import '../../controllers/car_controller.dart';
import '../../controllers/booking_controller.dart';
import 'add_car_wizard_screen.dart';
import 'inventory_screen.dart';

class SellerDashboardScreen extends StatelessWidget {
  const SellerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final carController = Get.find<CarController>();
    final bookingController = Get.find<BookingController>();
    final currencyFormatter = NumberFormat.currency(symbol: '\$', decimalDigits: 0);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Seller Operations & Analytics'),
        actions: [
          IconButton(
            icon: const Icon(Icons.inventory_2_outlined),
            tooltip: 'View Inventory',
            onPressed: () => Get.to(() => const InventoryScreen()),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Total Portfolio Valuation Banner
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primaryContainer, AppColors.secondary],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [AppColors.cardShadow],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Total Showroom Valuation',
                        style: TextStyle(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.w500),
                      ),
                      Icon(Icons.verified, color: AppColors.secondaryContainer, size: 20),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Obx(() {
                    final totalValue = carController.allCars.fold<double>(0, (sum, item) => sum + item.price);
                    return Text(
                      currencyFormatter.format(totalValue),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        fontFamily: 'Plus Jakarta Sans',
                      ),
                    );
                  }),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.trending_up, color: Colors.white, size: 14),
                            SizedBox(width: 4),
                            Text('+14.2% MoM', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700)),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        '7 Certified Luxury Listings',
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // 4-Card Analytics Grid
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.45,
              children: [
                _buildMetricCard(
                  'Active Listings',
                  '${carController.allCars.length}',
                  Icons.directions_car,
                  AppColors.primaryContainer,
                  'All verified',
                ),
                _buildMetricCard(
                  'Showroom Views',
                  '18,490',
                  Icons.visibility_outlined,
                  AppColors.secondary,
                  '+22% this week',
                ),
                _buildMetricCard(
                  'Test Drive Leads',
                  '${bookingController.bookings.length + 6}',
                  Icons.calendar_month,
                  const Color(0xFF0D9488),
                  'High buyer intent',
                ),
                _buildMetricCard(
                  'Escrow Volume',
                  '\$174,800',
                  Icons.lock_clock,
                  const Color(0xFFD97706),
                  '2 deals finalizing',
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Quick Operations CTAs
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => Get.to(() => const AddCarWizardScreen()),
                    icon: const Icon(Icons.add_circle_outline, size: 18),
                    label: const Text('Add Car Listing'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryContainer,
                      minimumSize: const Size.fromHeight(48),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => Get.to(() => const InventoryScreen()),
                    icon: const Icon(Icons.view_list, size: 18),
                    label: const Text('Manage Stock'),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size.fromHeight(48),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 28),

            // Recent Inquiries & Test Drive Requests
            const Text(
              'High-Intent Buyer Leads',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.onSurface),
            ),
            const SizedBox(height: 12),
            Obx(() {
              return Column(
                children: bookingController.bookings.map((booking) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: AppColors.outlineVariant),
                      boxShadow: const [AppColors.cardShadow],
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: AppColors.surfaceContainerHigh,
                          child: const Icon(Icons.person, color: AppColors.primaryContainer),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(booking.buyerName, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
                              Text(
                                '${booking.carTitle} • ${booking.date}',
                                style: const TextStyle(fontSize: 12, color: AppColors.onSurfaceVariant),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        OutlinedButton(
                          onPressed: () {
                            Get.snackbar('Lead Details', 'Contact ${booking.buyerPhone}');
                          },
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            minimumSize: Size.zero,
                          ),
                          child: const Text('Respond', style: TextStyle(fontSize: 11)),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon, Color color, String footer) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.outlineVariant),
        boxShadow: const [AppColors.cardShadow],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(fontSize: 12, color: AppColors.onSurfaceVariant)),
              Icon(icon, size: 18, color: color),
            ],
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              fontFamily: 'Plus Jakarta Sans',
              color: AppColors.onSurface,
            ),
          ),
          Text(
            footer,
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: color),
          ),
        ],
      ),
    );
  }
}
