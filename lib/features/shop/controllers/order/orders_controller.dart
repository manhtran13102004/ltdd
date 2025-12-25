// lib/features/shop/controllers/order/orders_controller.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../models/orders_model.dart';

class OrdersController extends GetxController {
  static OrdersController get instance => Get.find();

  final RxList<OrdersModel> orders = <OrdersModel>[].obs;
  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchOrders(); // Gọi trực tiếp fetch khi vào trang
  }

  Future<void> fetchOrders() async {
    try {
      isLoading.value = true;
      orders.clear();

      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null || currentUser.email == null) {
        isLoading.value = false;
        return;
      }

      // FIX HOA/THƯỜNG EMAIL ĐỂ CHẮC CHẮN KHỚP
      final userEmail = currentUser.email!.trim().toLowerCase();

      final snapshot = await FirebaseFirestore.instance
          .collection('orders')
          .where('User', isEqualTo: userEmail)
          .orderBy('Order_date', descending: true)
          .get();

      final list = snapshot.docs.map((doc) => OrdersModel.fromSnapshot(doc)).toList();

      orders.assignAll(list);
    } catch (e) {
      print('Lỗi fetch orders: $e');
      Get.snackbar('Lỗi', 'Không tải được đơn hàng');
    } finally {
      isLoading.value = false;
    }
  }
}