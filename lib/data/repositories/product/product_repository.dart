import 'package:cloud_firestore/cloud_firestore.dart'; // Import Cloud Firestore - database của Firebase
import 'package:get/get.dart'; // Import GetX - dùng cho snackbar và state management
import '../../../features/shop/models/category_model.dart'; // Import CategoryModel (có thể không dùng trực tiếp)
import '../../../features/shop/models/product_model.dart'; // Import ProductModel


class ProductRepository extends GetxController { // Repository xử lý CRUD sản phẩm - kế thừa GetxController
  static ProductRepository get instance => Get.find(); // Getter để lấy instance của ProductRepository từ GetX dependency injection

  final FirebaseFirestore _firestore = FirebaseFirestore.instance; // Lấy instance của Firestore database

  final String _collectionPath = 'Products'; // Đường dẫn collection trong Firestore

  // Static getter to access the instance of the CategoryController

  // Method to fetch all categories from Firestore
  Future<List<ProductModel>> getFeaturedProducts() async { // Hàm lấy tất cả sản phẩm từ Firestore (tên hàm có thể sai, nên là getAllProducts hoặc getFeaturedProducts)
    try { // Bắt đầu khối try-catch để xử lý lỗi
      // Fetching data from Firestore
      final snapshot = await _firestore.collection(_collectionPath).get(); // Lấy tất cả documents từ collection 'Products'

      if (snapshot.docs.isEmpty) { // Nếu không có documents
        // Handle case where there are no documents
        Get.snackbar('No Data', 'No categories found'); // Hiển thị snackbar thông báo (comment có thể sai, nên là 'No products found')
        return []; // Trả về list rỗng
      }

      final list = snapshot.docs.map((doc) => ProductModel.fromSnapshot(doc)).toList(); // Chuyển đổi tất cả documents thành ProductModel và tạo list
       print(list); // In list ra console để debug
      for (var product in list) { // Lặp qua từng sản phẩm
        print('sanpahm: ${product.productAttributes}'); // In productAttributes ra console để debug (có typo: sanpahm thay vì sanpham)
      }


      return list; // Trả về list sản phẩm

    } catch (e) { // Bắt lỗi nếu có
      // Show error message if fetching categories fails
      Get.snackbar('Error', 'Error fetching categories: $e'); // Hiển thị snackbar thông báo lỗi (comment có thể sai, nên là 'Error fetching products')
      return []; // Trả về list rỗng khi có lỗi
    }
  }
  Future<List<ProductModel>> getAllProducts() async {
    try {
      // Lấy tất cả sản phẩm từ collection 'Products' trong Firestore
      final snapshot = await FirebaseFirestore.instance.collection('Products').get();

      // Chuyển dữ liệu từ Firestore thành list ProductModel
      final products = snapshot.docs.map((doc) => ProductModel.fromSnapshot(doc)).toList();

      return products;
    } catch (e) {
      // Nếu lỗi thì báo ra console và trả list rỗng
      print('Lỗi khi lấy tất cả sản phẩm: $e');
      return [];
    }
  }
}
