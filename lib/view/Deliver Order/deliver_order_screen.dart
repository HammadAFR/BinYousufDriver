import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../../core/constants/colors.dart';
import '../../core/constants/helper widgets/custom_button.dart';
import '../../core/constants/styles.dart';
import '../../core/enums/status.dart';
import '../Delivery Success/delivery_success_screen.dart';
import 'deliver_view_model.dart';

class DeliverOrderScreen extends StatefulWidget {
  const DeliverOrderScreen({super.key});

  @override
  State<DeliverOrderScreen> createState() => _DeliverOrderScreenState();
}

class _DeliverOrderScreenState extends State<DeliverOrderScreen> {
  static const LatLng _center = LatLng(32.8143, 73.8831);

  @override
  Widget build(BuildContext context) {
    return Consumer<DeliverViewModel>(builder: (context, model, child) {
      return ModalProgressHUD(
        inAsyncCall: model.state == ViewState.busy,
        progressIndicator: const SpinKitFadingCube(color: goldenColor),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: GoogleMap(
                  onMapCreated: model.onMapCreated,
                  markers: {
                    Marker(
                      markerId: const MarkerId('marker1'),
                      position: LatLng(model.lat, model.lng),
                    ),
                  },
                  initialCameraPosition:
                      const CameraPosition(target: _center, zoom: 14.0),
                  onTap: (argument) async {
                    // latitude = argument.latitude;
                    // longitude = argument.longitude;
                    await model.setLatLng(
                        argument.latitude, argument.longitude);
                  },
                ),
              ),
              Positioned(
                top: 42.h,
                left: 25.w,
                child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    width: 87.w,
                    height: 33.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40.r),
                      color: mainColor,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.arrow_back,
                          color: whiteColor,
                          size: 16,
                        ),
                        SizedBox(width: 5.w),
                        outfitMediumText(
                          text: 'Back',
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                          color: whiteColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 42.h,
                right: 25.w,
                child: Container(
                  width: 44.w,
                  height: 88.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(color: mainColor),
                    color: whiteColor,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          //TODO
                        },
                        child: const Icon(
                          Icons.map_sharp,
                          color: mainColor,
                        ),
                      ),
                      const Divider(
                        color: mainColor,
                      ),
                      GestureDetector(
                        onTap: () {
                          //TODO
                        },
                        child: const Icon(
                          Icons.send,
                          color: mainColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          bottomSheet: Container(
            height: 236.h,
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.r),
                topRight: Radius.circular(30.r),
              ),
              border: Border.all(
                color: mainColor,
              ),
            ),
            child: Column(
              children: [
                SizedBox(height: 20.h),
                GestureDetector(
                  onTap: () {
                    Get.to(const DeliverySuccessScreen());
                  },
                  child: CustomButton(
                    text: 'Deliver',
                    width: 327.w,
                  ),
                ),
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    outfitMediumText(
                      text: 'Delivery Date',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    outfitNormalText(
                      text: '20th Feb 2024',
                      fontSize: 12.sp,
                      color: textGreyColor2,
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                const Divider(
                  color: lightGreyColor,
                  thickness: 2,
                ),
                SizedBox(height: 10.h),
                SizedBox(
                  height: 80.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Container(
                            width: 21.w,
                            height: 21.h,
                            // padding: EdgeInsets.all(5.sp),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: mainColor,
                              ),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.circle,
                                color: mainColor,
                                size: 12,
                              ),
                            ),
                          ),
                          DottedLine(
                            direction: Axis.vertical,
                            lineLength: 35.h,
                            dashColor: textGreyColor,
                            lineThickness: 2.sp,
                          ),
                          const Icon(
                            Icons.location_on,
                            color: redColor,
                          ),
                        ],
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 280.w,
                              child: outfitMediumText(
                                text: 'Spinzar Plaza, Abdara Road Peshawar',
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600,
                                textOverflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                            Container(
                              width: 280.w,
                              padding: EdgeInsets.only(bottom: 4.h),
                              child: outfitMediumText(
                                text: 'Hayatabad, Peshawar',
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600,
                                textOverflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
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
