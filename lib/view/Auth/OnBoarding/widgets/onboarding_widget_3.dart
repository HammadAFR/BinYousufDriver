import 'package:bin_yousuf_driver/core/constants/assets.dart';
import 'package:bin_yousuf_driver/core/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnBoardingWidget3 extends StatelessWidget {
  const OnBoardingWidget3({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 104.h),
      child: Column(
        children: [
          outfitTitleText(text: 'Har Jagah Rasayi', fontSize: 28.sp),
          SizedBox(height: 17.h),
          outfitNormalText(
            text: 'Apki asaani, Apki khidmat, Hamara maqsad',
            fontSize: 19.sp,
            color: Colors.grey[500],
            textAlign: TextAlign.center,
          ),
          Container(
            height: 330.h,
            padding: EdgeInsets.only(left: 30.w, top: 40.h),
            child: Image.asset(
              ob3,
              width: 320.w,
              height: 300.h,
            ),
          )
        ],
      ),
    );
  }
}
