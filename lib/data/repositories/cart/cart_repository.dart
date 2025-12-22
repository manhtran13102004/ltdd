import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../../features/shop/models/cart_item_model.dart';

class CartRepository extends GetxController {
  static CartRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> _itemsRef(String uid) {
    return _db.collection('carts').doc(uid).collection('items');
  }

  Future<List<CartItemModel>> fetchCartItems(String uid) async {
    final snapshot = await _itemsRef(uid).get();
    return snapshot.docs.map((doc) => CartItemModel.fromSnapshot(doc)).toList();
  }

  Future<void> upsertCartItem(String uid, CartItemModel item) async {
    await _itemsRef(uid).doc(item.id).set(item.toJson());
  }

  Future<void> setCartItems(String uid, List<CartItemModel> items) async {
    final batch = _db.batch();
    final ref = _itemsRef(uid);
    for (final item in items) {
      batch.set(ref.doc(item.id), item.toJson());
    }
    await batch.commit();
  }

  Future<void> deleteCartItem(String uid, String itemId) async {
    await _itemsRef(uid).doc(itemId).delete();
  }

  Future<void> clearCart(String uid) async {
    final snapshot = await _itemsRef(uid).get();
    final batch = _db.batch();
    for (final doc in snapshot.docs) {
      batch.delete(doc.reference);
    }
    await batch.commit();
  }
}
