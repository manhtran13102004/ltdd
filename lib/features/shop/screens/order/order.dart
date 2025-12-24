// lib/features/shop/screens/orders/orders_screen.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/common/widgets/appbar/appbar.dart';
import 'package:project/features/shop/controllers/order/orders_controller.dart';
import 'package:project/utils/constants/colors.dart';
import 'package:project/utils/constants/sizes.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrdersController());

    return Scaffold(
      appBar: TAppBar(
        title: Text('Đơn hàng của tôi', style: Theme.of(context).textTheme.headlineMedium),
        showBackArrow: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.orders.isEmpty) {
          return const Center(
            child: Text(
              'Chưa có đơn hàng nào',
              style: TextStyle(fontSize: 18, color: TColors.darkGrey),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          itemCount: controller.orders.length,
          itemBuilder: (context, index) {
            final order = controller.orders[index];

            return Card(
              margin: const EdgeInsets.only(bottom: TSizes.spaceBtwItems),
              child: Padding(
                padding: const EdgeInsets.all(TSizes.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Đơn hàng #${order.id.substring(0, 8)}',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Chip(
                          label: Text(order.status),
                          backgroundColor: order.status == 'Done'
                              ? Colors.green
                              : order.status == 'Pending'
                              ? Colors.orange
                              : Colors.red,
                          labelStyle: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems / 2),
                    Text('Ngày đặt: ${order.formattedOrderDate}'),
                    Text('Dự kiến giao: ${order.formattedDeliveryDate}'),
                    const SizedBox(height: TSizes.spaceBtwItems / 2),
                    Text(
                      'Tổng tiền: ${order.totalPrice.toStringAsFixed(0)} VND',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: TColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}