import 'package:flutter/material.dart'; // Import Flutter Material - cung cấp ChipThemeData

class TChipTheme { // Class chứa Chip theme (light và dark)
  TChipTheme._(); // Constructor private - ngăn việc tạo instance từ bên ngoài (singleton pattern)

  static ChipThemeData lightChipTheme = ChipThemeData( // Chip theme sáng
    disabledColor: Colors.grey.withOpacity(0.4), // Màu khi chip bị vô hiệu hóa: xám với độ mờ 40%
    labelStyle: const TextStyle(color: Colors.black), // Style cho label: màu chữ đen
    selectedColor: Colors.blue, // Màu khi chip được chọn: xanh dương
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12), // Padding: ngang 12 pixels, dọc 12 pixels
    checkmarkColor: Colors.white, // Màu dấu check: trắng
  );

  static ChipThemeData darkChipTheme = ChipThemeData( // Chip theme tối
    disabledColor: Colors.grey.withOpacity(0.4), // Màu khi chip bị vô hiệu hóa: xám với độ mờ 40%
    labelStyle: const TextStyle(color: Colors.white), // Style cho label: màu chữ trắng
    selectedColor: Colors.blue, // Màu khi chip được chọn: xanh dương
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12), // Padding: ngang 12 pixels, dọc 12 pixels
    checkmarkColor: Colors.white, // Màu dấu check: trắng
  );

}
