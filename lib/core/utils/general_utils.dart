import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../constants/colors.dart';

class Utils {
  static void toastMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static void flushbarMessage(String message, BuildContext context) {
    showFlushbar(
      context: context,
      flushbar: Flushbar(
        forwardAnimationCurve: Curves.bounceIn,
        flushbarPosition: FlushbarPosition.TOP,
        borderRadius: BorderRadius.circular(5.r),
        margin: EdgeInsets.symmetric(
          horizontal: 20.w,
          vertical: 10.h,
        ),
        padding: EdgeInsets.all(15.sp),
        message: message,
        duration: const Duration(seconds: 3),
        backgroundColor: redColor,
        reverseAnimationCurve: Curves.easeOut,
        icon: const Icon(
          Icons.error_outline,
          color: whiteColor,
        ),
      )..show(context),
    );
  }

  static void successflushbarMessage(String message, BuildContext context) {
    showFlushbar(
      context: context,
      flushbar: Flushbar(
        forwardAnimationCurve: Curves.bounceIn,
        flushbarPosition: FlushbarPosition.TOP,
        borderRadius: BorderRadius.circular(5.r),
        margin: EdgeInsets.symmetric(
          horizontal: 20.w,
          vertical: 10.h,
        ),
        padding: EdgeInsets.all(15.sp),
        message: message,
        duration: const Duration(seconds: 3),
        backgroundColor: greenColor,
        reverseAnimationCurve: Curves.easeOut,
        icon: const Icon(
          Icons.done_outline_rounded,
          color: whiteColor,
        ),
      )..show(context),
    );
  }
}
