import 'package:cloud_firestore/cloud_firestore.dart'; // Import Cloud Firestore - dùng cho DocumentSnapshot
import 'package:flutter/material.dart'; // Import Flutter Material (có thể không dùng trực tiếp)

class CategoryModel { // Model đại diện cho thông tin danh mục sản phẩm
  String id; // ID của danh mục (thường là document ID từ Firestore)
  String name; // Tên danh mục
  String image; // URL hình ảnh danh mục
  String parentId; // ID danh mục cha (để tạo cấu trúc danh mục phân cấp)
  bool isFeatured; // Có phải danh mục nổi bật không

  // Constructor
  CategoryModel({ // Constructor của CategoryModel
    required this.id, // Tham số bắt buộc: id
    required this.name, // Tham số bắt buộc: name
    required this.image, // Tham số bắt buộc: image
    this.parentId = '', // Tham số tùy chọn: parentId (mặc định = chuỗi rỗng)
    required this.isFeatured, // Tham số bắt buộc: isFeatured
  });

  // Phương thức khởi tạo trống
  static CategoryModel empty() => CategoryModel(id: '', name: '', image: '', isFeatured: true); // Hàm tĩnh để tạo CategoryModel rỗng với isFeatured = true

  // Phương thức từ Map -> CategoryModel (dùng khi lấy từ Firestore)
  factory CategoryModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) { // Factory constructor để tạo CategoryModel từ Firestore DocumentSnapshot
    final data = document.data(); // Lấy dữ liệu từ document
    if (data != null) { // Nếu data không null
      return CategoryModel( // Trả về CategoryModel mới
        id: document.id, // Lấy id từ document ID
        name: data['Name'] ?? '', // Lấy Name từ data, nếu null thì dùng chuỗi rỗng
        image: data['Image'] ?? '', // Lấy Image từ data, nếu null thì dùng chuỗi rỗng
        parentId: data['ParentId'] ?? '', // Lấy ParentId từ data, nếu null thì dùng chuỗi rỗng
        isFeatured: data['IsFeatured'] ?? false, // Lấy IsFeatured từ data, nếu null thì dùng false
      );
    } else { // Nếu data null
      throw StateError('Document does not exist or has no data'); // Ném lỗi nếu document không tồn tại hoặc không có dữ liệu
    }
  }

  // Phương thức từ CategoryModel -> Map (dùng khi lưu vào Firestore)
  Map<String, dynamic> toJson() { // Hàm chuyển đổi CategoryModel thành Map để lưu vào Firestore
    return { // Trả về Map với các key-value
      'Name': name, // Key 'Name' với giá trị name
      'Image': image, // Key 'Image' với giá trị image
      'ParentId': parentId, // Key 'ParentId' với giá trị parentId
      'IsFeatured': isFeatured, // Key 'IsFeatured' với giá trị isFeatured
    };
  }
}
