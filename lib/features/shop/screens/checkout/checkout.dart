// File màn hình Checkout - màn hình thanh toán, hiển thị giỏ hàng, địa chỉ, phương thức thanh toán

import 'package:flutter/material.dart'; // Import Flutter Material - cung cấp các widget cơ bản
import 'package:get/get.dart'; // Import GetX - dùng cho navigation
import 'package:get/get_core/src/get_main.dart'; // Import GetX core (có thể không cần thiết)
import 'package:project/features/shop/screens/checkout/widgets/billing_address_section.dart'; // Import widget section địa chỉ thanh toán
import 'package:project/features/shop/screens/checkout/widgets/billing_amount_section.dart'; // Import widget section tổng tiền thanh toán
import 'package:project/features/shop/screens/checkout/widgets/billing_payment_section.dart'; // Import widget section phương thức thanh toán
import 'package:project/features/shop/controllers/cart/cart_controller.dart';
import 'package:project/utils/constants/colors.dart'; // Import màu sắc chuẩn
import 'package:project/utils/constants/image_strings.dart'; // Import đường dẫn hình ảnh chuẩn

import '../../../../common/widgets/appbar/appbar.dart'; // Import widget AppBar chung
import '../../../../common/widgets/containers/rounded_container.dart'; // Import widget container bo góc
import '../../../../common/widgets/products/cart/cart_item.dart'; // Import widget item trong giỏ hàng (có thể không dùng trực tiếp)
import '../../../../common/widgets/products/cart/coupon.dart'; // Import widget nhập mã giảm giá
import '../../../../common/widgets/success_screen/success_screen.dart'; // Import màn hình thành công
import '../../../../utils/constants/sizes.dart'; // Import kích thước chuẩn
import '../../../../utils/helpers/helper_functions.dart'; // Import các hàm helper
import '../../../../utils/navigation_menu.dart'; // Import màn hình navigation menu
import '../cart/widgets/cart_items.dart'; // Import widget hiển thị danh sách items trong giỏ hàng

class CheckoutScreen extends StatelessWidget { // Màn hình thanh toán - StatelessWidget
  const CheckoutScreen({Key? key}) : super (key : key); // Constructor với key từ parent widget

  @override
  Widget build(BuildContext context) { // Hàm build - xây dựng UI
    final cartController = CartController.instance;
    final dark = THelperFunctions.isDarkMode(context); // Kiểm tra chế độ dark mode
    return Scaffold( // Scaffold - widget cơ bản nhất của Material Design
      appBar: TAppBar( showBackArrow: true, title: Text('Thanh Toán', style: Theme.of(context).textTheme.headlineSmall,),), // AppBar với nút back và tiêu đề "Thanh Toán"
      body: SingleChildScrollView( // SingleChildScrollView - cho phép cuộn nội dung
        child: Padding( // Padding xung quanh nội dung
          padding: const EdgeInsets.all(TSizes.defaultSpace), // Padding chuẩn cho tất cả các cạnh
          child: Column( // Column - sắp xếp các widget theo chiều dọc
             children: [ // Danh sách các widget con
               const TCartItems(showAddRemoveButton: false,), // Widget hiển thị danh sách items trong giỏ hàng (không hiển thị nút tăng/giảm số lượng)
               const SizedBox(height: TSizes.spaceBtwSections,), // Khoảng cách giữa giỏ hàng và mã giảm giá

               const TCouponCode(), // Widget nhập mã giảm giá
               const SizedBox(height: TSizes.spaceBtwSections,), // Khoảng cách giữa mã giảm giá và container thông tin thanh toán

               TRoundedContainer( // Container bo góc chứa thông tin thanh toán
                 showBorder: true, // Hiển thị viền
                 backgroundColor: dark ? TColors.black : TColors.white, // Màu nền: nếu dark mode thì đen, ngược lại trắng
                 child: const Column( // Column chứa các section thông tin thanh toán
                   children: [ // Danh sách các widget con

                     TBillingAmountSection(), // Widget section hiển thị tổng tiền (tạm tính, phí vận chuyển, tổng cộng...)
                     SizedBox(height: TSizes.spaceBtwItems,), // Khoảng cách giữa section tổng tiền và divider

                     Divider(), // Đường kẻ ngang phân cách
                     SizedBox(height: TSizes.spaceBtwItems,), // Khoảng cách giữa divider và section phương thức thanh toán

                     TBillingPaymentSection(), // Widget section chọn phương thức thanh toán (thẻ tín dụng, ví điện tử...)
                     SizedBox(height: TSizes.spaceBtwItems,), // Khoảng cách giữa section phương thức thanh toán và section địa chỉ

                     TBillingAddressSection(), // Widget section chọn địa chỉ giao hàng


                   ],
                 ),

               )


             ],
          ),

        ),
      ),

      bottomNavigationBar: Padding( // Padding xung quanh nút thanh toán
        padding: const EdgeInsets.all(TSizes.defaultSpace), // Padding chuẩn cho tất cả các cạnh
        child: Obx(() {
          final hasItems = cartController.cartItems.isNotEmpty;
          final totalText = cartController.formatCurrency(cartController.orderTotal);
          return ElevatedButton( // Nút "Check out" (nút chính, có màu nền)
            onPressed: hasItems ? () => Get.to(() => SuccessScreen( // Khi click, navigate đến màn hình thành công
              image: TImages.successfulPaymentIcon, // Hình ảnh minh họa thanh toán thành công
              title: 'Thanh toán thành công', // Tiêu đề "Thanh toán thành công"
              subtitle: 'Đơn hàng của bạn sẽ được vận chuyển sớm', // Phụ đề thông báo
              onPressed: () => Get.offAll(() => const NavigationMenu()), // Callback khi click nút trên màn hình thành công - quay về màn hình chính và xóa tất cả màn hình trước đó
            )) : null,
            style: ElevatedButton.styleFrom( // Định nghĩa style cho nút
                backgroundColor: TColors.primary, // Màu nền primary
                side: const BorderSide(color: TColors.primary) // Viền màu primary
            ),
            child: Text('Check out $totalText' ), // Text hiển thị "Check out" và tổng tiền
          );
        }),
      ),

    );
  }
}

