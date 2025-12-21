import 'package:flutter/material.dart'; // Import Flutter Material - cung cấp các widget cơ bản

import '../../../../../utils/constants/sizes.dart'; // Import kích thước chuẩn
import '../../../../../utils/device/device_utility.dart'; // Import utility để lấy kích thước thiết bị
import '../../../../../utils/helpers/helper_functions.dart'; // Import các hàm helper (có thể không dùng trực tiếp)
import '../../../controllers.onboarding/onboarding_controller.dart'; // Import controller xử lý logic onboarding
class OnBoardingSkip extends StatelessWidget { // Widget nút "Bỏ qua" - StatelessWidget
  const OnBoardingSkip({ // Constructor
    super.key, // Key từ parent widget
  });

  @override
  Widget build(BuildContext context) { // Hàm build - xây dựng UI
    return Positioned( // Positioned - định vị widget ở vị trí cụ thể trong Stack
      top: TDeviceUtils.getAppBarHeight(), // Cách đỉnh màn hình một khoảng bằng chiều cao AppBar
      right:TSizes.defaultSpace, // Cách lề phải một khoảng cách chuẩn
      child: TextButton( // TextButton - nút chỉ có text, không có nền
          onPressed: () => OnBoardingController.instance.skipPage(), // Khi click, gọi hàm skipPage() từ controller để bỏ qua onboarding và chuyển đến màn hình đăng nhập
          child: const Text('Skip'), // Text hiển thị "Skip"
      ),
    );
  }
}
