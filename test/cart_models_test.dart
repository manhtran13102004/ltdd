import 'package:flutter_test/flutter_test.dart';
import 'package:project/features/shop/models/cart_item_model.dart';
import 'package:project/features/shop/models/cart_model.dart';

void main() {
  test('CartItemModel totalPrice computes price * quantity', () {
    const item = CartItemModel(
      id: 'item-1',
      productId: 'p1',
      title: 'Item 1',
      price: 12.5,
      quantity: 3,
      image: 'img',
    );
    expect(item.totalPrice, 37.5);
  });

  test('CartItemModel.buildItemId prefers variation id', () {
    final id = CartItemModel.buildItemId(
      productId: 'p1',
      variationId: 'v1',
      selectedAttributes: {'size': 'M'},
    );
    expect(id, 'p1-v1');
  });

  test('CartItemModel.buildItemId sorts attribute keys', () {
    final id = CartItemModel.buildItemId(
      productId: 'p1',
      selectedAttributes: {'size': 'M', 'color': 'Red'},
    );
    expect(id, 'p1-color:Red|size:M');
  });

  test('CartModel totals aggregate items', () {
    const items = [
      CartItemModel(
        id: 'item-1',
        productId: 'p1',
        title: 'Item 1',
        price: 10.0,
        quantity: 2,
        image: 'img1',
      ),
      CartItemModel(
        id: 'item-2',
        productId: 'p2',
        title: 'Item 2',
        price: 7.5,
        quantity: 1,
        image: 'img2',
      ),
    ];
    const cart = CartModel(items: items);
    expect(cart.totalItems, 3);
    expect(cart.totalPrice, 27.5);
  });
}
