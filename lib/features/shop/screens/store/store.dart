import 'package:flutter/material.dart'; // Import Flutter Material - cung cấp các widget cơ bản
import 'package:iconsax/iconsax.dart'; // Import icon pack Iconsax
import 'package:project/common/widgets/appbar/appbar.dart'; // Import widget AppBar chung
import 'package:project/common/widgets/icons/t_circular_icon.dart'; // Import widget icon tròn (có thể không dùng trực tiếp)
import 'package:project/common/widgets/layouts/grid_layout.dart'; // Import widget layout dạng grid
import 'package:project/features/shop/screens/store/widgets/category_tab.dart'; // Import widget tab hiển thị sản phẩm theo danh mục
import 'package:project/utils/constants/enums.dart'; // Import enums (có thể không dùng trực tiếp)
import 'package:project/utils/constants/image_strings.dart'; // Import đường dẫn hình ảnh chuẩn (có thể không dùng trực tiếp)
import 'package:project/utils/constants/sizes.dart'; // Import kích thước chuẩn
import '../../../../common/widgets/appbar/tabbar.dart'; // Import widget TabBar tùy chỉnh
import '../../../../common/widgets/brand/brand_show_case.dart'; // Import widget showcase thương hiệu (có thể không dùng trực tiếp)
import '../../../../common/widgets/brand/brandcard.dart'; // Import widget card thương hiệu
import '../../../../common/widgets/containers/rounded_container.dart'; // Import widget container bo góc (có thể không dùng trực tiếp)
import '../../../../common/widgets/containers/search_container.dart'; // Import widget container tìm kiếm
import '../../../../common/widgets/images/t_circular_image.dart'; // Import widget hình ảnh tròn (có thể không dùng trực tiếp)
import '../../../../common/widgets/products/cart/cart_menu_icon.dart'; // Import widget icon giỏ hàng
import '../../../../common/widgets/texts/section_heading.dart'; // Import widget tiêu đề section
import '../../../../common/widgets/texts/t_brand_title_with_verified_icon.dart'; // Import widget tiêu đề thương hiệu với icon verified (có thể không dùng trực tiếp)
import '../../../../utils/constants/colors.dart'; // Import màu sắc chuẩn
import '../../../../utils/helpers/helper_functions.dart'; // Import các hàm helper
import '../../controllers/category_controller.dart'; // Import controller xử lý logic danh mục
import 'package:get/get.dart'; // ← THÊM ĐỂ DÙNG Obx, Get.find, Get.to...
import 'package:project/features/shop/controllers/brand/brand_controller.dart'; // ← THÊM ĐỂ DÙNG brandController
import 'package:project/features/shop/models/brand_model.dart'; // ← THÊM ĐỂ DÙNG BrandModel (nếu cần)
import 'package:project/features/shop/screens/brand/all_brands.dart';
import 'package:project/common/widgets/brand/brand_products.dart'; // ← THÊM DÒNG NÀY ĐỂ DÙNG BrandProducts

class StoreScreen extends StatelessWidget { // Màn hình Store - StatelessWidget
  const StoreScreen({super.key}); // Constructor với key từ parent widget

  @override
  Widget build(BuildContext context) {
    final categories = CategoryController.instance.allCategories;
    final brandController = Get.put(BrandController()); // ← THÊM DÒNG NÀY ĐỂ KHAI BÁO brandController

    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        appBar: TAppBar(
          title: Text('Store', style: Theme.of(context).textTheme.headlineMedium),
          actions: [
            TCartCounterIcon(iconColor: TColors.black, iconColor2: TColors.white),
          ],
        ),
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                automaticallyImplyLeading: false,
                pinned: true,
                floating: true,
                backgroundColor: THelperFunctions.isDarkMode(context) ? TColors.black : TColors.white,
                expandedHeight: 440,
                flexibleSpace: Padding(
                  padding: const EdgeInsets.all(TSizes.defaultSpace),
                  child: ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      const SizedBox(height: TSizes.spaceBtwItems),
                      const TSearchContainer(text: 'Tìm kiếm', showBorder: true, showBackground: false, padding: EdgeInsets.zero),
                      const SizedBox(height: TSizes.spaceBtwSections),

                      TSectionHeading(
                        title: 'Chi nhánh',
                        showActionButton: true,
                        onPressed: () => Get.to(() => const AllBrandScreen()),
                        textColor: TColors.black,
                      ),
                      const SizedBox(height: TSizes.spaceBtwItems / 1.5),

                      // GRID CHI NHÁNH THẬT TỪ FIREBASE
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

                bottom: TTabBar(
                  tabs: categories.map((category) => Tab(child: Text(category.name))).toList(),
                ),
              ),
            ];
          },
          body: TabBarView(
            children: categories.map((category) => TCategoryTab(category: category)).toList(),
          ),
        ),
      ),
    );
  }

}
