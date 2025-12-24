// lib/features/shop/screens/cart/cart.dart

import 'package:flutter/material.dart'; // Import thư viện chính của Flutter để dùng các widget cơ bản
import 'package:get/Get.dart'; // Import GetX để dùng navigation, Obx, Get.find...
import 'package:iconsax/iconsax.dart'; // Import bộ icon Iconsax (dùng cho icon trong app)
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore để lưu đơn hàng vào Firebase
import 'package:firebase_auth/firebase_auth.dart'; // Import FirebaseAuth để lấy email user hiện tại
import 'package:project/common/widgets/appbar/appbar.dart'; // Import AppBar tùy chỉnh của app
import 'package:project/features/shop/controllers/cart/cart_controller.dart'; // Import controller quản lý giỏ hàng
import 'package:project/features/shop/screens/cart/widgets/cart_items_dynamic.dart'; // Import widget hiển thị danh sách sản phẩm trong giỏ (dynamic)
import 'package:project/utils/constants/colors.dart'; // Import màu sắc chuẩn của app
import 'package:project/utils/constants/sizes.dart'; // Import kích thước chuẩn (padding, space...)

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key); // Constructor của màn hình giỏ hàng

  // Hàm lưu đơn hàng vào Firebase (chỉ lưu tổng tiền, user, ngày đặt, ngày giao dự kiến)
  Future<void> _placeOrder(double totalPrice) async {
    try {
      // Tạo dữ liệu đơn hàng
      final orderData = {
        'User': FirebaseAuth.instance.currentUser?.email ?? 'guest@example.com', // Lấy email user hiện tại, nếu chưa login thì dùng guest
        'TotalPrice': totalPrice, // Tổng tiền đơn hàng
        'Status': 'Pending', // Trạng thái đơn hàng ban đầu là Pending
        'Order_date': Timestamp.now(), // Ngày đặt hàng (thời gian hiện tại)
        'Delivery_date': Timestamp.fromDate(DateTime.now().add(const Duration(days: 7))), // Ngày giao dự kiến (7 ngày sau)
      };

      // Thêm document mới vào collection 'orders' trên Firebase
      await FirebaseFirestore.instance.collection('orders').add(orderData);

      // Hiện thông báo thành công
      Get.snackbar(
        'Thành công! 🎉',
        'Đơn hàng đã được lưu vào hệ thống!',
        backgroundColor: Colors.green.withOpacity(0.8),
        colorText: Colors.white,
      );
    } catch (e) {
      // Nếu có lỗi thì hiện snackbar lỗi
      Get.snackbar('Lỗi', 'Không thể đặt hàng: $e', backgroundColor: Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>(); // Lấy instance CartController từ GetX

    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true, // Hiện nút back ở AppBar
        title: Text('Giỏ Hàng', style: Theme.of(context).textTheme.headlineSmall), // Tiêu đề "Giỏ Hàng"
      ),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace), // Padding chuẩn xung quanh nội dung
        child: Obx(() { // Obx để tự động rebuild khi cartItems thay đổi
          if (cartController.cartItems.isEmpty) {
            return const Center(child: Text('Giỏ hàng trống')); // Nếu giỏ rỗng thì hiện text giữa màn hình
          }
          return const TCartItemsDynamic(); // Nếu có sản phẩm thì hiện danh sách động (không truyền callback nữa)
        }),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace), // Padding cho nút Check out ở dưới
        child: Obx(() { // Obx để cập nhật tổng tiền realtime
          // Tính tổng tiền giỏ hàng
          double total = cartController.cartItems.fold(0.0, (sum, item) {
            double price = double.tryParse(cartController.getProductLowesPrice(item.product)) ?? 0.0;
            return sum + (price * item.quantity);
          });

          return ElevatedButton(
            onPressed: cartController.cartItems.isEmpty
                ? null // Nếu giỏ rỗng thì disable nút
                : () async {
              // Gọi hàm lưu đơn hàng
              await _placeOrder(total);

              // Xóa sạch giỏ hàng sau khi đặt thành công
              cartController.cartItems.clear();
              cartController.cartItems.refresh();

              // Hiện dialog thông báo thành công
              Get.dialog(
                AlertDialog(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)), // Bo góc dialog
                  title: const Row(
                    children: [
                      Icon(Icons.check_circle, color: Colors.green, size: 30), // Icon tick xanh
                      SizedBox(width: 10),
                      Text('Thanh toán thành công! 🎉'),
                    ],
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Tổng tiền: ${total.toStringAsFixed(0)} VND',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      const Text('Đơn hàng đã được lưu vào hệ thống.\nCảm ơn bạn đã mua sắm! ❤️'),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: Get.back, // Đóng dialog khi bấm OK
                      child: const Text('OK', style: TextStyle(fontSize: 16)),
                    ),
                  ],
                ),
                barrierDismissible: false, // Không cho đóng dialog bằng cách bấm ngoài
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: TColors.primary), // Màu nút primary
            child: Text('Check out ${total.toStringAsFixed(0)} VND'), // Text nút hiển thị tổng tiền
          );
        }),
      ),
    );
  }
}