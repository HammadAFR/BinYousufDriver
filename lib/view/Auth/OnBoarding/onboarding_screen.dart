import 'package:bin_yousuf_driver/core/constants/colors.dart';
import 'package:bin_yousuf_driver/core/constants/styles.dart';
import 'package:bin_yousuf_driver/core/constants/helper%20widgets/custom_button.dart';
import 'package:bin_yousuf_driver/view/Auth/OnBoarding/widgets/onboarding_widget_1.dart';
import 'package:bin_yousuf_driver/view/Auth/OnBoarding/widgets/onboarding_widget_2.dart';
import 'package:bin_yousuf_driver/view/Auth/OnBoarding/widgets/onboarding_widget_3.dart';
import 'package:bin_yousuf_driver/view/Auth/Sign%20In/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/services/local_storage_services.dart';
import '../../../core/utils/locator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController = PageController();
  int _currentPageIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _changePage(int pageIndex) {
    _pageController.animateToPage(
      pageIndex,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeIn,
    );
  }

  double getDotWidth(int dotIndex) {
    return _currentPageIndex == dotIndex ? 33.w : 13.w;
  }

  Color getDotColor(int dotIndex) {
    return _currentPageIndex == dotIndex ? mainColor : lightGreyColor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              scrollDirection: Axis.horizontal,
              onPageChanged: (value) {
                setState(() {
                  _currentPageIndex = value;
                });
              },
              children: const [
                OnBoardingWidget1(),
                OnBoardingWidget2(),
                OnBoardingWidget3()
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  _changePage(0);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: getDotWidth(0),
                  height: 13.h,
                  margin: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7.5.sp),
                    color: getDotColor(0),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  _changePage(1);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: getDotWidth(1),
                  height: 13.h,
                  margin: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7.5.sp),
                    color: getDotColor(1),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  _changePage(2);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: getDotWidth(2),
                  height: 13.h,
                  margin: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7.5.sp),
                    color: getDotColor(2),
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 45.h),
          GestureDetector(
            onTap: () {
              if (_currentPageIndex == 2) {
                locator<LocalStorageService>().saveOnboardingPageCount(2);
                Get.to(const SignInScreen());
              } else {
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeIn,
                );
              }
            },
            child: const CustomButton(text: 'Agay Barhein'),
          ),
          SizedBox(height: 45.h),
          GestureDetector(
            onTap: () {
              locator<LocalStorageService>().saveOnboardingPageCount(2);
              Get.to(const SignInScreen());
            },
            child: outfitNormalText(
                text: 'Skip', fontSize: 18.sp, color: Colors.grey[600]),
          ),
          SizedBox(height: 40.h),
        ],
      ),
    );
  }
}
