import 'package:flutter/material.dart'; // Import Flutter Material - cung cấp ElevatedButtonThemeData

class TElevatedButtonTheme { // Class chứa ElevatedButton theme (light và dark)
  TElevatedButtonTheme._(); // Constructor private - ngăn việc tạo instance từ bên ngoài (singleton pattern)

  static final lightElevatedButtonTheme = ElevatedButtonThemeData( // ElevatedButton theme sáng
    style: ElevatedButton.styleFrom( // Định nghĩa style cho ElevatedButton
      elevation: 0, // Độ nổi = 0 (không có đổ bóng)
      foregroundColor: Colors.white, // Màu chữ trắng
      backgroundColor: Colors.blue, // Màu nền xanh dương
      disabledForegroundColor: Colors.grey, // Màu chữ khi button bị vô hiệu hóa: xám
      disabledBackgroundColor: Colors.grey, // Màu nền khi button bị vô hiệu hóa: xám
      side: const BorderSide(color: Colors.blue), // Viền màu xanh dương
      padding: const EdgeInsets.symmetric(vertical: 18), // Padding dọc 18 pixels
      textStyle: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600), // Style cho text: font size 16, màu trắng, font weight 600
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), // Hình dạng: bo góc với bán kính 12 pixels
    ),
  );

// You can add more themes if necessary
  static final darkElevatedButtonTheme = ElevatedButtonThemeData( // ElevatedButton theme tối
    style: ElevatedButton.styleFrom( // Định nghĩa style cho ElevatedButton
      elevation: 0, // Độ nổi = 0 (không có đổ bóng)
      foregroundColor: Colors.white, // Màu chữ trắng
      backgroundColor: Colors.blue, // Màu nền xanh dương
      disabledForegroundColor: Colors.grey, // Màu chữ khi button bị vô hiệu hóa: xám
      disabledBackgroundColor: Colors.grey, // Màu nền khi button bị vô hiệu hóa: xám
      side: const BorderSide(color: Colors.blue), // Viền màu xanh dương
      padding: const EdgeInsets.symmetric(vertical: 18), // Padding dọc 18 pixels
      textStyle: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600), // Style cho text: font size 16, màu trắng, font weight 600
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), // Hình dạng: bo góc với bán kính 12 pixels
    ),
  );
}
