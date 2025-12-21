import 'package:flutter/material.dart'; // Import Flutter Material - cung cấp các widget cơ bản
import 'package:get/get.dart'; // Import GetX - dùng cho navigation
import 'package:get/get_core/src/get_main.dart'; // Import GetX core (có thể không cần thiết)
import 'package:iconsax/iconsax.dart'; // Import icon pack Iconsax (có thể không dùng trực tiếp)
import 'package:project/common/widgets/appbar/appbar.dart'; // Import widget AppBar chung
import 'package:project/features/shop/screens/cart/widgets/cart_items.dart'; // Import widget hiển thị danh sách items trong giỏ hàng
import 'package:project/utils/constants/colors.dart'; // Import màu sắc chuẩn
import 'package:project/utils/constants/image_strings.dart'; // Import đường dẫn hình ảnh chuẩn (có thể không dùng trực tiếp)
import 'package:project/utils/constants/sizes.dart'; // Import kích thước chuẩn

import '../../../../common/widgets/icons/t_circular_icon.dart'; // Import widget icon tròn (có thể không dùng trực tiếp)
import '../../../../common/widgets/images/t_rounded_image.dart'; // Import widget hình ảnh bo góc (có thể không dùng trực tiếp)
import '../../../../common/widgets/products/cart/add_remove_button.dart'; // Import widget nút tăng/giảm số lượng (có thể không dùng trực tiếp)
import '../../../../common/widgets/products/cart/cart_item.dart'; // Import widget item trong giỏ hàng (có thể không dùng trực tiếp)
import '../../../../common/widgets/texts/product_price_text.dart'; // Import widget hiển thị giá sản phẩm (có thể không dùng trực tiếp)
import '../../../../common/widgets/texts/product_title_text.dart'; // Import widget hiển thị tên sản phẩm (có thể không dùng trực tiếp)
import '../../../../common/widgets/texts/t_brand_title_with_verified_icon.dart'; // Import widget hiển thị tên thương hiệu với icon verified (có thể không dùng trực tiếp)
import '../../../../utils/helpers/helper_functions.dart'; // Import các hàm helper (có thể không dùng trực tiếp)
import '../checkout/checkout.dart'; // Import màn hình checkout

class CartScreen extends StatelessWidget { // Màn hình giỏ hàng - StatelessWidget
  const CartScreen({Key? key}) : super (key : key); // Constructor với key từ parent widget

  @override
  Widget build(BuildContext context) { // Hàm build - xây dựng UI
    return Scaffold( // Scaffold - widget cơ bản nhất của Material Design
      appBar: TAppBar( showBackArrow: true, title: Text('Giỏ Hàng', style: Theme.of(context).textTheme.headlineSmall,),), // AppBar với nút back và tiêu đề "Giỏ Hàng"
      body: const Padding( // Padding xung quanh nội dung
        padding: EdgeInsets.all(TSizes.defaultSpace), // Padding chuẩn cho tất cả các cạnh
        child: TCartItems(), // Widget hiển thị danh sách items trong giỏ hàng

      ),
      bottomNavigationBar: Padding( // Padding xung quanh nút checkout
        padding: const EdgeInsets.all(TSizes.defaultSpace), // Padding chuẩn cho tất cả các cạnh
        child: ElevatedButton( // Nút "Check out" (nút chính, có màu nền)
          onPressed: () => Get.to(() => const CheckoutScreen()), // Khi click, navigate đến màn hình checkout
          style: ElevatedButton.styleFrom( // Định nghĩa style cho nút
              backgroundColor: TColors.primary, // Màu nền primary
              side: const BorderSide(color: TColors.primary) // Viền màu primary
          ),
          child: const Text('Check out \500.000 VND' ), // Text hiển thị "Check out" và tổng tiền (hardcode, nên tính từ giỏ hàng)
        ),
      ),
    );
  }
}
