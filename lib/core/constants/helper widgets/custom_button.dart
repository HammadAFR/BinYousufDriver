import 'package:bin_yousuf_driver/core/constants/colors.dart';
import 'package:bin_yousuf_driver/core/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    required this.text,
    super.key,
    this.height,
    this.width,
    this.radius,
    this.buttonColor,
    this.textColor,
    this.fontsize,
    this.fontWeight,
  });
  final double? height;
  final double? width;
  final double? radius;
  final Color? buttonColor;
  final String text;
  final Color? textColor;
  final double? fontsize;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 350.w,
      height: height ?? 48.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius ?? 40.r),
        color: buttonColor ?? mainColor,
      ),
      child: Center(
        child: outfitTitleText(
            text: text,
            fontSize: fontsize ?? 16.sp,
            color: textColor ?? whiteColor,
            fontWeight: fontWeight),
      ),
    );
  }
}

class CustomTransparentButton extends StatelessWidget {
  const CustomTransparentButton({
    required this.text,
    super.key,
    this.height,
    this.width,
    this.radius,
    this.buttonColor,
    this.borderColor,
    this.textColor,
    this.fontsize,
    this.fontWeight,
  });
  final double? height;
  final double? width;
  final double? radius;
  final Color? buttonColor;
  final Color? borderColor;
  final String text;
  final Color? textColor;
  final double? fontsize;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 350.w,
      height: height ?? 48.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius ?? 40.r),
        color: buttonColor,
        border: Border.all(color: borderColor ?? mainColor),
      ),
      child: Center(
        child: outfitTitleText(
            text: text,
            fontSize: fontsize ?? 16.sp,
            color: textColor ?? mainColor,
            fontWeight: fontWeight),
      ),
    );
  }
}
