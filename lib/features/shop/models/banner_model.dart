import 'package:cloud_firestore/cloud_firestore.dart'; // Import Cloud Firestore - dùng cho DocumentSnapshot
import 'package:flutter/material.dart'; // Import Flutter Material (có thể không dùng trực tiếp)

class BannerModel { // Model đại diện cho thông tin banner
  String imageUrl; // URL hình ảnh banner
  String targetScreen; // Màn hình đích khi click vào banner (route name)
  bool active; // Trạng thái banner (true = đang hoạt động, false = không hoạt động)

  // Constructor
  BannerModel({ // Constructor của BannerModel
    required this.imageUrl, // Tham số bắt buộc: imageUrl
    required this.targetScreen, // Tham số bắt buộc: targetScreen
    required this.active, // Tham số bắt buộc: active
  });



// Phương thức từ Map -> CategoryModel (dùng khi lấy từ Firestore) - comment có thể sai, nên là BannerModel
  factory BannerModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) { // Factory constructor để tạo BannerModel từ Firestore DocumentSnapshot
    final data = document.data(); // Lấy dữ liệu từ document
    if (data != null) { // Nếu data không null
      return BannerModel( // Trả về BannerModel mới
        imageUrl: data['ImageUrl'] ?? '', // Lấy ImageUrl từ data, nếu null thì dùng chuỗi rỗng
        targetScreen: data['TargetScreen'] ?? '', // Lấy TargetScreen từ data, nếu null thì dùng chuỗi rỗng
        active: data['Active'] ?? false, // Lấy Active từ data, nếu null thì dùng false
      );
    } else { // Nếu data null
      throw StateError('Document does not exist or has no data'); // Ném lỗi nếu document không tồn tại hoặc không có dữ liệu
    }
  }

  // Phương thức từ CategoryModel -> Map (dùng khi lưu vào Firestore) - comment có thể sai, nên là BannerModel
  Map<String, dynamic> toJson() { // Hàm chuyển đổi BannerModel thành Map để lưu vào Firestore
    return { // Trả về Map với các key-value
      'Active': active, // Key 'Active' với giá trị active
      'ImageUrl': imageUrl, // Key 'ImageUrl' với giá trị imageUrl
      'TargetScreen': targetScreen, // Key 'TargetScreen' với giá trị targetScreen
    };
  }
}
