import 'package:get_storage/get_storage.dart'; // Import GetStorage - thư viện lưu trữ dữ liệu local đơn giản

class TLocalStorage { // Class quản lý local storage - Singleton pattern
  static final TLocalStorage _instance = TLocalStorage._internal(); // Instance tĩnh duy nhất của class (Singleton)

  factory TLocalStorage() { // Factory constructor - trả về instance duy nhất
    return _instance; // Trả về instance đã được tạo
  }

  TLocalStorage._internal(); // Constructor private - ngăn việc tạo instance từ bên ngoài
 final _storage = GetStorage(); // Khởi tạo GetStorage instance
  // Lưu trữ một giá trị chuỗi
  Future<void> saveData <T>(String key, T value) async { // Hàm generic để lưu dữ liệu với kiểu T bất kỳ
    await _storage.write(key, value); // Ghi dữ liệu vào storage với key và value được chỉ định
  }

  T? readData<T>(String key){ // Hàm generic để đọc dữ liệu với kiểu T bất kỳ
    return _storage.read<T>(key); // Đọc dữ liệu từ storage với key được chỉ định và trả về kiểu T (có thể null)
  }


  // Xóa giá trị
  Future<void> remove(String key) async { // Hàm xóa một giá trị theo key

    await _storage.remove(key); // Xóa dữ liệu trong storage với key được chỉ định
  }

  Future<void> clearAll()async { // Hàm xóa tất cả dữ liệu trong storage

    await _storage.erase(); // Xóa toàn bộ dữ liệu trong storage
  }

}
