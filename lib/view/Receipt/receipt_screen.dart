import 'package:bin_yousuf_driver/core/constants/assets.dart';
import 'package:bin_yousuf_driver/core/constants/colors.dart';
import 'package:bin_yousuf_driver/core/constants/styles.dart';
import 'package:bin_yousuf_driver/core/constants/helper%20widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ReceiptScreen extends StatefulWidget {
  const ReceiptScreen({super.key});

  @override
  State<ReceiptScreen> createState() => _ReceiptScreenState();
}

class _ReceiptScreenState extends State<ReceiptScreen> {
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

  final List<DataRow> rows = [
    DataRow(
      cells: [
        DataCell(
          outfitMediumText(
            text: 'Rice Kainat',
            fontSize: 10.sp,
            fontWeight: FontWeight.w600,
            color: textGreyColor2,
          ),
        ),
        DataCell(
          outfitMediumText(
            text: '25 kg bag',
            fontSize: 10.sp,
            fontWeight: FontWeight.w600,
            color: textGreyColor2,
          ),
        ),
        DataCell(
          outfitMediumText(
            text: '02',
            fontSize: 10.sp,
            fontWeight: FontWeight.w600,
            color: textGreyColor2,
          ),
        ),
        DataCell(
          outfitMediumText(
            text: 'Rs. 2500',
            fontSize: 10.sp,
            fontWeight: FontWeight.w600,
            color: textGreyColor2,
          ),
        ),
        DataCell(
          outfitMediumText(
            text: 'Rs. 5000',
            fontSize: 10.sp,
            fontWeight: FontWeight.w600,
            color: textGreyColor2,
          ),
        ),
      ],
    ),
    DataRow(
      cells: [
        DataCell(
          outfitMediumText(
            text: 'Rice Kainat',
            fontSize: 10.sp,
            fontWeight: FontWeight.w600,
            color: textGreyColor2,
          ),
        ),
        DataCell(
          outfitMediumText(
            text: '25 kg bag',
            fontSize: 10.sp,
            fontWeight: FontWeight.w600,
            color: textGreyColor2,
          ),
        ),
        DataCell(
          outfitMediumText(
            text: '02',
            fontSize: 10.sp,
            fontWeight: FontWeight.w600,
            color: textGreyColor2,
          ),
        ),
        DataCell(
          outfitMediumText(
            text: 'Rs. 2500',
            fontSize: 10.sp,
            fontWeight: FontWeight.w600,
            color: textGreyColor2,
          ),
        ),
        DataCell(
          outfitMediumText(
            text: 'Rs. 5000',
            fontSize: 10.sp,
            fontWeight: FontWeight.w600,
            color: textGreyColor2,
          ),
        ),
      ],
    ),
    DataRow(
      cells: [
        DataCell(
          outfitMediumText(
            text: 'Rice Kainat',
            fontSize: 10.sp,
            fontWeight: FontWeight.w600,
            color: textGreyColor2,
          ),
        ),
        DataCell(
          outfitMediumText(
            text: '25 kg bag',
            fontSize: 10.sp,
            fontWeight: FontWeight.w600,
            color: textGreyColor2,
          ),
        ),
        DataCell(
          outfitMediumText(
            text: '02',
            fontSize: 10.sp,
            fontWeight: FontWeight.w600,
            color: textGreyColor2,
          ),
        ),
        DataCell(
          outfitMediumText(
            text: 'Rs. 2500',
            fontSize: 10.sp,
            fontWeight: FontWeight.w600,
            color: textGreyColor2,
          ),
        ),
        DataCell(
          outfitMediumText(
            text: 'Rs. 5000',
            fontSize: 10.sp,
            fontWeight: FontWeight.w600,
            color: textGreyColor2,
          ),
        ),
      ],
    ),
  ];
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
        title: outfitTitleText(
          text: 'Receipt',
          fontSize: 18.sp,
        ),
        titleSpacing: 0.sp,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Column(
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
                        text: 'Receipt no 1',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      outfitMediumText(
                        text: '5/3/2023',
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w600,
                        color: textGrey2,
                      ),
                      outfitMediumText(
                        text: '12:05:17 PM',
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
                          text: 'Admin',
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
                          text: '12345',
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
                rows: rows,
                columnSpacing: 10.0.w,
                headingRowColor: MaterialStateProperty.all(tableGreyColor),
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
                      text: 'Rs. 15,000',
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w600,
                      color: textGreyColor2,
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
            const Spacer(),
            const CustomButton(text: 'Download'),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }
}
