import 'package:cloud_firestore/cloud_firestore.dart'; // Import Cloud Firestore - database của Firebase
import 'package:get/get.dart'; // Import GetX - dùng cho snackbar và state management
import '../../../features/shop/models/category_model.dart'; // Import CategoryModel


class CategoryRepository extends GetxController { // Repository xử lý CRUD danh mục - kế thừa GetxController
  static CategoryRepository get instance => Get.find(); // Getter để lấy instance của CategoryRepository từ GetX dependency injection

  final FirebaseFirestore _firestore = FirebaseFirestore.instance; // Lấy instance của Firestore database

  final String _collectionPath = 'Categories'; // Đường dẫn collection trong Firestore

  // Static getter to access the instance of the CategoryController

  // Method to fetch all categories from Firestore
  Future<List<CategoryModel>> getAllCategories() async { // Hàm lấy tất cả danh mục từ Firestore
    try { // Bắt đầu khối try-catch để xử lý lỗi
      // Fetching data from Firestore
      final snapshot = await _firestore.collection(_collectionPath).get(); // Lấy tất cả documents từ collection 'Categories'

      if (snapshot.docs.isEmpty) { // Nếu không có documents
        // Handle case where there are no documents
        Get.snackbar('No Data', 'No categories found'); // Hiển thị snackbar thông báo không có dữ liệu
        return []; // Trả về list rỗng
      }

      final list = snapshot.docs.map((doc) => CategoryModel.fromSnapshot(doc)).toList(); // Chuyển đổi tất cả documents thành CategoryModel và tạo list

      // Check and print the list contents in the terminal
      print('Fetched Categories:'); // In thông báo ra console
      for (var category in list) { // Lặp qua từng danh mục
        print('Category: ${category.name}'); // In tên danh mục ra console để debug
      }

      return list; // Trả về list danh mục

    } catch (e) { // Bắt lỗi nếu có
      // Show error message if fetching categories fails
      Get.snackbar('Error', 'Error fetching categories: $e'); // Hiển thị snackbar thông báo lỗi
      return []; // Trả về list rỗng khi có lỗi
    }
  }
}
