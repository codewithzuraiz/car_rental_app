import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../core/theme/app_colors.dart';
import '../../controllers/listing_wizard_controller.dart';

class AddCarWizardScreen extends StatelessWidget {
  const AddCarWizardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final wizard = Get.put(ListingWizardController());
    final currencyFormatter = NumberFormat.currency(symbol: '\$', decimalDigits: 0);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Add Vehicle Listing Wizard'),
      ),
      body: Column(
        children: [
          // Step Progress Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            color: AppColors.surface,
            child: Obx(() {
              final step = wizard.currentStep.value;
              final steps = ['Identification', 'Powertrain', 'Media & Proof', 'Pricing & Escrow'];
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(4, (index) {
                      final isActive = index <= step;
                      return Row(
                        children: [
                          CircleAvatar(
                            radius: 12,
                            backgroundColor: isActive ? AppColors.secondary : AppColors.surfaceContainerHigh,
                            child: Text(
                              '${index + 1}',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: isActive ? Colors.white : AppColors.onSurfaceVariant,
                              ),
                            ),
                          ),
                          if (index < 3)
                            Container(
                              width: MediaQuery.of(context).size.width * 0.16,
                              height: 2,
                              color: index < step ? AppColors.secondary : AppColors.outlineVariant,
                            ),
                        ],
                      );
                    }),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Step ${step + 1}: ${steps[step]}',
                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.primaryContainer),
                  ),
                ],
              );
            }),
          ),

          // Wizard Step Body
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Obx(() {
                switch (wizard.currentStep.value) {
                  case 0:
                    return _buildStep1(wizard);
                  case 1:
                    return _buildStep2(wizard);
                  case 2:
                    return _buildStep3(wizard);
                  case 3:
                    return _buildStep4(wizard, currencyFormatter);
                  default:
                    return const SizedBox.shrink();
                }
              }),
            ),
          ),

          // Bottom Step Actions
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            decoration: const BoxDecoration(
              color: AppColors.surface,
              border: Border(top: BorderSide(color: AppColors.outlineVariant)),
            ),
            child: Obx(() {
              final step = wizard.currentStep.value;
              return Row(
                children: [
                  if (step > 0) ...[
                    Expanded(
                      flex: 1,
                      child: OutlinedButton(
                        onPressed: wizard.prevStep,
                        style: OutlinedButton.styleFrom(minimumSize: const Size.fromHeight(48)),
                        child: const Text('Back'),
                      ),
                    ),
                    const SizedBox(width: 12),
                  ],
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (step < 3) {
                          wizard.nextStep();
                        } else {
                          await wizard.publishListing();
                          Get.defaultDialog(
                            title: 'Listing Published! 🎉',
                            titleStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, fontFamily: 'Plus Jakarta Sans'),
                            middleText:
                                'Your vehicle has been successfully certified and published to the live showroom inventory.',
                            textConfirm: 'Go to Showroom',
                            confirmTextColor: Colors.white,
                            buttonColor: AppColors.primaryContainer,
                            onConfirm: () {
                              Get.back();
                              Get.back();
                            },
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: step == 3 ? AppColors.success : AppColors.primaryContainer,
                        minimumSize: const Size.fromHeight(48),
                      ),
                      child: Text(
                        step < 3 ? 'Continue to Next Step' : 'Publish to Showroom',
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildStep1(ListingWizardController wizard) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Vehicle Identification & Heritage',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: AppColors.onSurface),
        ),
        const SizedBox(height: 6),
        const Text(
          'Enter the 17-character VIN to auto-populate certified vehicle history.',
          style: TextStyle(fontSize: 12, color: AppColors.onSurfaceVariant),
        ),
        const SizedBox(height: 20),
        TextFormField(
          initialValue: wizard.vin.value,
          onChanged: (val) => wizard.vin.value = val,
          decoration: const InputDecoration(labelText: 'VIN Number', prefixIcon: Icon(Icons.pin)),
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                initialValue: wizard.make.value,
                onChanged: (val) => wizard.make.value = val,
                decoration: const InputDecoration(labelText: 'Make (e.g. BMW)'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextFormField(
                initialValue: wizard.model.value,
                onChanged: (val) => wizard.model.value = val,
                decoration: const InputDecoration(labelText: 'Model (e.g. M3 CS)'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                initialValue: wizard.year.value.toString(),
                keyboardType: TextInputType.number,
                onChanged: (val) => wizard.year.value = int.tryParse(val) ?? 2024,
                decoration: const InputDecoration(labelText: 'Model Year'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextFormField(
                initialValue: wizard.mileage.value.toString(),
                keyboardType: TextInputType.number,
                onChanged: (val) => wizard.mileage.value = int.tryParse(val) ?? 0,
                decoration: const InputDecoration(labelText: 'Mileage (mi)'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        DropdownButtonFormField<String>(
          initialValue: wizard.bodyStyle.value,
          items: ['Sedan', 'Coupe', 'SUV', 'Convertible']
              .map((s) => DropdownMenuItem(value: s, child: Text(s)))
              .toList(),
          onChanged: (val) => wizard.bodyStyle.value = val ?? 'Sedan',
          decoration: const InputDecoration(labelText: 'Body Style'),
        ),
      ],
    );
  }

  Widget _buildStep2(ListingWizardController wizard) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Powertrain & Track Performance',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: AppColors.onSurface),
        ),
        const SizedBox(height: 6),
        const Text(
          'Highlight mechanical telemetry for prospective buyers.',
          style: TextStyle(fontSize: 12, color: AppColors.onSurfaceVariant),
        ),
        const SizedBox(height: 20),
        DropdownButtonFormField<String>(
          initialValue: wizard.fuelType.value,
          items: ['Petrol', 'Hybrid', 'Electric', 'Diesel']
              .map((s) => DropdownMenuItem(value: s, child: Text(s)))
              .toList(),
          onChanged: (val) => wizard.fuelType.value = val ?? 'Petrol',
          decoration: const InputDecoration(labelText: 'Fuel / Energy Type'),
        ),
        const SizedBox(height: 14),
        DropdownButtonFormField<String>(
          initialValue: wizard.transmission.value,
          items: ['Automatic', 'Manual', 'Dual-Clutch', 'Single-Speed']
              .map((s) => DropdownMenuItem(value: s, child: Text(s)))
              .toList(),
          onChanged: (val) => wizard.transmission.value = val ?? 'Automatic',
          decoration: const InputDecoration(labelText: 'Transmission'),
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                initialValue: wizard.horsePower.value.toString(),
                keyboardType: TextInputType.number,
                onChanged: (val) => wizard.horsePower.value = int.tryParse(val) ?? 400,
                decoration: const InputDecoration(labelText: 'Horsepower (HP)'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextFormField(
                initialValue: wizard.acceleration.value,
                onChanged: (val) => wizard.acceleration.value = val,
                decoration: const InputDecoration(labelText: '0-60 Acceleration'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        TextFormField(
          initialValue: wizard.topSpeed.value,
          onChanged: (val) => wizard.topSpeed.value = val,
          decoration: const InputDecoration(labelText: 'Top Speed'),
        ),
      ],
    );
  }

  Widget _buildStep3(ListingWizardController wizard) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Media Assets & Certification Proof',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: AppColors.onSurface),
        ),
        const SizedBox(height: 6),
        const Text(
          'High resolution showroom photographs and inspection evidence.',
          style: TextStyle(fontSize: 12, color: AppColors.onSurfaceVariant),
        ),
        const SizedBox(height: 20),
        TextFormField(
          initialValue: wizard.imageUrl.value,
          onChanged: (val) => wizard.imageUrl.value = val,
          decoration: const InputDecoration(
            labelText: 'Primary High-Res Image URL',
            prefixIcon: Icon(Icons.image),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          height: 160,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLow,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.outlineVariant, style: BorderStyle.solid),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.cloud_upload_outlined, size: 40, color: AppColors.secondary),
              const SizedBox(height: 8),
              const Text(
                'Upload 150-Point Certified Inspection PDF',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 4),
              const Text('Drag & drop or tap to browse file', style: TextStyle(fontSize: 11, color: AppColors.onSurfaceVariant)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStep4(ListingWizardController wizard, NumberFormat formatter) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Pricing & Escrow Protection',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: AppColors.onSurface),
        ),
        const SizedBox(height: 6),
        const Text(
          'Set your verified asking price. AutoElite Escrow protects wire transfers.',
          style: TextStyle(fontSize: 12, color: AppColors.onSurfaceVariant),
        ),
        const SizedBox(height: 20),
        TextFormField(
          initialValue: wizard.price.value.toStringAsFixed(0),
          keyboardType: TextInputType.number,
          onChanged: (val) => wizard.price.value = double.tryParse(val) ?? 100000,
          decoration: const InputDecoration(
            labelText: 'Verified Cash Price (\$)',
            prefixIcon: Icon(Icons.attach_money),
          ),
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLow,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.outlineVariant),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Estimated 72-Month EMI', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                  Text('Calculated with 4.9% APR prime rate', style: TextStyle(fontSize: 11, color: AppColors.onSurfaceVariant)),
                ],
              ),
              Text(
                formatter.format(wizard.price.value / 72),
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.secondary),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.successContainer,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Row(
            children: [
              Icon(Icons.shield_outlined, color: AppColors.success, size: 24),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('AutoElite Escrow Guarantee Active', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Color(0xFF065F46))),
                    Text('Buyer deposits held securely until title handover and inspection approval.', style: TextStyle(fontSize: 11, color: Color(0xFF047857))),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
