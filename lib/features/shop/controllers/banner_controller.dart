import 'dart:async'; // Import thư viện async - dùng cho Timer
import 'package:get/get.dart'; // Import GetX - dùng cho state management và snackbar
import '../../../data/repositories/banners/banner_repository.dart'; // Import BannerRepository
import '../models/banner_model.dart'; // Import BannerModel

class BannerController extends GetxController { // Controller xử lý logic banner - kế thừa GetxController
  static BannerController get instance => Get.find(); // Getter để lấy instance của BannerController từ GetX dependency injection
  final isLoading = false.obs; // Observable để quản lý trạng thái loading
  final _bannerRepository = Get.put(BannerRepository()); // Khởi tạo và đăng ký BannerRepository vào GetX dependency injection

  final carousalCurrentIndex = 0.obs; // Observable để lưu chỉ số banner hiện tại trong carousel (mặc định = 0)
  RxList<BannerModel> allBanners = <BannerModel>[].obs; // Observable list chứa tất cả banners
  RxList<BannerModel> featuredBanners = <BannerModel>[].obs; // Observable list chứa các banners nổi bật (active)

  Timer? _carouselTimer; // Timer để tự động chuyển banner trong carousel

  @override
  void onInit() { // Hàm được gọi khi controller được khởi tạo
    super.onInit(); // Gọi hàm onInit của class cha
    fetchBanners(); // Gọi hàm fetchBanners để tải danh sách banners
    startAutoCarousel(); // Bắt đầu tự động chuyển banner
  }

  @override
  void onClose() { // Hàm được gọi khi controller bị hủy
    _carouselTimer?.cancel(); // Hủy timer nếu đang chạy (để tránh memory leak)
    super.onClose(); // Gọi hàm onClose của class cha
  }

  void updatePageIndicator(int index) { // Hàm cập nhật chỉ số banner hiện tại
    carousalCurrentIndex.value = index; // Cập nhật giá trị carousalCurrentIndex
  }

  Future<void> fetchBanners() async { // Hàm lấy danh sách banners từ repository
    try { // Bắt đầu khối try-catch để xử lý lỗi
      isLoading.value = true; // Đặt trạng thái loading = true
      final banners = await _bannerRepository.getAllBanners(); // Lấy tất cả banners từ repository
      allBanners.assignAll(banners); // Gán tất cả banners vào allBanners
      featuredBanners.assignAll( // Lọc và lấy các banners nổi bật
        allBanners.where((banner) => banner.active).take(3).toList(), // Lọc các banners có active = true và lấy tối đa 3 banners
      );
    } catch (e) { // Bắt lỗi nếu có
      Get.snackbar('Error', 'Error fetching categories: $e'); // Hiển thị snackbar thông báo lỗi (comment có thể sai, nên là 'Error fetching banners')
    } finally { // Khối finally luôn được thực thi
      isLoading.value = false; // Đặt trạng thái loading = false (dù thành công hay thất bại)
    }
  }

  void startAutoCarousel() { // Hàm bắt đầu tự động chuyển banner trong carousel
    // Tạo một timer để tự động thay đổi `carousalCurrentIndex` sau mỗi 3 giây
    _carouselTimer = Timer.periodic(const Duration(seconds: 6), (timer) { // Tạo timer chạy định kỳ mỗi 6 giây
      if (featuredBanners.isNotEmpty) { // Nếu có banners nổi bật
        carousalCurrentIndex.value = // Cập nhật chỉ số banner hiện tại
            (carousalCurrentIndex.value + 1) % featuredBanners.length; // Tăng chỉ số lên 1 và lấy phần dư khi chia cho số lượng banners (tạo hiệu ứng vòng lặp)
      }
    });
  }
}
