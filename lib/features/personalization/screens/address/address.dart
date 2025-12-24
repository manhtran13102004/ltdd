import 'package:flutter/material.dart'; // Import Flutter Material - cung cấp các widget cơ bản
import 'package:get/get.dart'; // Import GetX - dùng cho navigation
import 'package:get/get_core/src/get_main.dart'; // Import GetX core (có thể không cần thiết)
import 'package:iconsax/iconsax.dart'; // Import icon pack Iconsax
import 'package:project/common/widgets/appbar/appbar.dart'; // Import widget AppBar chung
import 'package:project/features/personalization/screens/address/widgets/single_address.dart'; // Import widget hiển thị một địa chỉ
import 'package:project/utils/constants/colors.dart'; // Import màu sắc chuẩn

import '../../../../common/widgets/containers/rounded_container.dart'; // Import widget container bo góc (có thể không dùng trực tiếp)
import '../../../../utils/constants/sizes.dart'; // Import kích thước chuẩn
import 'add_new_address.dart'; // Import màn hình thêm địa chỉ mới

class UserAddressScreen extends StatelessWidget { // Màn hình quản lý địa chỉ - StatelessWidget
  const UserAddressScreen({super.key}); // Constructor với key từ parent widget

  @override
  Widget build(BuildContext context) { // Hàm build - xây dựng UI
    return Scaffold( // Scaffold - widget cơ bản nhất của Material Design
      floatingActionButton: FloatingActionButton( // FloatingActionButton - nút nổi ở góc dưới bên phải
          backgroundColor: TColors.primary, // Màu nền primary
          onPressed: () => Get.to(() => const  AddNewAddressScreen()), // Khi click, navigate đến màn hình thêm địa chỉ mới
           child: const Icon(Iconsax.add, color: TColors.white,), // Icon dấu cộng màu trắng
      ),
      appBar: TAppBar( // AppBar của màn hình
        showBackArrow: true, // Hiển thị nút back
        title: Text('Địa chỉ',style: Theme.of(context).textTheme.headlineSmall,), // Tiêu đề "Địa chỉ"
      ),
      body: const SingleChildScrollView( // SingleChildScrollView - cho phép cuộn nội dung
        child: Padding( // Padding xung quanh nội dung
            padding: EdgeInsets.all(TSizes.defaultSpace), // Padding chuẩn cho tất cả các cạnh
            child: Column( // Column - sắp xếp các widget theo chiều dọc
              children: [ // Danh sách các widget con
                TSingleAddress(selectedAddress: true, address: 'Số 12, Chùa Bộc, Đống Đa, Hà Nội'), // Widget hiển thị địa chỉ được chọn (selectedAddress = true)
                TSingleAddress(selectedAddress: false, address: '123 Main St, Los Angeles, CA'), // Widget hiển thị địa chỉ không được chọn (selectedAddress = false)
              ],
            ),
        ),
      ),
    );
  }
}
