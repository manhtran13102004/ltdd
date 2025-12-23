import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/common/widgets/appbar/appbar.dart';
import 'package:project/common/widgets/layouts/grid_layout.dart';
import 'package:project/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:project/features/shop/controllers/wishlist/wishlist_controller.dart';
import 'package:project/utils/constants/sizes.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final wishlistController = Get.put(WishlistController());

    return Scaffold(
      appBar: TAppBar(
        title: Text('Wishlist', style: Theme.of(context).textTheme.headlineMedium),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              Obx(() {
                if (wishlistController.wishlistItems.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 100),
                      child: Text(
                        'Chưa có sản phẩm nào trong wishlist',
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }

                // GRID 2 CỘT GIỐNG HỆT TRANG CHỦ
                return TGridLayout(
                  itemCount: wishlistController.wishlistItems.length,
                  itemBuilder: (_, index) {
                    return TProductCardVertical(product: wishlistController.wishlistItems[index]);
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