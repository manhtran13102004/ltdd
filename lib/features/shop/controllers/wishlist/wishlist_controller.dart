import 'package:get/get.dart';
import 'package:project/features/shop/models/product_model.dart';
import 'package:flutter/material.dart'; // ← THÊM DÒNG NÀY ĐỂ DÙNG Colors.red, Colors.orange

class WishlistController extends GetxController {
  static WishlistController get instance => Get.find();

  final RxList<ProductModel> wishlistItems = <ProductModel>[].obs;

  // Kiểm tra sản phẩm đã trong wishlist chưa
  bool isInWishlist(ProductModel product) {
    return wishlistItems.any((item) => item.id == product.id);
  }

  // Toggle thêm/xóa khỏi wishlist
  void toggleWishlist(ProductModel product) {
    if (isInWishlist(product)) {
      wishlistItems.removeWhere((item) => item.id == product.id);
      Get.snackbar(
        'Đã xóa',
        '${product.title} đã được xóa khỏi wishlist',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.orange.withOpacity(0.8),
        colorText: Colors.white,
      );
    } else {
      wishlistItems.add(product);
      Get.snackbar(
        'Thành công! ❤️',
        '${product.title} đã được thêm vào wishlist',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
    }
    wishlistItems.refresh();
  }

  // Tổng số sản phẩm trong wishlist (dùng cho badge nếu cần)
  int get totalItems => wishlistItems.length;
}