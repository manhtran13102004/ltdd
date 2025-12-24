import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/common/widgets/appbar/appbar.dart';
import 'package:project/common/widgets/brand/brandcard.dart';
import 'package:project/common/widgets/products/sortable/sortable_products.dart';
import 'package:project/features/shop/models/brand_model.dart';
import 'package:project/utils/constants/sizes.dart';

class BrandProducts extends StatelessWidget {
  final BrandModel brand;

  const BrandProducts({super.key, required this.brand});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(title: Text(brand.name), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              TBrandCard(brand: brand),
              const SizedBox(height: TSizes.spaceBtwSections),
              TSortableProducts(brandId: brand.id),
            ],
          ),
        ),
      ),
    );
  }
}