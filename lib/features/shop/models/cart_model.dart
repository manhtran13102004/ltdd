import 'cart_item_model.dart';

class CartModel {
  const CartModel({required this.items});

  final List<CartItemModel> items;

  int get totalItems => items.fold(0, (sum, item) => sum + item.quantity);
  double get totalPrice => items.fold(0.0, (sum, item) => sum + item.totalPrice);
}
