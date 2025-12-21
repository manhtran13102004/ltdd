import 'package:flutter/material.dart'; // Import Flutter Material - cung cấp BottomSheetThemeData

class TBottomSheetTheme{ // Class chứa BottomSheet theme (light và dark)
  TBottomSheetTheme._(); // Constructor private - ngăn việc tạo instance từ bên ngoài (singleton pattern)

  static BottomSheetThemeData lightBottomSheetTheme =  BottomSheetThemeData( // BottomSheet theme sáng

    showDragHandle: true, // Hiển thị drag handle (thanh kéo) ở trên cùng
    backgroundColor: Colors.white, // Màu nền trắng
    modalBackgroundColor: Colors.white, // Màu nền modal trắng
    constraints: const BoxConstraints(minWidth: double.infinity), // Ràng buộc: chiều rộng tối thiểu = toàn bộ màn hình
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), // Hình dạng: bo góc với bán kính 16 pixels

  );

// You can add more themes if necessary
  static BottomSheetThemeData darkBottomSheetTheme =  BottomSheetThemeData( // BottomSheet theme tối

    showDragHandle: true, // Hiển thị drag handle (thanh kéo) ở trên cùng
    backgroundColor: Colors.black, // Màu nền đen
    modalBackgroundColor: Colors.black, // Màu nền modal đen
    constraints: const BoxConstraints(minWidth: double.infinity), // Ràng buộc: chiều rộng tối thiểu = toàn bộ màn hình
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), // Hình dạng: bo góc với bán kính 16 pixels

  );
}
