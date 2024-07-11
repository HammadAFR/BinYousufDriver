import 'package:bin_yousuf_driver/core/constants/colors.dart';
import 'package:bin_yousuf_driver/core/constants/styles.dart';
import 'package:bin_yousuf_driver/core/constants/helper%20widgets/custom_button.dart';
import 'package:bin_yousuf_driver/view/Completed%20Orders/Widgets/completed_orders_list_item.dart';
import 'package:bin_yousuf_driver/view/Receipt/receipt_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../core/models/models/order_model.dart';

class CompletedOrdersScreen extends StatefulWidget {
  const CompletedOrdersScreen({
    super.key,
    required this.title,
    required this.order,
  });
  final String title;
  final OrderModel order;

  @override
  State<CompletedOrdersScreen> createState() => _CompletedOrdersScreenState();
}

class _CompletedOrdersScreenState extends State<CompletedOrdersScreen> {
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
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
                    text: 'Order# ${widget.order.orderNumber.toString()}',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  child: Row(
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
                      SizedBox(width: 5.w),
                      outfitTitleText(
                        text: 'Completed',
                        fontSize: 18.sp,
                        color: greenColor,
                      ),
                      SizedBox(width: 20.w),
                    ],
                  ),
                ),
              ],
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
                    itemCount: widget.order.items!.length,
                    itemBuilder: (context, index) {
                      return CompletedOrdersList(
                        name: widget.order.items![index].name!,
                        image: widget.order.items![index].attachment!,
                        weight: widget.order.items![index].weight!,
                        quantity: widget.order.items![index].quantity!,
                        amount: widget.order.items![index].price!,
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
                        text: 'Qeemat (${widget.order.items!.length} items)',
                        fontSize: 14.sp,
                      ),
                      outfitMediumText(
                        text: 'Rs. ${widget.order.amount}',
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
                        text: 'Rs. ${widget.order.amount}',
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
                Get.to(() => ReceiptScreen(
                      order: widget.order,
                    ));
              },
              child: const CustomButton(
                text: 'View Receipt',
              ),
            ),
            SizedBox(height: 50.h),
          ],
        ),
      ),
    );
  }
}
