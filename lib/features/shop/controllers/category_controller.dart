import 'dart:io'; // Import thư viện io - dùng cho File và Directory
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Cloud Firestore - dùng cho CollectionReference
import 'package:firebase_database/firebase_database.dart'; // Import Firebase Database (có thể không dùng trực tiếp)
import 'package:image_picker/image_picker.dart'; // Import ImagePicker - dùng để chọn ảnh từ gallery
import 'package:path_provider/path_provider.dart'; // Import PathProvider - dùng để lấy đường dẫn thư mục
import 'package:get/get.dart'; // Import GetX - dùng cho state management và snackbar
import 'package:project/features/shop/models/category_model.dart'; // Import CategoryModel
import 'package:supabase_flutter/supabase_flutter.dart'; // Import Supabase - dùng để upload ảnh

import '../../../data/repositories/categories/category_repository.dart'; // Import CategoryRepository

class CategoryController extends GetxController { // Controller xử lý logic danh mục - kế thừa GetxController
  static CategoryController get instance => Get.find(); // Getter để lấy instance của CategoryController từ GetX dependency injection
  final _categoryRepository = Get.put(CategoryRepository()); // Khởi tạo và đăng ký CategoryRepository vào GetX dependency injection
  final isLoading = false.obs; // Observable để quản lý trạng thái loading

  RxList<CategoryModel> allCategories = <CategoryModel>[].obs; // Observable list chứa tất cả danh mục
  RxList<CategoryModel> featuredCategories = <CategoryModel>[].obs; // Observable list chứa các danh mục nổi bật

  final picker = ImagePicker(); // Khởi tạo ImagePicker để chọn ảnh

  @override
  void onInit() { // Hàm được gọi khi controller được khởi tạo
    super.onInit(); // Gọi hàm onInit của class cha
    fetchCategories(); // Gọi hàm fetchCategories để tải danh sách danh mục
  }

  Future<void> fetchCategories() async { // Hàm lấy danh sách danh mục từ repository
    try { // Bắt đầu khối try-catch để xử lý lỗi
      isLoading.value = true; // Đặt trạng thái loading = true
      final categories = await _categoryRepository.getAllCategories(); // Lấy tất cả danh mục từ repository
      allCategories.assignAll(categories); // Gán tất cả danh mục vào allCategories
      featuredCategories.assignAll(allCategories // Lọc và lấy các danh mục nổi bật
          .where((category) => category.isFeatured && category.parentId.isEmpty) // Lọc các danh mục có isFeatured = true và không có parentId
          .take(8) // Lấy tối đa 8 danh mục
          .toList()); // Chuyển thành list
    } catch (e) { // Bắt lỗi nếu có
      Get.snackbar('Error', 'Error fetching categories: $e'); // Hiển thị snackbar thông báo lỗi
    } finally { // Khối finally luôn được thực thi
      isLoading.value = false; // Đặt trạng thái loading = false (dù thành công hay thất bại)
    }
  }

  Future<String?> saveImageLocally() async { // Hàm lưu ảnh vào bộ nhớ local
    // Chọn ảnh từ bộ sưu tập
    final pickedFile = await picker.pickImage(source: ImageSource.gallery); // Chọn ảnh từ gallery

    if (pickedFile != null) { // Nếu có ảnh được chọn
      // Đường dẫn đến thư mục lưu trữ nội bộ của ứng dụng
      final directory = await getApplicationDocumentsDirectory(); // Lấy thư mục documents của app

      // Tạo cấu trúc thư mục tương tự 'assets/icons/categories'
      String customPath = '${directory.path}/assets/icons/categories'; // Tạo đường dẫn tùy chỉnh
      final customDir = Directory(customPath); // Tạo đối tượng Directory

      // Tạo thư mục nếu chưa tồn tại
      if (!await customDir.exists()) { // Kiểm tra thư mục có tồn tại không
        await customDir.create(recursive: true); // Tạo thư mục (recursive = true để tạo cả thư mục cha nếu chưa có)
      }

      // Đặt tên tệp ảnh
      String fileName = 'category_${DateTime.now().millisecondsSinceEpoch}.jpg'; // Tạo tên file duy nhất dựa trên timestamp
      String filePath = '${customDir.path}/$fileName'; // Tạo đường dẫn đầy đủ của file

      // Sao chép ảnh vào đường dẫn mong muốn
      await File(pickedFile.path).copy(filePath); // Copy ảnh từ đường dẫn tạm sang đường dẫn mong muốn
      return filePath;  // Trả về đường dẫn ảnh đã lưu
    }
    return null;  // Trả về null nếu không có ảnh được chọn
  }

  Future<void> uploadPicture() async { // Hàm upload ảnh lên Supabase và lưu thông tin vào Firestore
    try { // Bắt đầu khối try-catch để xử lý lỗi
      // Lấy đường dẫn ảnh từ bộ nhớ
      String? imagePath = await saveImageLocally(); // Gọi hàm saveImageLocally để lưu ảnh và lấy đường dẫn

      if (imagePath != null) { // Nếu có đường dẫn ảnh
        // Tải ảnh lên Supabase Storage
        final File imageFile = File(imagePath); // Tạo đối tượng File từ đường dẫn

        // Tạo tên file duy nhất cho ảnh
        final fileName = 'category_images/${DateTime.now().millisecondsSinceEpoch}.jpg'; // Tạo tên file duy nhất với timestamp

        // Upload ảnh lên Supabase Storage
        final response = await Supabase.instance.client.storage // Lấy storage client từ Supabase
            .from('category_images') // Chọn bucket 'category_images'
            .upload(fileName, imageFile); // Upload file lên Supabase

        // Lấy URL công khai của ảnh vừa tải lên
        String imageUrl = Supabase.instance.client.storage // Lấy storage client từ Supabase
            .from('category_images') // Chọn bucket 'category_images'
            .getPublicUrl(fileName); // Lấy public URL của file vừa upload

        // Tạo một đối tượng CategoryModel với thông tin ảnh đã chọn
        CategoryModel newCategory = CategoryModel( // Tạo CategoryModel mới
          id: '5',  // ID có thể tự động tạo nếu cần
          name: 'Category 5', // Tên danh mục
          image: imageUrl,  // Sử dụng URL ảnh từ Supabase
          parentId: '1', // ID danh mục cha
          isFeatured: true, // Đánh dấu là danh mục nổi bật
        );

        // Lưu dữ liệu vào Firestore hoặc Supabase (nếu cần)
        // Giả sử bạn đang sử dụng Firestore, bạn có thể lưu thông tin này vào Firestore:
        CollectionReference categoriesRef = FirebaseFirestore.instance.collection('Categories'); // Lấy reference đến collection 'Categories'
        await categoriesRef.doc(newCategory.id).set(newCategory.toJson()); // Lưu category vào Firestore với id = newCategory.id

        print('Ảnh đã được lưu vào Firestore!'); // In thông báo thành công ra console
      } else { // Nếu không có ảnh được chọn
        print('Không có ảnh được chọn.'); // In thông báo ra console
      }
    } catch (e) { // Bắt lỗi nếu có
      print('Lỗi khi upload ảnh: $e'); // In thông báo lỗi ra console
    }
  }
}
