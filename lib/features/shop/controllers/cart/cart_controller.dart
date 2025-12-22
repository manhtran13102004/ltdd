import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../../../../data/repositories/cart/cart_repository.dart';
import '../../models/cart_item_model.dart';
import '../../models/cart_model.dart';
import '../../models/product_model.dart';
import '../../models/product_variation.dart';

class CartController extends GetxController {
  static CartController get instance => Get.find();

  final cartItems = <CartItemModel>[].obs;
  final CartRepository _repo = Get.put(CartRepository());

  StreamSubscription<User?>? _authSubscription;
  String? _userId;

  @override
  void onInit() {
    super.onInit();
    _authSubscription = FirebaseAuth.instance.userChanges().listen(_handleAuthChanged);
  }

  @override
  void onClose() {
    _authSubscription?.cancel();
    super.onClose();
  }

  CartModel get cart => CartModel(items: cartItems);
  int get totalItems => cart.totalItems;
  double get totalPrice => cart.totalPrice;
  double get shippingFee => cartItems.isEmpty ? 0.0 : 10.0;
  double get orderTotal => totalPrice + shippingFee;

  String formatPrice(double value) => value.toStringAsFixed(0);
  String formatCurrency(double value) => '${formatPrice(value)}.000 VND';

  Future<void> _handleAuthChanged(User? user) async {
    _userId = user?.uid;
    if (user == null) {
      cartItems.clear();
      return;
    }
    await syncOnLogin(user.uid);
  }

  Future<void> syncOnLogin(String uid) async {
    final remoteItems = await _repo.fetchCartItems(uid);
    if (cartItems.isEmpty) {
      cartItems.assignAll(remoteItems);
      return;
    }

    final merged = <String, CartItemModel>{};
    for (final item in remoteItems) {
      merged[item.id] = item;
    }
    for (final local in cartItems) {
      final existing = merged[local.id];
      if (existing == null) {
        merged[local.id] = local;
      } else {
        merged[local.id] = existing.copyWith(
          quantity: existing.quantity + local.quantity,
        );
      }
    }
    final mergedList = merged.values.toList();
    cartItems.assignAll(mergedList);
    await _repo.setCartItems(uid, mergedList);
  }

  double _resolvePrice(ProductModel product, ProductVariationModel? variation) {
    if (variation != null && variation.id.isNotEmpty) {
      return variation.salePrice > 0 ? variation.salePrice : variation.price;
    }
    return product.salePrice > 0 ? product.salePrice : product.price;
  }

  String _resolveImage(ProductModel product, ProductVariationModel? variation) {
    if (variation != null && variation.image.isNotEmpty) {
      return variation.image;
    }
    return product.thumbnail;
  }

  Future<void> addItem(
    ProductModel product, {
    int quantity = 1,
    ProductVariationModel? variation,
    Map<String, String>? selectedAttributes,
  }) async {
    if (quantity <= 0) return;

    final variationId = variation?.id ?? '';
    final attributes = selectedAttributes ?? {};
    final itemId = CartItemModel.buildItemId(
      productId: product.id,
      variationId: variationId,
      selectedAttributes: attributes,
    );

    final existingIndex = cartItems.indexWhere((item) => item.id == itemId);
    if (existingIndex >= 0) {
      final existingItem = cartItems[existingIndex];
      final updatedItem = existingItem.copyWith(
        quantity: existingItem.quantity + quantity,
      );
      cartItems[existingIndex] = updatedItem;
      cartItems.refresh();
      if (_userId != null) {
        await _repo.upsertCartItem(_userId!, updatedItem);
      }
      return;
    }

    final item = CartItemModel(
      id: itemId,
      productId: product.id,
      title: product.title,
      price: _resolvePrice(product, variation),
      quantity: quantity,
      image: _resolveImage(product, variation),
      variationId: variationId.isEmpty ? null : variationId,
      selectedAttributes: attributes,
    );
    cartItems.add(item);
    if (_userId != null) {
      await _repo.upsertCartItem(_userId!, item);
    }
  }

  Future<void> updateItemQuantity(String itemId, int quantity) async {
    if (quantity <= 0) {
      await removeItem(itemId);
      return;
    }
    final index = cartItems.indexWhere((item) => item.id == itemId);
    if (index < 0) return;

    final updatedItem = cartItems[index].copyWith(quantity: quantity);
    cartItems[index] = updatedItem;
    cartItems.refresh();
    if (_userId != null) {
      await _repo.upsertCartItem(_userId!, updatedItem);
    }
  }

  Future<void> removeItem(String itemId) async {
    cartItems.removeWhere((item) => item.id == itemId);
    if (_userId != null) {
      await _repo.deleteCartItem(_userId!, itemId);
    }
  }

  Future<void> clearCart() async {
    cartItems.clear();
    if (_userId != null) {
      await _repo.clearCart(_userId!);
    }
  }
}
