import 'package:flutter/material.dart'; // Import Flutter Material - cung cấp các widget cơ bản
import 'package:project/common/widgets/appbar/appbar.dart'; // Import widget AppBar chung
import 'package:project/features/shop/screens/order/widgets/orders_list.dart'; // Import widget hiển thị danh sách đơn hàng
import 'package:project/utils/constants/sizes.dart'; // Import kích thước chuẩn
class OrderScreen extends StatelessWidget { // Màn hình đơn hàng - StatelessWidget
  const OrderScreen({super.key}); // Constructor với key từ parent widget

  @override
  Widget build(BuildContext context) { // Hàm build - xây dựng UI
    return  Scaffold( // Scaffold - widget cơ bản nhất của Material Design
      appBar: TAppBar(title: Text('Đơn Hàng', style: Theme.of(context).textTheme.headlineSmall,), showBackArrow: true, ), // AppBar với nút back và tiêu đề "Đơn Hàng"

      body: const Padding( // Padding xung quanh nội dung
          padding: EdgeInsets.all(TSizes.defaultSpace), // Padding chuẩn cho tất cả các cạnh
          child: TOrdersListItems(), // Widget hiển thị danh sách đơn hàng

      ),


    );
  }
}
