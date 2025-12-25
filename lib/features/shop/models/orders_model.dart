// lib/features/shop/models/orders_model.dart

import 'package:cloud_firestore/cloud_firestore.dart';

class OrdersModel {
  final String id;
  final String userEmail;
  final double totalPrice;
  final String status;
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
      userEmail: data['User'] ?? '', // ← ĐÚNG FIELD "User" (U hoa)
      totalPrice: (data['TotalPrice'] as num?)?.toDouble() ?? 0.0, // ← "TotalPrice" (không gạch dưới)
      status: data['Status'] ?? 'Done', // ← "Status"
      orderDate: data['Order_date'] ?? Timestamp.now(), // ← "Order_date" (gạch dưới)
      deliveryDate: data['Delivery_date'], // ← "Delivery_date" (gạch dưới)
    );
  }

  String get formattedOrderDate {
    final date = orderDate.toDate();
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  String get formattedDeliveryDate {
    if (deliveryDate == null) return 'Chưa xác định';
    final date = deliveryDate!.toDate();
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }
}