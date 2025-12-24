// lib/features/shop/controllers/orders/orders_controller.dart

import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/orders_model.dart';

class OrdersController extends GetxController {
  static OrdersController get instance => Get.find();

  final RxList<OrdersModel> orders = <OrdersModel>[].obs;
  final isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    try {
      isLoading.value = true;
      final snapshot = await FirebaseFirestore.instance.collection('orders').get();

      final list = snapshot.docs.map((doc) => OrdersModel.fromSnapshot(doc)).toList();

      // Sắp xếp theo ngày đặt hàng mới nhất trước
      list.sort((a, b) => b.orderDate.compareTo(a.orderDate));

      orders.assignAll(list);
    } catch (e) {
      Get.snackbar('Lỗi', 'Không tải được đơn hàng: $e');
    } finally {
      isLoading.value = false;
    }
  }
}