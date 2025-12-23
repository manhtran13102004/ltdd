import 'package:flutter/material.dart'; // Import Flutter Material - cung cấp các widget cơ bản
import 'package:get/get.dart'; // Import GetX - dùng cho navigation
import 'package:get/get_core/src/get_main.dart'; // Import GetX core (có thể không cần thiết)
import 'package:iconsax/iconsax.dart'; // Import icon pack Iconsax (có thể không dùng trực tiếp)
import 'package:project/common/widgets/appbar/appbar.dart'; // Import widget AppBar chung
import 'package:project/features/shop/screens/cart/widgets/cart_items.dart'; // Import widget hiển thị danh sách items trong giỏ hàng
import 'package:project/utils/constants/colors.dart'; // Import màu sắc chuẩn
import 'package:project/utils/constants/image_strings.dart'; // Import đường dẫn hình ảnh chuẩn (có thể không dùng trực tiếp)
import 'package:project/utils/constants/sizes.dart'; // Import kích thước chuẩn
import '../../controllers/cart/cart_controller.dart'; // ← THÊM DÒNG NÀY (đường dẫn tùy theo chỗ mày đặt file CartController)
import '../cart/widgets/cart_items_dynamic.dart'; // ← THÊM DÒNG NÀY (đường dẫn tùy chỗ mày tạo file)
import '../../../../common/widgets/icons/t_circular_icon.dart'; // Import widget icon tròn (có thể không dùng trực tiếp)
import '../../../../common/widgets/images/t_rounded_image.dart'; // Import widget hình ảnh bo góc (có thể không dùng trực tiếp)
import '../../../../common/widgets/products/cart/add_remove_button.dart'; // Import widget nút tăng/giảm số lượng (có thể không dùng trực tiếp)
import '../../../../common/widgets/products/cart/cart_item.dart'; // Import widget item trong giỏ hàng (có thể không dùng trực tiếp)
import '../../../../common/widgets/texts/product_price_text.dart'; // Import widget hiển thị giá sản phẩm (có thể không dùng trực tiếp)
import '../../../../common/widgets/texts/product_title_text.dart'; // Import widget hiển thị tên sản phẩm (có thể không dùng trực tiếp)
import '../../../../common/widgets/texts/t_brand_title_with_verified_icon.dart'; // Import widget hiển thị tên thương hiệu với icon verified (có thể không dùng trực tiếp)
import '../../../../utils/helpers/helper_functions.dart'; // Import các hàm helper (có thể không dùng trực tiếp)
import '../checkout/checkout.dart'; // Import màn hình checkout
class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();

    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text('Giỏ Hàng', style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Obx(() {
          if (cartController.cartItems.isEmpty) {
            return const Center(child: Text('Giỏ hàng trống'));
          }
          return const TCartItemsDynamic(); // Dùng list động
        }),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Obx(() {
          // Tính tổng tiền đơn giản (giả sử dùng giá thấp nhất)
          double total = cartController.cartItems.fold(0, (sum, item) {
            double price = double.tryParse(cartController.getProductLowesPrice(item.product)) ?? 0;
            return sum + (price * item.quantity);
          });
          return ElevatedButton(
            onPressed: () => Get.to(() => const CheckoutScreen()),
            style: ElevatedButton.styleFrom(backgroundColor: TColors.primary),
            child: Text('Check out ${total.toStringAsFixed(0)} VND'),
          );
        }),
      ),
    );
  }
}
