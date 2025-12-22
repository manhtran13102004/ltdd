import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../controllers/cart/cart_controller.dart';

class TBillingAmountSection extends StatelessWidget {
  const TBillingAmountSection ({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    return Obx(() {
      final subTotal = controller.totalPrice;
      final shipping = controller.shippingFee;
      final total = controller.orderTotal;
      return Column(
        children: [
          Row(
            mainAxisAlignment:  MainAxisAlignment.spaceBetween,
            children: [

              Text('Tổng Tiền', style: Theme.of(context).textTheme.bodyMedium,),
              Text(controller.formatCurrency(subTotal), style: Theme.of(context).textTheme.bodyMedium,),

            ],
          ),

          const SizedBox(height: TSizes.spaceBtwItems / 2,),

          Row(
            mainAxisAlignment:  MainAxisAlignment.spaceBetween,
            children: [

              Text('Phí Vận Chuyển', style: Theme.of(context).textTheme.bodyMedium,),
              Text(controller.formatCurrency(shipping), style: Theme.of(context).textTheme.labelLarge,),

            ],
          ),
          const SizedBox(height: TSizes.spaceBtwItems / 2,),

          Row(
            mainAxisAlignment:  MainAxisAlignment.spaceBetween,
            children: [

              Text('Thanh Toán', style: Theme.of(context).textTheme.bodyMedium,),
              Text(controller.formatCurrency(total), style: Theme.of(context).textTheme.titleMedium,),

            ],
          ),


        ],
      );
    });
  }
}
