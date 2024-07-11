import 'package:bin_yousuf_driver/core/constants/assets.dart';
import 'package:bin_yousuf_driver/core/constants/colors.dart';
import 'package:bin_yousuf_driver/core/constants/styles.dart';
import 'package:bin_yousuf_driver/core/constants/helper%20widgets/custom_button.dart';
import 'package:bin_yousuf_driver/view/Home/home_screen_view_model.dart';
import 'package:bin_yousuf_driver/view/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: outfitTitleText(
          text: 'Profile',
          fontSize: 19.sp,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 48.h),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 100.h,
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                color: whiteColor,
                boxShadow: [
                  BoxShadow(
                    color: textGreyColor.withOpacity(0.5),
                    blurRadius: 5.sp,
                    spreadRadius: 1.sp,
                    offset: const Offset(0, 1),
                  )
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 45.r,
                    backgroundColor: Colors.transparent,
                    child: ClipOval(
                      child: Image.network(
                        globalUserModel.profileImage!,
                        width: 90.w,
                        height: 90.h,
                      ),
                    ),
                  ),
                  SizedBox(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        outfitMediumText(
                          text: globalUserModel.name!,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        SizedBox(height: 3.h),
                        // outfitNormalText(text: '03001287618', fontSize: 16.sp),
                        Row(
                          children: [
                            SizedBox(
                              width: 80.w,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  outfitTitleText(
                                    text: 'Cnic:',
                                    fontSize: 12.w,
                                    color: darkGreyColor,
                                  ),
                                  outfitTitleText(
                                    text: 'Mobile No:',
                                    fontSize: 12.w,
                                    color: darkGreyColor,
                                  ),
                                  outfitTitleText(
                                    text: 'Vehicle No:',
                                    fontSize: 12.w,
                                    color: darkGreyColor,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 145.w,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  outfitNormalText(
                                    text: globalUserModel.cnic!,
                                    fontSize: 12,
                                    maxLines: 1,
                                    textOverflow: TextOverflow.ellipsis,
                                    fontWeight: FontWeight.w300,
                                    color: darkGreyColor,
                                  ),
                                  outfitNormalText(
                                    text: globalUserModel.mobileNumber!,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                    maxLines: 1,
                                    textOverflow: TextOverflow.ellipsis,
                                    color: darkGreyColor,
                                  ),
                                  outfitNormalText(
                                    text: globalUserModel.vehicleNumber!,
                                    fontSize: 12,
                                    maxLines: 1,
                                    textOverflow: TextOverflow.ellipsis,
                                    fontWeight: FontWeight.w300,
                                    color: darkGreyColor,
                                  ),
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 40.h),
            Container(
              width: double.infinity,
              height: 303.h,
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                color: whiteColor,
                boxShadow: [
                  BoxShadow(
                    color: textGreyColor.withOpacity(0.5),
                    blurRadius: 5.sp,
                    spreadRadius: 1.sp,
                    offset: const Offset(0, 1),
                  )
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Share.share(
                          'Check out Bin Yousuf App : https://www.google.com/');
                    },
                    child: Row(
                      children: [
                        SizedBox(width: 8.w),
                        SizedBox(
                          width: 20.w,
                          child: Image.asset(
                            shareApp,
                            width: 20.w,
                            height: 20.h,
                            color: darkGreyColor,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        outfitTitleText(
                          text: 'Share App',
                          fontSize: 15.sp,
                          color: darkGreyColor,
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    color: lightGreyColor,
                  ),
                  GestureDetector(
                    onTap: () {
                      Provider.of<HomeScreenViewModel>(context, listen: false)
                          .openWhatsapp(context);
                    },
                    child: Row(
                      children: [
                        SizedBox(width: 8.w),
                        SizedBox(
                          width: 20.w,
                          child: Image.asset(
                            whatsappBlack,
                            width: 20.w,
                            height: 20.h,
                            color: darkGreyColor,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        outfitTitleText(
                          text: 'WhatsApp Helpline',
                          fontSize: 15.sp,
                          color: darkGreyColor,
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    color: lightGreyColor,
                  ),
                  Row(
                    children: [
                      SizedBox(width: 8.w),
                      SizedBox(
                        width: 20.w,
                        child: Image.asset(
                          rate,
                          width: 20.w,
                          height: 20.h,
                          color: darkGreyColor,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      outfitTitleText(
                        text: 'Rate App',
                        fontSize: 15.sp,
                        color: darkGreyColor,
                      ),
                    ],
                  ),
                  const Divider(
                    color: lightGreyColor,
                  ),
                  GestureDetector(
                    onTap: () {
                      showMaterialModalBottomSheet(
                        context: context,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.r),
                            topRight: Radius.circular(20.r),
                          ),
                        ),
                        builder: (context) => Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 22.w, vertical: 16.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.r),
                              topRight: Radius.circular(20.r),
                            ),
                          ),
                          height: 280.h,
                          child: Column(
                            children: [
                              Divider(
                                thickness: 3,
                                indent: 145.sp,
                                endIndent: 145.sp,
                              ),
                              SizedBox(height: 30.h),
                              outfitMediumText(
                                text: 'Logout',
                                fontSize: 24.sp,
                                fontWeight: FontWeight.w600,
                              ),
                              SizedBox(height: 13.h),
                              const Divider(
                                color: textGrey2,
                              ),
                              SizedBox(height: 22.h),
                              outfitNormalText(
                                  text:
                                      'Are you sure you want to logout from the App?',
                                  fontSize: 15.sp,
                                  textAlign: TextAlign.center),
                              SizedBox(height: 20.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  CustomButton(
                                    text: 'Cancel',
                                    width: 149.w,
                                    textColor: blackColor,
                                    buttonColor: lightGreyColor,
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      final prefs =
                                          await SharedPreferences.getInstance();
                                      prefs.clear();
                                      Get.offAll(() => const SplashScreen());
                                    },
                                    child: CustomTransparentButton(
                                      text: 'Yes, Logout',
                                      width: 149.w,
                                      textColor: mainColor,
                                      borderColor: mainColor,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        SizedBox(width: 8.w),
                        SizedBox(
                          width: 20.w,
                          child: Image.asset(
                            logout,
                            width: 20.w,
                            height: 20.h,
                            color: darkGreyColor,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        outfitTitleText(
                          text: 'Logout',
                          fontSize: 15.sp,
                          color: darkGreyColor,
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    color: lightGreyColor,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
