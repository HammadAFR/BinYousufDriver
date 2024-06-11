import 'package:bin_yousuf_driver/core/constants/colors.dart';
import 'package:bin_yousuf_driver/core/constants/styles.dart';
import 'package:bin_yousuf_driver/view/Completed%20Orders/completed_orders_screen.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CompletedOrderContainer extends StatelessWidget {
  const CompletedOrderContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(
          const CompletedOrdersScreen(
            title: '20th Feb 2024',
          ),
        );
      },
      child: Container(
        width: double.infinity,
        height: 154.h,
        margin: EdgeInsets.symmetric(vertical: 5.h),
        padding:
            EdgeInsets.only(left: 15.w, bottom: 12.h, top: 15.h, right: 8.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: mainColor),
        ),
        child: Column(
          children: [
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
                  Column(
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
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(),
                SizedBox(
                  width: 280.w,
                  child: Column(
                    children: [
                      const Divider(
                        color: lightGreyColor,
                        thickness: 2,
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            width: 15.w,
                            height: 15.h,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: greenColor,
                            ),
                            child: const Icon(
                              Icons.done,
                              color: whiteColor,
                              size: 11,
                            ),
                          ),
                          SizedBox(width: 10.w),
                          outfitTitleText(
                            text: 'Completed',
                            fontSize: 18.sp,
                            color: greenColor,
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
