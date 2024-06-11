import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../styles.dart';

class InternetConnectivityDialog extends StatelessWidget {
  const InternetConnectivityDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
          child: outfitTitleText(
        text: "No Internet Connection",
        textAlign: TextAlign.center,
      )),
      content: SizedBox(
        height: 50.h,
        child: Center(
          child: outfitNormalText(
              text: "Please check your internet connection and try again.",
              textAlign: TextAlign.center,
              fontSize: 16.sp),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: outfitMediumText(
            text: 'OK',
            fontSize: 20.sp,
          ),
        ),
      ],
    );
  }
}
