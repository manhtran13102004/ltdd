import 'package:flutter/material.dart'; // Import Flutter Material - cung cấp OutlinedButtonThemeData

class TOutlinedButtonTheme { // Class chứa OutlinedButton theme (light và dark)
  TOutlinedButtonTheme._(); // Constructor private - ngăn việc tạo instance từ bên ngoài (singleton pattern)

  static final OutlinedButtonThemeData lightTOutlinedButtonTheme = OutlinedButtonThemeData( // OutlinedButton theme sáng
    style: OutlinedButton.styleFrom( // Định nghĩa style cho OutlinedButton
      elevation: 0, // Độ nổi = 0 (không có đổ bóng)
      foregroundColor: Colors.black, // Màu chữ đen
      side: const BorderSide(color: Colors.blue), // Viền màu xanh dương
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600), // Style cho text: font size 16, font weight 600
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20), // Padding: dọc 16 pixels, ngang 20 pixels
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)), // Hình dạng: bo góc với bán kính 14 pixels
    ),
  );

  static final OutlinedButtonThemeData darkTOutlinedButtonTheme = OutlinedButtonThemeData( // OutlinedButton theme tối
    style: OutlinedButton.styleFrom( // Định nghĩa style cho OutlinedButton
      elevation: 0, // Độ nổi = 0 (không có đổ bóng)
      foregroundColor: Colors.white, // Màu chữ trắng
      side: const BorderSide(color: Colors.blue), // Viền màu xanh dương
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600), // Style cho text: font size 16, font weight 600
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20), // Padding: dọc 16 pixels, ngang 20 pixels
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)), // Hình dạng: bo góc với bán kính 14 pixels
    ),
  );
}
