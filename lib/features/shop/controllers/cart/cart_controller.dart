import 'package:flutter/material.dart'; // ← THÊM DÒNG NÀY ĐỂ DÙNG Colors.green
import 'package:get/get.dart';
import 'package:project/features/shop/models/product_model.dart';
import 'package:project/utils/constants/enums.dart'; // ← THÊM DÒNG NÀY ĐỂ DÙNG ProductType
class CartItem {
  final ProductModel product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}

class CartController extends GetxController {
  static CartController get instance => Get.find();

  final RxList<CartItem> cartItems = <CartItem>[].obs;

  // Thêm sản phẩm vào giỏ (nếu đã có thì tăng số lượng)
  void addToCart(ProductModel product, int quantity) {
    final existingItem = cartItems.firstWhereOrNull(
      (item) => item.product.id == product.id,
    );

    if (existingItem != null) {
      existingItem.quantity += quantity;
    } else {
      cartItems.add(CartItem(product: product, quantity: quantity));
    }

    // IN RA CONSOLE CHI TIẾT GIỎ HÀNG SAU KHI THÊM
    print('=====================================');
    print('ĐÃ THÊM VÀO GIỎ HÀNG THÀNH CÔNG!');
    print('Sản phẩm vừa thêm: ${product.title} (x$quantity)');
    print('Tổng số món trong giỏ: ${cartItems.length}');
    print('Tổng số lượng sản phẩm: $totalItems');
    print('--- Danh sách chi tiết giỏ hàng ---');
    for (var item in cartItems) {
      print('- ${item.product.title} | Số lượng: ${item.quantity} | ID: ${item.product.id}');
    }
    print('=====================================');

    cartItems.refresh(); // Cập nhật UI

    // Hiện thông báo thành công
    Get.snackbar(
      'Thành công! 🎉',
      'Đã thêm $quantity ${product.title} vào giỏ hàng',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green.withOpacity(0.8),
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );
  }

  // Tổng số lượng trong giỏ (dùng để badge nếu cần)
  int get totalItems => cartItems.fold(0, (sum, item) => sum + item.quantity);


  String getProductLowesPrice(ProductModel product) {
    double smallestPrice = double.infinity;

    if (product.productType == ProductType.single.toString()) {
      return (product.salePrice > 0 ? product.salePrice : product.price).toStringAsFixed(0);
    }

    for (var variation in product.productVariations!) {
      double price = variation.salePrice > 0 ? variation.salePrice : variation.price;
      if (price < smallestPrice) smallestPrice = price;
    }

    return smallestPrice.toStringAsFixed(0);
  }
}