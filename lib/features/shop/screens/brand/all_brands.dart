import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/common/widgets/appbar/appbar.dart';
import 'package:project/common/widgets/layouts/grid_layout.dart';
import 'package:project/common/widgets/texts/section_heading.dart';
import 'package:project/features/shop/controllers/brand/brand_controller.dart';
import 'package:project/common/widgets/brand/brand_products.dart';
import 'package:project/common/widgets/brand/brandcard.dart';
import 'package:project/utils/constants/sizes.dart';

class AllBrandScreen extends StatelessWidget {
  const AllBrandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brandController = Get.put(BrandController());

    return Scaffold(
      appBar: const TAppBar(showBackArrow: true, title: Text('Chi nhánh')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              TSectionHeading(
                title: 'Các chi nhánh',
                textColor: Colors.black, // ← THÊM DÒNG NÀY
                showActionButton: false,
              ),
              const SizedBox(height: TSizes.spaceBtwItems),

              Obx(() {
                if (brandController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (brandController.allBrands.isEmpty) {
                  return const Center(child: Text('Không có chi nhánh nào'));
                }

                return TGridLayout(
                  itemCount: brandController.allBrands.length,
                  mainAxisExtent: 80,
                  itemBuilder: (_, index) {
                    final brand = brandController.allBrands[index];
                    return TBrandCard(
                      brand: brand,
                      onTap: () => Get.to(() => BrandProducts(brand: brand)),
                    );
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