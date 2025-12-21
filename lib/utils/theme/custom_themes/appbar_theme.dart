import 'package:flutter/material.dart'; // Import Flutter Material - cung cấp AppBarTheme

class TAppBarTheme{ // Class chứa AppBar theme (light và dark)
  TAppBarTheme._(); // Constructor private - ngăn việc tạo instance từ bên ngoài (singleton pattern)

  static const lightAppBarTheme =  AppBarTheme( // AppBar theme sáng

      elevation: 0, // Độ nổi = 0 (không có đổ bóng)
      centerTitle: false, // Không căn giữa tiêu đề
      scrolledUnderElevation: 0, // Độ nổi khi scroll = 0
      backgroundColor: Colors.transparent, // Màu nền trong suốt
      surfaceTintColor: Colors.transparent, // Màu tint trong suốt (Material 3)
      iconTheme: IconThemeData(color: Colors.black, size: 24), // Theme cho icon: màu đen, kích thước 24
      actionsIconTheme: IconThemeData(color: Colors.black,size: 24), // Theme cho action icons: màu đen, kích thước 24
      titleTextStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.black), // Style cho text tiêu đề: font size 18, font weight 600, màu đen


  );

// You can add more themes if necessary
  static const darkAppBarTheme = AppBarTheme( // AppBar theme tối
  elevation: 0, // Độ nổi = 0 (không có đổ bóng)
  centerTitle: false, // Không căn giữa tiêu đề
  scrolledUnderElevation: 0, // Độ nổi khi scroll = 0
  backgroundColor: Colors.transparent, // Màu nền trong suốt
  surfaceTintColor: Colors.transparent, // Màu tint trong suốt (Material 3)
  iconTheme: IconThemeData(color: Colors.black, size: 24), // Theme cho icon: màu đen, kích thước 24 (có thể nên là màu trắng cho dark theme)
  actionsIconTheme: IconThemeData(color: Colors.white,size: 24), // Theme cho action icons: màu trắng, kích thước 24
  titleTextStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.white), // Style cho text tiêu đề: font size 18, font weight 600, màu trắng

  );
}
