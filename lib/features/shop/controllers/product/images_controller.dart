import 'dart:async'; // Import thư viện async (có thể không dùng trực tiếp)
import 'package:cached_network_image/cached_network_image.dart'; // Import CachedNetworkImage - widget hiển thị ảnh từ URL với cache
import 'package:flutter/material.dart'; // Import Flutter Material - cung cấp các widget cơ bản
import 'package:get/get.dart'; // Import GetX - dùng cho state management và navigation
import 'package:project/utils/constants/sizes.dart'; // Import kích thước chuẩn
import '../../../../data/repositories/banners/banner_repository.dart'; // Import BannerRepository (có thể không dùng trực tiếp)
import '../../../../data/repositories/product/product_repository.dart'; // Import ProductRepository (có thể không dùng trực tiếp)
import '../../../../utils/constants/colors.dart'; // Import màu sắc chuẩn
import '../../../../utils/constants/enums.dart'; // Import enums (có thể không dùng trực tiếp)
import '../../models/banner_model.dart'; // Import BannerModel (có thể không dùng trực tiếp)
import '../../models/product_model.dart'; // Import ProductModel

class ImagesController extends GetxController { // Controller xử lý logic hình ảnh sản phẩm - kế thừa GetxController
  static ImagesController get instance => Get.find(); // Getter để lấy instance của ImagesController từ GetX dependency injection

  RxString selectedProductImage = ''.obs; // Observable để lưu URL hình ảnh sản phẩm đang được chọn

  List<String> getAllProductImages(ProductModel product) { // Hàm lấy tất cả hình ảnh của sản phẩm (thumbnail, images, variation images)
    Set<String> images = {}; // Khởi tạo Set để lưu các URL hình ảnh (Set để tránh trùng lặp)

    // Thêm ảnh thumbnail vào danh sách ảnh
    images.add(product.thumbnail); // Thêm thumbnail vào Set

    // Cập nhật selectedProductImage sau khi build hoàn tất
    WidgetsBinding.instance.addPostFrameCallback((_) { // Gọi callback sau khi frame hiện tại được render xong
      // Luôn cập nhật selectedProductImage với thumbnail của sản phẩm hiện tại
      selectedProductImage.value = product.thumbnail; // Đặt selectedProductImage = thumbnail
    });

    // Thêm các ảnh từ product.images nếu có
    if (product.images != null) { // Nếu product.images không null
      images.addAll(product.images!); // Thêm tất cả ảnh từ product.images vào Set
    }

    // Thêm ảnh từ productVariations nếu có
    if (product.productVariations != null && product.productVariations!.isNotEmpty) { // Nếu có biến thể và không rỗng
      images.addAll(product.productVariations!.map((variation) => variation.image)); // Thêm ảnh từ tất cả các biến thể vào Set
    }

    return images.toList(); // Chuyển Set thành List và trả về
  }


  void showEnlargedImage(String image) { // Hàm hiển thị hình ảnh phóng to trong dialog fullscreen
    Get.to( // Navigate đến màn hình mới
      fullscreenDialog: true, // Đặt fullscreenDialog = true để hiển thị như dialog fullscreen
          () => Dialog.fullscreen( // Tạo Dialog fullscreen
        child: Container( // Container chứa nội dung dialog
          color: TColors.white, // Màu nền trắng
          child: Column( // Column để sắp xếp các widget theo chiều dọc
            mainAxisAlignment: MainAxisAlignment.center, // Căn giữa theo chiều dọc
            crossAxisAlignment: CrossAxisAlignment.center, // Căn giữa theo chiều ngang
            mainAxisSize: MainAxisSize.min, // Kích thước tối thiểu
            children: [ // Danh sách các widget con
              Padding( // Padding xung quanh hình ảnh
                padding: const EdgeInsets.symmetric( // Padding đối xứng
                  vertical: TSizes.defaultSpace * 2, // Padding dọc = defaultSpace * 2
                  horizontal: TSizes.defaultSpace, // Padding ngang = defaultSpace
                ),
                child: CachedNetworkImage(imageUrl: image), // Hiển thị hình ảnh từ URL với cache
              ),
              const SizedBox(height: TSizes.spaceBtwSections), // Khoảng cách giữa hình ảnh và nút
              Align( // Căn chỉnh nút
                alignment: Alignment.bottomCenter, // Căn giữa dưới cùng
                child: SizedBox( // SizedBox để giới hạn kích thước nút
                  width: 150, // Chiều rộng 150 pixels
                  child: OutlinedButton( // Nút có viền
                    onPressed: () => Get.back(), // Khi click, quay lại màn hình trước
                    child: const Text('Close'), // Text hiển thị "Close"
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
