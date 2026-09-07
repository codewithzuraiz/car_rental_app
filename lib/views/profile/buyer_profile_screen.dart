import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/app_colors.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/booking_controller.dart';
import '../../controllers/car_controller.dart';
import '../seller/seller_dashboard_screen.dart';

class BuyerProfileScreen extends StatelessWidget {
  const BuyerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    final bookingController = Get.put(BookingController());
    final carController = Get.find<CarController>();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Buyer Profile & Account'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {
              Get.snackbar('Settings', 'Account security & preferences.');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // User Header Profile Card
            Obx(() {
              final user = authController.currentUser.value;
              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: AppColors.outlineVariant),
                  boxShadow: const [AppColors.cardShadow],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 32,
                          backgroundImage: NetworkImage(user.avatarUrl),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user.name,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                  fontFamily: 'Plus Jakarta Sans',
                                  color: AppColors.onSurface,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                user.email,
                                style: const TextStyle(fontSize: 13, color: AppColors.onSurfaceVariant),
                              ),
                              const SizedBox(height: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: AppColors.secondaryContainer.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.verified, size: 14, color: AppColors.secondary),
                                    const SizedBox(width: 4),
                                    Text(
                                      user.kycStatus,
                                      style: const TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.secondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Divider(color: AppColors.divider),
                    const SizedBox(height: 8),

                    // Quick Stats Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStatItem('Saved Cars', '${carController.savedCars.length}'),
                        _buildStatItem('Test Drives', '${bookingController.bookings.length}'),
                        _buildStatItem('Escrow Orders', '1 Active'),
                      ],
                    ),
                  ],
                ),
              );
            }),
            const SizedBox(height: 20),

            // KYC Upgrade Action Banner
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primaryContainer, AppColors.primary],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  const Icon(Icons.shield_outlined, color: AppColors.secondaryContainer, size: 28),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tier 3 VIP Escrow Clearance',
                          style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w700),
                        ),
                        Text(
                          'Enables \$200,000+ instant wire guarantees and cross-state vehicle delivery.',
                          style: TextStyle(color: Colors.white70, fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => authController.upgradeKyc(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: AppColors.primaryContainer,
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      minimumSize: Size.zero,
                    ),
                    child: const Text('Verify', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Active Bookings & Test Drives
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'My Active Appointments',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.onSurface),
                ),
                Obx(() => Text(
                      '${bookingController.bookings.length} Scheduled',
                      style: const TextStyle(fontSize: 12, color: AppColors.secondary, fontWeight: FontWeight.w600),
                    )),
              ],
            ),
            const SizedBox(height: 12),
            Obx(() {
              if (bookingController.bookings.isEmpty) {
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(child: Text('No active test drive appointments scheduled.')),
                );
              }

              return Column(
                children: bookingController.bookings.map((booking) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: AppColors.outlineVariant),
                      boxShadow: const [AppColors.cardShadow],
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppColors.surfaceContainerLow,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(Icons.event_available, color: AppColors.secondary, size: 24),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                booking.carTitle,
                                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                '${booking.date} • ${booking.deliveryType}',
                                style: const TextStyle(fontSize: 12, color: AppColors.onSurfaceVariant),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.successContainer,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            booking.status,
                            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.success),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              );
            }),
            const SizedBox(height: 24),

            // Account Actions & Switch to Seller Mode
            Container(
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.outlineVariant),
              ),
              child: Column(
                children: [
                  _buildMenuTile(
                    Icons.storefront_outlined,
                    'Switch to Seller Hub',
                    'Manage listed cars, incoming leads, and escrow',
                    onTap: () => Get.to(() => const SellerDashboardScreen()),
                    isAccent: true,
                  ),
                  const Divider(color: AppColors.divider, height: 1),
                  _buildMenuTile(
                    Icons.security,
                    'Escrow Protection & Payment Methods',
                    'Visa, Mastercard & Wire transfer credentials',
                    onTap: () => Get.snackbar('Payment Methods', 'Protected by AutoElite Escrow Guarantee.'),
                  ),
                  const Divider(color: AppColors.divider, height: 1),
                  _buildMenuTile(
                    Icons.description_outlined,
                    'KYC & Driver License Verification',
                    'Verified on file',
                    onTap: () => Get.snackbar('KYC Verification', 'Status: Tier 2 Verified.'),
                  ),
                  const Divider(color: AppColors.divider, height: 1),
                  _buildMenuTile(
                    Icons.logout,
                    'Sign Out',
                    'Log out of AutoElite network',
                    onTap: () => Get.snackbar('Auth', 'Session active.'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            fontFamily: 'Plus Jakarta Sans',
            color: AppColors.primaryContainer,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: AppColors.onSurfaceVariant),
        ),
      ],
    );
  }

  Widget _buildMenuTile(IconData icon, String title, String subtitle, {required VoidCallback onTap, bool isAccent = false}) {
    return ListTile(
      leading: Icon(icon, color: isAccent ? AppColors.secondary : AppColors.onSurface),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: isAccent ? AppColors.secondary : AppColors.onSurface,
        ),
      ),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 12, color: AppColors.onSurfaceVariant)),
      trailing: const Icon(Icons.chevron_right, size: 18, color: AppColors.outline),
      onTap: onTap,
    );
  }
}
