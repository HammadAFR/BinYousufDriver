import 'dart:async';

import 'package:bin_yousuf_driver/core/constants/assets.dart';
import 'package:bin_yousuf_driver/core/constants/colors.dart';
import 'package:bin_yousuf_driver/core/constants/styles.dart';
import 'package:bin_yousuf_driver/view/Auth/OnBoarding/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../core/constants/helper widgets/internet_connectivity_dialog.dart';
import '../core/services/local_storage_services.dart';
import '../core/utils/locator.dart';
import 'Auth/Sign In/sign_in_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _localStorageService = locator<LocalStorageService>();
  @override
  void initState() {
    super.initState();
    // Timer(const Duration(seconds: 2), () {
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(builder: (context) => const OnBoardingScreen()),
    //   );
    // });
    _doSetup();
  }

  void _doSetup() async {
    /// If not connected to internet, show an alert dialog
    /// to activate the network connection.
    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      debugPrint('has connection');
    } else {
      Get.dialog(const InternetConnectivityDialog());
      return;
    }

    final onboardingPageCount =
        await _localStorageService.getOnboardingPageCount();

    await Future.delayed(const Duration(seconds: 3));

    if (onboardingPageCount != 2) {
      Get.offAll(() => const OnBoardingScreen());
    } else {
      Get.offAll(() => const SignInScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              appLogo,
              width: 121.w,
              height: 121.h,
            ),
            SizedBox(height: 19.h),
            outfitMediumText(
              text: 'Bin Yousaf - Rice Market',
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: goldenColor,
            )
          ],
        ),
      ),
    );
  }
}
