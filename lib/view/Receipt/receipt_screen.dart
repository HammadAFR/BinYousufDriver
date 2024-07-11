import 'dart:developer';
import 'dart:typed_data';

import 'package:bin_yousuf_driver/core/constants/assets.dart';
import 'package:bin_yousuf_driver/core/constants/colors.dart';
import 'package:bin_yousuf_driver/core/constants/styles.dart';
import 'package:bin_yousuf_driver/core/constants/helper%20widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:intl/intl.dart';
import 'package:screenshot/screenshot.dart';

import '../../core/models/models/order_model.dart';
import '../../core/utils/general_utils.dart';
import '../Home/bottom_navigation_bar.dart';

class ReceiptScreen extends StatefulWidget {
  const ReceiptScreen({super.key, required this.order});
  final OrderModel order;

  @override
  State<ReceiptScreen> createState() => _ReceiptScreenState();
}

class _ReceiptScreenState extends State<ReceiptScreen> {
  ScreenshotController screenshotController = ScreenshotController();

  final List<DataColumn> columns = [
    DataColumn(
      label: outfitMediumText(
        text: 'Description',
        fontSize: 11.sp,
        fontWeight: FontWeight.w600,
        color: textGreyColor2,
      ),
    ),
    DataColumn(
      label: outfitMediumText(
        text: 'Unit',
        fontSize: 11.sp,
        fontWeight: FontWeight.w600,
        color: textGreyColor2,
      ),
    ),
    DataColumn(
      label: outfitMediumText(
        text: 'Quantity',
        fontSize: 11.sp,
        fontWeight: FontWeight.w600,
        color: textGreyColor2,
      ),
    ),
    DataColumn(
      label: outfitMediumText(
        text: 'Unit Price',
        fontSize: 11.sp,
        fontWeight: FontWeight.w600,
        color: textGreyColor2,
      ),
    ),
    DataColumn(
      label: outfitMediumText(
        text: 'Total Price',
        fontSize: 11.sp,
        fontWeight: FontWeight.w600,
        color: textGreyColor2,
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd/MM/yy').format(now);
    String formattedTime = DateFormat('hh:mm:ss a').format(now);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: outfitTitleText(
          text: 'Receipt',
          fontSize: 18.sp,
        ),
        titleSpacing: 0.sp,
      ),
      body: ListView(
        children: [
          Screenshot(
            controller: screenshotController,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
              color: Theme.of(context).colorScheme.surface,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        appLogo,
                        width: 62.w,
                        height: 62.h,
                      ),
                      SizedBox(
                        height: 55.h,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            outfitMediumText(
                              text: 'Receipt no ${widget.order.receiptNumber}',
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            outfitMediumText(
                              text: formattedDate,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w600,
                              color: textGrey2,
                            ),
                            outfitMediumText(
                              text: formattedTime,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w600,
                              color: textGrey2,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5.h),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      height: 55.h,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          outfitMediumText(
                            text: 'Bin Yousaf - Rice Market',
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          Row(
                            children: [
                              outfitMediumText(
                                text: 'User:  ',
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w900,
                                color: textGrey2,
                              ),
                              outfitMediumText(
                                text: widget.order.placedBy!.name!,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                                color: textGrey2,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              outfitMediumText(
                                text: 'Order no:  ',
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w900,
                                color: textGrey2,
                              ),
                              outfitMediumText(
                                text: widget.order.orderNumber.toString(),
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                                color: textGrey2,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  SizedBox(
                    width: double.infinity,
                    child: DataTable(
                      columns: columns,
                      rows: widget.order.items!.map((item) {
                        return DataRow(
                          cells: [
                            DataCell(
                              outfitMediumText(
                                text: item.name!,
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w600,
                                color: textGreyColor3,
                              ),
                            ),
                            DataCell(
                              outfitMediumText(
                                text: item.weight!,
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w600,
                                color: textGreyColor3,
                              ),
                            ),
                            DataCell(
                              outfitMediumText(
                                text: item.quantity.toString(),
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w600,
                                color: textGreyColor3,
                              ),
                            ),
                            DataCell(
                              outfitMediumText(
                                text: item.originalPrice.toString(),
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w600,
                                color: textGreyColor3,
                              ),
                            ),
                            DataCell(
                              outfitMediumText(
                                text: item.price.toString(),
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w600,
                                color: textGreyColor3,
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                      columnSpacing: 10.0.w,
                      headingRowColor: WidgetStateProperty.all(tableGreyColor),
                      horizontalMargin: 10.0.w,
                      dataRowMaxHeight: 50.0.h,
                      headingRowHeight: 60.0.h,
                      dividerThickness: 0.0,
                      border: const TableBorder(
                        top: BorderSide(color: tableGreyColor),
                        left: BorderSide(color: tableGreyColor),
                        right: BorderSide(color: tableGreyColor),
                        bottom: BorderSide(color: tableGreyColor),
                        horizontalInside: BorderSide.none,
                        verticalInside: BorderSide(color: tableGreyColor),
                      ),
                    ),
                  ),
                  SizedBox(height: 15.h),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      width: 145.w,
                      height: 29.h,
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      decoration: BoxDecoration(
                        border: Border.all(color: tableGreyColor),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          outfitMediumText(
                            text: 'Grand Total',
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          outfitMediumText(
                            text: 'Rs. ${widget.order.amount}',
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w600,
                            color: textGrey2,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 15.h),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Note:',
                          style: outfitStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w800,
                            color: textGrey2,
                          ),
                        ),
                        TextSpan(
                          text:
                              ' Maal wasool kartay waqt check kar lain. Daalain kharaab hojanay ke baad tabdeel nahi houngi.',
                          style: outfitStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: textGrey2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 150.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: GestureDetector(
              onTap: () async {
                Uint8List? image = await screenshotController.capture();
                if (image != null) {
                  final result = await ImageGallerySaver.saveImage(image);
                  log(result.toString());
                  if (result['isSuccess']) {
                    Utils.successflushbarMessage('Receipt Downloaded', context);
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: outfitMediumText(
                              text: 'Raseed aapki gallery mein save hogai hai',
                              textAlign: TextAlign.center),
                          actions: <Widget>[
                            Center(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: BeveledRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                onPressed: () {
                                  Get.offAll(() =>
                                      CustomBottomNavigationBar(pageIndex: 0));
                                },
                                child: outfitNormalText(text: 'Okay'),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    Utils.flushbarMessage(
                        'Failed to download receipt', context);
                  }
                }
              },
              child: const CustomButton(text: 'Download'),
            ),
          ),
          SizedBox(height: 30.h),
        ],
      ),
    );
  }
}
