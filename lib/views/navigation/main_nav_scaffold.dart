import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/app_colors.dart';
import '../../controllers/car_controller.dart';
import '../showroom/showroom_screen.dart';
import '../showroom/compare_screen.dart';
import '../saved/saved_cars_screen.dart';
import '../seller/seller_dashboard_screen.dart';
import '../profile/buyer_profile_screen.dart';

class MainNavScaffold extends StatefulWidget {
  const MainNavScaffold({super.key});

  @override
  State<MainNavScaffold> createState() => _MainNavScaffoldState();
}

class _MainNavScaffoldState extends State<MainNavScaffold> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    ShowroomScreen(),
    CompareScreen(),
    SavedCarsScreen(),
    SellerDashboardScreen(),
    BuyerProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final carController = Get.find<CarController>();

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          border: const Border(top: BorderSide(color: AppColors.outlineVariant)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: NavigationBar(
            selectedIndex: _currentIndex,
            onDestinationSelected: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            backgroundColor: Colors.transparent,
            indicatorColor: AppColors.secondaryContainer.withValues(alpha: 0.35),
            elevation: 0,
            destinations: [
              const NavigationDestination(
                icon: Icon(Icons.directions_car_outlined),
                selectedIcon: Icon(Icons.directions_car, color: AppColors.primaryContainer),
                label: 'Showroom',
              ),
              NavigationDestination(
                icon: Obx(() {
                  final count = carController.compareCars.length;
                  return Badge(
                    isLabelVisible: count > 0,
                    label: Text('$count'),
                    backgroundColor: AppColors.secondary,
                    child: const Icon(Icons.compare_arrows_outlined),
                  );
                }),
                selectedIcon: const Icon(Icons.compare_arrows, color: AppColors.primaryContainer),
                label: 'Compare',
              ),
              NavigationDestination(
                icon: Obx(() {
                  final count = carController.savedCars.length;
                  return Badge(
                    isLabelVisible: count > 0,
                    label: Text('$count'),
                    backgroundColor: AppColors.secondary,
                    child: const Icon(Icons.favorite_border),
                  );
                }),
                selectedIcon: const Icon(Icons.favorite, color: Colors.redAccent),
                label: 'Saved',
              ),
              const NavigationDestination(
                icon: Icon(Icons.storefront_outlined),
                selectedIcon: Icon(Icons.storefront, color: AppColors.primaryContainer),
                label: 'Seller Hub',
              ),
              const NavigationDestination(
                icon: Icon(Icons.person_outline),
                selectedIcon: Icon(Icons.person, color: AppColors.primaryContainer),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
