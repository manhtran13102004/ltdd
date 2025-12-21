// File màn hình thêm địa chỉ mới - form nhập thông tin địa chỉ giao hàng

import 'package:flutter/material.dart'; // Import Flutter Material - cung cấp các widget cơ bản
import 'package:iconsax/iconsax.dart'; // Import icon pack Iconsax
import 'package:project/common/widgets/appbar/appbar.dart'; // Import widget AppBar chung

import '../../../../utils/constants/sizes.dart'; // Import kích thước chuẩn

class AddNewAddressScreen extends StatelessWidget { // Màn hình thêm địa chỉ mới - StatelessWidget
  const AddNewAddressScreen ({super.key}); // Constructor với key từ parent widget

  @override
  Widget build(BuildContext context) { // Hàm build - xây dựng UI
    return Scaffold( // Scaffold - widget cơ bản nhất của Material Design
      appBar: const TAppBar(showBackArrow: true,title: Text('Thêm địa chỉ mới'),), // AppBar với nút back và tiêu đề "Thêm địa chỉ mới"
      body: SingleChildScrollView( // SingleChildScrollView - cho phép cuộn nội dung
        child: Padding( // Padding xung quanh nội dung
          padding: const EdgeInsets.all(TSizes.defaultSpace), // Padding chuẩn cho tất cả các cạnh
          child: Column( // Column - sắp xếp các widget theo chiều dọc
            children: [ // Danh sách các widget con
              TextFormField(decoration: const InputDecoration(prefixIcon: Icon(Iconsax.user), labelText: 'Họ & Tên'),), // TextField cho họ và tên người nhận
              const SizedBox(height: TSizes.spaceBtwInputFields,), // Khoảng cách giữa TextField họ tên và số điện thoại
              TextFormField(decoration: const InputDecoration(prefixIcon: Icon(Iconsax.mobile), labelText: 'Số Điện Thoại'),), // TextField cho số điện thoại người nhận
              const SizedBox(height: TSizes.spaceBtwInputFields,), // Khoảng cách giữa TextField số điện thoại và địa chỉ
              TextFormField(decoration: const InputDecoration(prefixIcon: Icon(Iconsax.building_31), labelText: 'Địa Chỉ'),), // TextField cho địa chỉ giao hàng
              const SizedBox(height: TSizes.defaultSpace,), // Khoảng cách giữa TextField địa chỉ và nút lưu
              SizedBox(width: double.infinity,child: ElevatedButton(onPressed: (){}, child: const Text('Lưu địa chỉ')),) // Nút "Lưu địa chỉ" - callback chưa được implement (nên lưu địa chỉ vào database)
            ],
          ),
        ),
      ),
    );
  }
}
