import 'package:bin_yousuf_driver/core/constants/assets.dart';
import 'package:bin_yousuf_driver/core/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnBoardingWidget1 extends StatelessWidget {
  const OnBoardingWidget1({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 104.h),
      child: Column(
        children: [
          outfitTitleText(text: 'Asaan Rasayi', fontSize: 28.sp),
          SizedBox(height: 17.h),
          outfitNormalText(
            text: 'Kiryana khareedari ko banaye mazeed asaan.',
            fontSize: 19.sp,
            color: Colors.grey[500],
            textAlign: TextAlign.center,
          ),
          Container(
            height: 330.h,
            padding: EdgeInsets.only(right: 40.w),
            child: Image.asset(
              ob1,
              width: 337.w,
              height: 337.h,
            ),
          )
        ],
      ),
    );
  }
}
