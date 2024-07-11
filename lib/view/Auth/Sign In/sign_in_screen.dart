import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/assets.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/helper widgets/custom_button.dart';
import '../../../core/constants/styles.dart';
import '../../../core/enums/status.dart';
import '../../../core/utils/general_utils.dart';
import '../auth_view_model.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  String phoneNumber = '';
  bool isPhoneValid = false;
  FocusNode phoneFocusNode = FocusNode();
  bool locationEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthViewModel>(builder: (context, model, child) {
      return ModalProgressHUD(
        inAsyncCall: model.state == ViewState.busy,
        progressIndicator: const SpinKitFadingCube(color: goldenColor),
        child: GestureDetector(
          onTap: phoneFocusNode.unfocus,
          child: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 450.h,
                    width: 1.sw,
                    padding: EdgeInsets.only(top: 100.h, left: 30.w),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(signInBackground),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        outfitTitleText(
                          text: 'Khush',
                          fontSize: 36.sp,
                          color: whiteColor,
                        ),
                        outfitTitleText(
                          text: 'Aamdeed',
                          fontSize: 36.sp,
                          color: whiteColor,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        outfitTitleText(
                          text: 'SIGN IN',
                          fontSize: 30.sp,
                          color: textGreyColor2,
                        ),
                        SizedBox(height: 5.h),
                        outfitNormalText(
                          text:
                              'Apna Mobile number neechay khanay mein likhiye',
                          fontSize: 20.sp,
                          color: textGreyColor2,
                        ),
                        SizedBox(height: 35.h),
                        outfitTitleText(
                          text: 'Mobile Number',
                          fontSize: 15.sp,
                          color: textGreyColor2,
                        ),
                        SizedBox(height: 10.h),
                        Form(
                          key: _formKey,
                          child: SizedBox(
                            height: 70.h,
                            child: IntlPhoneField(
                              controller: model.phoneNumberContoller,
                              focusNode: phoneFocusNode,
                              keyboardType: TextInputType.number,
                              showDropdownIcon: false,
                              decoration: InputDecoration(
                                hintText: 'Apna Number Likhiye',
                                hintStyle: outfitStyle(
                                  fontSize: 15.sp,
                                  color: blackColor.withOpacity(0.4),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                  borderSide: const BorderSide(
                                    color: textGreyColor,
                                  ),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                  borderSide: const BorderSide(
                                    color: textGreyColor,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                  borderSide: const BorderSide(
                                    color: textGreyColor,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                  borderSide:
                                      const BorderSide(color: mainColor),
                                ),
                              ),
                              initialCountryCode: 'PK',
                              onChanged: (phone) {
                                phoneNumber = phone.completeNumber.toString();
                                debugPrint(phone.completeNumber);
                                isPhoneValid = phone.isValidNumber();
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 35.h),
                        GestureDetector(
                          onTap: () async {
                            locationEnabled =
                                await model.handleLocationPermission();
                            if (locationEnabled) {
                              if (isPhoneValid && phoneNumber != "") {
                                await model.verifyPhoneNumber(
                                    phoneNumber, false, context);
                              } else {
                                Utils.flushbarMessage(
                                    'Phone Number theek se likhiye', context);
                              }
                            }
                          },
                          child: const CustomButton(text: 'Agay Barhein'),
                        ),
                        SizedBox(height: 35.h),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
