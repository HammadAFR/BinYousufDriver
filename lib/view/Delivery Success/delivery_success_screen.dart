import 'package:bin_yousuf_driver/core/constants/assets.dart';
import 'package:bin_yousuf_driver/core/constants/colors.dart';
import 'package:bin_yousuf_driver/core/constants/styles.dart';
import 'package:bin_yousuf_driver/core/constants/helper%20widgets/custom_button.dart';
import 'package:bin_yousuf_driver/view/Home/bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DeliverySuccessScreen extends StatefulWidget {
  const DeliverySuccessScreen({super.key});

  @override
  State<DeliverySuccessScreen> createState() => _DeliverySuccessScreenState();
}

class _DeliverySuccessScreenState extends State<DeliverySuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              deliverySuccess,
              width: 254.w,
              height: 254.h,
            ),
            SizedBox(height: 44.h),
            outfitTitleText(
              text: 'Delivered Successfully',
              fontSize: 22.sp,
            ),
            SizedBox(height: 16.h),
            outfitMediumText(
              text: 'ORDER #1122334455 Deliver hogaya hai',
              fontSize: 16.sp,
              color: textGrey2,
            ),
            SizedBox(height: 50.h),
            GestureDetector(
              onTap: () {
                Get.offAll(CustomBottomNavigationBar(pageIndex: 0));
              },
              child: CustomButton(
                text: 'Return Home',
                width: 327.w,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
