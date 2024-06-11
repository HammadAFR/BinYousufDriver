import 'package:bin_yousuf_driver/core/constants/assets.dart';
import 'package:bin_yousuf_driver/core/constants/colors.dart';
import 'package:bin_yousuf_driver/core/constants/styles.dart';
import 'package:bin_yousuf_driver/core/models/models/notification_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: outfitTitleText(
          text: 'Notification',
          fontSize: 18.sp,
        ),
        titleSpacing: 0.sp,
        actions: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 5.w),
            margin: EdgeInsets.symmetric(horizontal: 15.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.sp),
              color: mainColor,
            ),
            child: outfitMediumText(
              text: '2 New',
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
              color: whiteColor,
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
      body: ListView.builder(
          shrinkWrap: true,
          // padding: EdgeInsets.symmetric(horizontal: 20.w),
          physics: const BouncingScrollPhysics(),
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                SizedBox(
                  width: 1.sw,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 2.h),
                    child: Column(
                      children: [
                        if (index == 0)
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 6.h),
                              child: outfitNormalText(
                                text: 'Today',
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: textGreyColor,
                              ),
                            ),
                          ),
                        if (index == 3)
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 6.h),
                              child: outfitNormalText(
                                text: 'Yesterday',
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: textGreyColor,
                              ),
                            ),
                          ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 48.w,
                              height: 48.h,
                              padding: EdgeInsets.all(8.sp),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: lightGreyColor,
                              ),
                              child: Image.asset(
                                notifications[index].status == 'green'
                                    ? greenTick
                                    : notifications[index].status == 'red'
                                        ? redCross
                                        : greenTick,
                              ),
                            ),
                            SizedBox(
                              width: 271.w,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  outfitMediumText(
                                    text: notifications[index].notification,
                                    fontSize: 16.sp,
                                    maxLines: 3,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  SizedBox(height: 15.h),
                                  outfitNormalText(
                                    text: notifications[index].time,
                                    color: textGreyColor,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5.h),
                        if (index != 2)
                          const Divider(
                            color: lightGreyColor,
                            // thickness: 2,
                          ),
                      ],
                    ),
                  ),
                ),
                if (index == 2)
                  const Divider(
                    color: lightGreyColor,
                    thickness: 2,
                  ),
              ],
            );
          }),
    );
  }
}
