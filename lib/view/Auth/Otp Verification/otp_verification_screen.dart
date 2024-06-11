import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/assets.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/helper widgets/custom_button.dart';
import '../../../core/constants/styles.dart';
import '../../../core/enums/status.dart';
import '../auth_view_model.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key, required this.number});
  final String number;

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthViewModel>(builder: (context, model, child) {
      return ModalProgressHUD(
        inAsyncCall: model.state == ViewState.busy,
        progressIndicator: const SpinKitFadingCube(color: goldenColor),
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: 1.sw,
                  height: 400.h,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(otpBackground),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SizedBox(height: 15.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Column(
                    children: [
                      outfitTitleText(
                        text: 'OTP Verification',
                        fontSize: 30.sp,
                        color: textGreyColor2,
                      ),
                      SizedBox(height: 5.h),
                      outfitNormalText(
                        text:
                            'Hum aapko is number pe code bhejengay wo idher likh dein. Shukriya',
                        fontSize: 20.sp,
                        textAlign: TextAlign.center,
                        color: textGreyColor2,
                      ),
                      SizedBox(height: 15.h),
                      outfitTitleText(text: widget.number, fontSize: 15.sp),
                      SizedBox(height: 15.h),
                      OtpTextField(
                        numberOfFields: 6,
                        margin: EdgeInsets.symmetric(horizontal: 3.w),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 5.w, vertical: 5.h),
                        showFieldAsBox: true,
                        fieldWidth: 45,
                        borderRadius: BorderRadius.circular(40.r),
                        enabledBorderColor: lightGreyColor,
                        focusedBorderColor: mainColor,
                        onCodeChanged: (value) {
                          //TODO ADD FUNCTION HERE
                        },
                        onSubmit: (value) {
                          model.otp = value;
                          log(model.otp);
                          // model.stringToIntOtp();
                        },
                      ),
                      SizedBox(height: 20.h),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            WidgetSpan(
                              child: outfitNormalText(
                                text: 'Code nahi mila?',
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                                color: darkGreyColor,
                              ),
                            ),
                            WidgetSpan(
                              child: GestureDetector(
                                onTap: () {
                                  model.verifyPhoneNumber(
                                      widget.number, true, context);
                                },
                                child: outfitNormalText(
                                  text: ' Phir se bhejain.',
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500,
                                  color: mainColor,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 40.h),
                      GestureDetector(
                        onTap: () async {
                          model.submitSmsCode(model.otp, context);
                        },
                        child: const CustomButton(text: 'Agay Barhein'),
                      ),
                      SizedBox(height: 30.h),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
