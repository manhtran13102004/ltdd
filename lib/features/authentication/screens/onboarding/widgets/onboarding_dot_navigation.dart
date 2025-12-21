import 'package:flutter/material.dart'; // Import Flutter Material - cung cấp các widget cơ bản
import 'package:project/features/authentication/screens/onboarding/widgets/onboarding_page.dart'; // Import widget onboarding page (có thể không dùng trực tiếp)
import 'package:project/features/authentication/screens/onboarding/widgets/onboarding_skip.dart'; // Import widget skip (có thể không dùng trực tiếp)
import 'package:project/utils/constants/colors.dart'; // Import màu sắc chuẩn
import 'package:project/utils/constants/image_strings.dart'; // Import đường dẫn hình ảnh chuẩn (có thể không dùng trực tiếp)
import 'package:project/utils/device/device_utility.dart'; // Import utility để lấy kích thước thiết bị
import 'package:project/utils/helpers/helper_functions.dart'; // Import các hàm helper
import 'package:smooth_page_indicator/smooth_page_indicator.dart'; // Import thư viện hiển thị page indicator mượt mà

import '../../../../../utils/constants/sizes.dart'; // Import kích thước chuẩn (có thể không dùng trực tiếp)
import '../../../controllers.onboarding/onboarding_controller.dart'; // Import controller xử lý logic onboarding


class OnBoardingDotNavigation extends StatelessWidget { // Widget hiển thị dots navigation - StatelessWidget
  const OnBoardingDotNavigation({ // Constructor
    super.key, // Key từ parent widget
  });

  @override
  Widget build(BuildContext context) { // Hàm build - xây dựng UI
    final controller = OnBoardingController.instance; // Lấy instance của OnBoardingController (singleton)
    final dark = THelperFunctions.isDarkMode(context); // Kiểm tra chế độ dark mode

    return Positioned( // Positioned - định vị widget ở vị trí cụ thể trong Stack
      bottom: TDeviceUtils.getBottomNavigationBarHeight() + 20, // Cách đáy màn hình một khoảng bằng chiều cao bottom navigation bar + 20 pixels
      left: 0,  // Cách lề trái 0 (không cần thiết vì đã dùng Align để căn giữa)
      right: 0, // Cách lề phải 0 (để widget trải dài toàn bộ chiều rộng, giúp căn giữa theo chiều ngang)
      child: Align( // Align - căn chỉnh widget con
        alignment: Alignment.center, // Căn giữa SmoothPageIndicator theo chiều ngang
        child: SmoothPageIndicator( // Widget hiển thị các chấm tròn để chỉ trang hiện tại
          controller: controller.pageController, // Gán PageController để theo dõi trang hiện tại
          count: 3, // Số lượng trang onboarding (3 trang)
          onDotClicked: controller.doNavigationClick, // Callback khi click vào một chấm - chuyển đến trang tương ứng
          effect: ExpandingDotsEffect( // Hiệu ứng mở rộng cho chấm đang active
            activeDotColor: dark ? TColors.light : TColors.dark, // Màu chấm active: nếu dark mode thì dùng màu sáng, ngược lại dùng màu tối
            dotHeight: 6, // Chiều cao của mỗi chấm (6 pixels)
          ),
        ),
      ),
    );
  }
}
