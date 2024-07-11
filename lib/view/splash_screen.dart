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
import '../core/models/models/unread_count_model.dart';
import '../core/models/responses/get_unread_notifications_count.dart';
import '../core/services/database_services.dart';
import '../core/services/local_storage_services.dart';
import '../core/services/notification_service.dart';
import '../core/utils/locator.dart';
import 'Auth/Sign In/sign_in_screen.dart';
import 'Home/bottom_navigation_bar.dart';

NotificationCountModel? globalNotificationCountModel;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _localStorageService = locator<LocalStorageService>();
  final _notifications = locator<PushNotificationService>();
  final _dbService = locator<DatabaseServices>();

  @override
  void initState() {
    super.initState();

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

    _notifications.getPermission();
    _notifications.hasTokenRefreshed();
    final String? fcmToken = await _notifications.getToken();
    if (context.mounted) {
      await _notifications.initialize(context);
    }
    final String? savedFcmToken = await _localStorageService.getFcmToken();
    //Checking Whether the fcmToken has changed or not
    if (fcmToken != savedFcmToken) {
      _localStorageService.saveFcmToken(fcmToken: fcmToken!);
    }

    final onboardingPageCount =
        await _localStorageService.getOnboardingPageCount();
    final userPhoneNumber = await _localStorageService.getUserPhoneNumber();
    await fetchNotificationsCount();

    await Future.delayed(const Duration(seconds: 3));

    if (userPhoneNumber != null) {
      Get.offAll(() => CustomBottomNavigationBar(
            pageIndex: 0,
          ));
    } else if (onboardingPageCount != 2) {
      Get.offAll(() => const OnBoardingScreen());
    } else {
      Get.offAll(() => const SignInScreen());
    }
  }

  //////////////////////////Getting New Notification Count from DB//////////////////////////
  late GetNotificationCountResponse _notificationCountResponse;

  Future<void> fetchNotificationsCount() async {
    try {
      _notificationCountResponse =
          await _dbService.getUnreadNotificationsCount();
      if (_notificationCountResponse.success) {
        globalNotificationCountModel =
            _notificationCountResponse.notificationCountModel!;

        debugPrint(
            'the following is the response =============> ${_notificationCountResponse.notificationCountModel}');
      }
    } catch (e) {
      debugPrint(
          'this is the error encountered ==============> ${e.toString()}');
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
