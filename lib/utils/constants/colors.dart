import 'package:flutter/material.dart'; // Import Flutter Material - cung cấp Color class

class TColors { // Class chứa các màu sắc chuẩn của app
  // App theme colors
  static const Color // Khai báo màu primary - màu chủ đạo của app
  primary = Color(0xFF2D7432); // Xanh lá cây tươi (màu hex #2D7432)
  static const Color secondary = Color(0xFFFFE24B); // Màu secondary - màu vàng (#FFE24B)
  static const Color accent = Color(0xFFb0c7ff); // Màu accent - màu xanh nhạt (#b0c7ff)

  // Icon colors
  static const Color iconPrimary = Color(0xFF8D8D8D); // Màu icon chính - xám (#8D8D8D)

  // Text colors
  static const Color textPrimary = Color(0xFF272727); // Màu text chính - đen nhạt (#272727)
  static const Color textSecondary = Color(0xFF656565); // Màu text phụ - xám đậm (#656565)
  static const Color textWhite = Colors.white; // Màu text trắng - dùng cho text trên nền tối

  // Background colors
  static const Color light = Color(0xFFF6F6F6); // Màu nền sáng - xám rất nhạt (#F6F6F6)
  static const Color dark = Color(0xFF272727); // Màu nền tối - đen nhạt (#272727)
  static const Color primaryBackground = Color(0xFFF5F5F5); // Màu nền chính - xám rất nhạt (#F5F5F5)

  // Background Container colors
  static const Color lightContainer = Color(0xFFF6F6F6); // Màu container sáng - xám rất nhạt (#F6F6F6)
  static Color darkContainer = TColors.white.withOpacity(0.1); // Màu container tối - trắng với độ mờ 10%

  // Button colors
  static const Color buttonPrimary = Color(0xFF4b68ff); // Màu nút chính - xanh dương (#4b68ff)
  static const Color buttonSecondary = Color(0xFF6C757D); // Màu nút phụ - xám (#6C757D)
  static const Color buttonDisabled = Color(0xFFC4C4C4); // Màu nút bị vô hiệu hóa - xám nhạt (#C4C4C4)

  // Border colors
  static const Color borderPrimary = Color(0xFFD9D9D9); // Màu viền chính - xám nhạt (#D9D9D9)
  static const Color borderSecondary = Color(0xFF313131); // Màu viền phụ - đen nhạt (#313131)

  // Error and validation colors
  static const Color error = Color(0xFFD32F2F); // Màu lỗi - đỏ (#D32F2F)
  static const Color success = Color(0xFF388E3C); // Màu thành công - xanh lá (#388E3C)
  static const Color warning = Color(0xFFF57C00); // Màu cảnh báo - cam (#F57C00)
  static const Color info = Color(0xFF1976D2); // Màu thông tin - xanh dương (#1976D2)

  // Neutral Shades
  static const Color black = Color(0xFF232323); // Màu đen - đen nhạt (#232323)
  static const Color darkerGrey = Color(0xFF4F4F4F); // Xám đậm hơn - xám đậm (#4F4F4F)
  static const Color darkGrey = Color(0xFF939393); // Xám đậm - xám vừa (#939393)
  static const Color grey = Color(0xFFD9D9D9); // Xám - xám nhạt (#D9D9D9)
  static const Color softGrey = Color(0xFFF4F4F4); // Xám mềm - xám rất nhạt (#F4F4F4)
  static const Color lightGrey = Color(0xFFF9F9F9); // Xám nhạt - xám cực nhạt (#F9F9F9)
  static const Color white = Color(0xFFFFFFFF); // Màu trắng - trắng tinh (#FFFFFF)

}



