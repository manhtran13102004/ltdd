// lib/features/shop/models/orders_model.dart

import 'package:cloud_firestore/cloud_firestore.dart';

class OrdersModel {
  final String id;
  final String userEmail;
  final double totalPrice;
  final String status; // "Done", "Pending", "Cancelled"...
  final Timestamp orderDate;
  final Timestamp? deliveryDate;

  OrdersModel({
    required this.id,
    required this.userEmail,
    required this.totalPrice,
    required this.status,
    required this.orderDate,
    this.deliveryDate,
  });

  factory OrdersModel.fromSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return OrdersModel(
      id: doc.id,
      userEmail: data['User'] ?? '',
      totalPrice: (data['TotalPrice'] as num).toDouble(),
      status: data['Status'] ?? 'Pending',
      orderDate: data['Order_date'] ?? Timestamp.now(),
      deliveryDate: data['Delivery_date'],
    );
  }

  // Để hiển thị ngày đẹp
  String get formattedOrderDate {
    return '${orderDate.toDate().day}/${orderDate.toDate().month}/${orderDate.toDate().year}';
  }

  String get formattedDeliveryDate {
    if (deliveryDate == null) return 'Chưa giao';
    final date = deliveryDate!.toDate();
    return '${date.day}/${date.month}/${date.year}';
  }
}