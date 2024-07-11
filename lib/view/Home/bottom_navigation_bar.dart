import 'package:bin_yousuf_driver/core/constants/assets.dart';
import 'package:bin_yousuf_driver/core/constants/colors.dart';
import 'package:bin_yousuf_driver/core/constants/styles.dart';
import 'package:bin_yousuf_driver/view/Home/home_screen.dart';
import 'package:bin_yousuf_driver/view/Notification/notification_screen.dart';
import 'package:bin_yousuf_driver/view/Profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../Notification/notification_controller.dart';
import '../Notification/notifications_view_model.dart';
import '../splash_screen.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  CustomBottomNavigationBar({super.key, required this.pageIndex});
  int pageIndex;

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  final NotificationsController _notificationsController = Get.find();

  List<Widget> screens = [
    const HomeScreen(),
    const NotificationScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        height: 59.h,
        margin: EdgeInsets.symmetric(horizontal: 15.w),
        decoration: BoxDecoration(
          color: mainColor,
          borderRadius: BorderRadius.circular(50.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) => ScaleTransition(
                scale: animation,
                child: child,
              ),
              switchInCurve: Curves.easeIn,
              switchOutCurve: Curves.easeOut,
              child: widget.pageIndex == 0
                  ? Container(
                      width: 102.w,
                      padding: EdgeInsets.symmetric(vertical: 5.h),
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(color: whiteColor),
                          bottom: BorderSide(color: whiteColor),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            homeIcon,
                            width: 24.w,
                            height: 24.h,
                            color: whiteColor,
                          ),
                          SizedBox(width: 3.w),
                          outfitMediumText(
                            text: 'Home',
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: whiteColor,
                          )
                        ],
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        final notificationProvider =
                            Provider.of<NotificationsViewModel>(context,
                                listen: false);
                        if (notificationProvider.hasRead) {
                          notificationProvider.clearUnreadCount();
                        }
                        setState(() {
                          widget.pageIndex = 0;
                        });
                      },
                      child: SizedBox(
                        width: 102.w,
                        child: Image.asset(
                          homeIcon,
                          width: 24.w,
                          height: 24.h,
                          color: whiteColor,
                        ),
                      ),
                    ),
            ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) => ScaleTransition(
                scale: animation,
                child: child,
              ),
              switchInCurve: Curves.easeIn,
              switchOutCurve: Curves.easeOut,
              child: widget.pageIndex == 1
                  ? Container(
                      width: 102.w,
                      padding: EdgeInsets.symmetric(vertical: 5.h),
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(color: whiteColor),
                          bottom: BorderSide(color: whiteColor),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            notificationIcon,
                            width: 25.w,
                            height: 25.h,
                            color: whiteColor,
                          ),
                          SizedBox(width: 3.w),
                          outfitMediumText(
                            text: 'Notifications',
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: whiteColor,
                          )
                        ],
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        _notificationsController.resetUnreadCount();
                        setState(() {
                          widget.pageIndex = 1;
                        });
                      },
                      child: SizedBox(
                        width: 102.w,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.asset(
                              notificationIcon,
                              width: 25.w,
                              height: 25.h,
                              color: whiteColor,
                            ),
                            Positioned(
                              right: 43.w,
                              top: 0.h,
                              child: Obx(
                                () => Visibility(
                                  visible:
                                      (_notificationsController.unreadCount >
                                              0 ||
                                          globalNotificationCountModel!
                                                  .unreadCount! >
                                              0),
                                  child: Container(
                                    width: 6.w,
                                    height: 6.w,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: redColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
            ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) => ScaleTransition(
                scale: animation,
                child: child,
              ),
              switchInCurve: Curves.easeIn,
              switchOutCurve: Curves.easeOut,
              child: widget.pageIndex == 2
                  ? Container(
                      width: 102.w,
                      padding: EdgeInsets.symmetric(vertical: 5.h),
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(color: whiteColor),
                          bottom: BorderSide(color: whiteColor),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            profileIcon,
                            width: 24.w,
                            height: 24.h,
                            color: whiteColor,
                          ),
                          SizedBox(width: 3.w),
                          outfitMediumText(
                            text: 'Profile',
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: whiteColor,
                          )
                        ],
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        final notificationProvider =
                            Provider.of<NotificationsViewModel>(context,
                                listen: false);
                        if (notificationProvider.hasRead) {
                          notificationProvider.clearUnreadCount();
                        }

                        setState(() {
                          widget.pageIndex = 2;
                        });
                      },
                      child: SizedBox(
                        width: 102.w,
                        child: Image.asset(
                          profileIcon,
                          width: 24.w,
                          height: 24.h,
                          color: whiteColor,
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        transitionBuilder: (child, animation) => ScaleTransition(
          scale: animation,
          child: child,
        ),
        switchInCurve: Curves.easeIn,
        // switchOutCurve: Curves.bounceOut,
        child: screens[widget.pageIndex],
      ),
    );
  }
}
