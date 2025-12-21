import 'package:flutter/material.dart'; // Import Flutter Material - cung cấp các widget cơ bản
import 'package:iconsax/iconsax.dart'; // Import icon pack Iconsax

import '../../../../../utils/constants/colors.dart'; // Import màu sắc chuẩn
import '../../../../../utils/constants/sizes.dart'; // Import kích thước chuẩn
import '../../../../../utils/device/device_utility.dart'; // Import utility để lấy kích thước thiết bị
import '../../../../../utils/helpers/helper_functions.dart'; // Import các hàm helper
import '../../../controllers.onboarding/onboarding_controller.dart'; // Import controller xử lý logic onboarding
class OnBoardingNextButton extends StatelessWidget { // Widget nút "Tiếp theo" - StatelessWidget
  const OnBoardingNextButton({ // Constructor
    super.key, // Key từ parent widget
  });

  @override
  Widget build(BuildContext context) { // Hàm build - xây dựng UI

    final dark = THelperFunctions.isDarkMode(context); // Kiểm tra chế độ dark mode

    return Positioned( // Positioned - định vị widget ở vị trí cụ thể trong Stack
      right: TSizes.defaultSpace, // Cách lề phải một khoảng cách chuẩn
      bottom: TDeviceUtils.getBottomNavigationBarHeight(), // Cách đáy màn hình một khoảng bằng chiều cao bottom navigation bar
      child: ElevatedButton( // Nút nổi (có màu nền và đổ bóng)
        onPressed: () => OnBoardingController.instance.nextPage(), // Khi click, gọi hàm nextPage() từ controller để chuyển sang trang tiếp theo
        style: ElevatedButton.styleFrom( // Định nghĩa style cho nút
            shape: const CircleBorder(), // Hình dạng tròn
            backgroundColor: dark ? TColors.primary : Colors.blue), // Màu nền: nếu dark mode thì dùng màu primary, ngược lại dùng màu xanh
        child: const Icon(Iconsax.arrow_right_3), // Icon mũi tên sang phải
      ),
    );
  }
}
