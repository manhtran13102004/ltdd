import 'package:flutter/material.dart';
// Import Flutter Material library
// Chứa tất cả widget cơ bản như Scaffold, Text, Container...
import 'package:get/get_navigation/src/root/get_material_app.dart';
// Import GetMaterialApp từ GetX
// Dùng để quản lý navigation, dependency injection, state management
import 'package:project/features/authentication/screens/signup/verify_email.dart';
// Import màn hình verify_email (sử dụng nếu cần navigate tới màn hình này)
import 'package:project/utils/theme/theme.dart';
// Import file theme.dart
// Chứa định nghĩa theme sáng (lightTheme) và tối (darkTheme)

import 'features/authentication/screens/onboarding/onboarding.dart';
// Import màn hình OnBoardingScreen
// Đây sẽ là màn hình đầu tiên khi app mở


class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // Dùng GetMaterialApp thay cho MaterialApp
      // Vì GetX quản lý navigation, snackbars, dialogs, dependency injection
      debugShowCheckedModeBanner: false,
      // Ẩn banner "DEBUG" góc phải màn hình khi chạy debug
      themeMode: ThemeMode.system,
      // Sử dụng chế độ theme theo hệ thống (Android/iOS)
      theme: TAppTheme.lightTheme, // Use the correct reference
      darkTheme: TAppTheme.darkTheme, // You can define your dark theme here
      home: const OnBoardingScreen(),
      // Màn hình đầu tiên khi app chạy
      // Đây là màn hình onboarding (giới thiệu app / tutorial)
      // const vì OnBoardingScreen không phụ thuộc state bên ngoài
    );
  }
}