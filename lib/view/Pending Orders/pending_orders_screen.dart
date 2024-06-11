import 'package:bin_yousuf_driver/core/constants/assets.dart';
import 'package:bin_yousuf_driver/core/constants/colors.dart';
import 'package:bin_yousuf_driver/core/constants/styles.dart';
import 'package:bin_yousuf_driver/core/constants/helper%20widgets/custom_button.dart';
import 'package:bin_yousuf_driver/view/Deliver%20Order/deliver_order_screen.dart';

import 'package:bin_yousuf_driver/view/Pending%20Orders/Widgets/pending_orders_list_item.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PendingOrdersScreen extends StatefulWidget {
  const PendingOrdersScreen({
    super.key,
    required this.title,
  });
  final String title;

  @override
  State<PendingOrdersScreen> createState() => _PendingOrdersScreenState();
}

class _PendingOrdersScreenState extends State<PendingOrdersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: outfitMediumText(
          text: widget.title,
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
        ),
        titleSpacing: 0,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: 10.h),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      goldenColor2,
                      goldenColor2,
                      goldenColor2,
                      whiteColor,
                    ],
                  ),
                ),
                child: outfitMediumText(
                  text: 'ORDER #1122334455',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: 15.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 5,
                        child: outfitTitleText(text: 'Item', fontSize: 16.sp),
                      ),
                      Expanded(
                        flex: 2,
                        child:
                            outfitTitleText(text: 'Miqdaar', fontSize: 16.sp),
                      ),
                      // SizedBox(width: 10.w),
                      Expanded(
                        flex: 2,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child:
                              outfitTitleText(text: 'Qeemat', fontSize: 16.sp),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10.h),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return PendingOrdersList(
                        name: 'Daal Channa Supreme',
                        image: daalChannaSupreme,
                        weight: 5,
                        quantity: 2,
                        amount: 2200,
                      );
                    },
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: outfitTitleText(
                      text: 'Billing',
                      fontSize: 16.sp,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      outfitNormalText(
                        text: 'Qeemat (4 items)',
                        fontSize: 14.sp,
                      ),
                      outfitMediumText(
                        text: 'Rs. 9800',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                  SizedBox(height: 15.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      outfitNormalText(
                        text: 'Delivery Fee',
                        fontSize: 14.sp,
                      ),
                      outfitMediumText(
                        text: 'Rs. 0',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                  SizedBox(height: 15.h),
                  const Divider(),
                  SizedBox(height: 15.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      outfitNormalText(
                        text: 'Kul Qeemat',
                        fontSize: 14.sp,
                      ),
                      outfitMediumText(
                        text: 'Rs. 9800',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 50.h),
            GestureDetector(
              onTap: () {
                Get.to(const DeliverOrderScreen());
              },
              child: const CustomButton(
                text: 'Deliver Now',
              ),
            ),
            SizedBox(height: 50.h),
          ],
        ),
      ),
    );
  }
}
