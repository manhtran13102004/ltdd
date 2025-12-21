import 'package:cloud_firestore/cloud_firestore.dart'; // Import Cloud Firestore - database của Firebase
import 'package:get/get.dart'; // Import GetX - dùng cho snackbar và state management
import 'package:project/features/shop/models/banner_model.dart'; // Import BannerModel
import '../../../features/shop/models/category_model.dart'; // Import CategoryModel (có thể không dùng trực tiếp)


class BannerRepository extends GetxController { // Repository xử lý CRUD banner - kế thừa GetxController
  static BannerRepository  get instance => Get.find(); // Getter để lấy instance của BannerRepository từ GetX dependency injection

  final FirebaseFirestore _firestore = FirebaseFirestore.instance; // Lấy instance của Firestore database

  final String _collectionPath = 'Banners'; // Đường dẫn collection trong Firestore

  // Static getter to access the instance of the CategoryController

  // Method to fetch all categories from Firestore
  Future<List<BannerModel>> getAllBanners() async { // Hàm lấy tất cả banners từ Firestore (comment có thể sai, nên là 'Method to fetch all banners from Firestore')
    try { // Bắt đầu khối try-catch để xử lý lỗi
      // Fetching data from Firestore
      final snapshot = await _firestore.collection(_collectionPath).get(); // Lấy tất cả documents từ collection 'Banners'

      if (snapshot.docs.isEmpty) { // Nếu không có documents
        // Handle case where there are no documents
        Get.snackbar('No Data', 'No categories found'); // Hiển thị snackbar thông báo (comment có thể sai, nên là 'No banners found')
        return []; // Trả về list rỗng
      }

      final list = snapshot.docs.map((doc) => BannerModel.fromSnapshot(doc)).toList(); // Chuyển đổi tất cả documents thành BannerModel và tạo list

      return list; // Trả về list banners

    } catch (e) { // Bắt lỗi nếu có
      // Show error message if fetching categories fails
      Get.snackbar('Error', 'Error fetching categories: $e'); // Hiển thị snackbar thông báo lỗi (comment có thể sai, nên là 'Error fetching banners')
      return []; // Trả về list rỗng khi có lỗi
    }
  }
}
