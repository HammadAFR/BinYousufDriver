import 'package:bin_yousuf_driver/core/constants/colors.dart';
import 'package:bin_yousuf_driver/core/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PendingOrdersList extends StatelessWidget {
  const PendingOrdersList({
    super.key,
    required this.image,
    required this.name,
    required this.weight,
    required this.quantity,
    required this.amount,
  });
  final String image;
  final String name;
  final String weight;
  final int quantity;
  final int amount;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 5,
              child: SizedBox(
                child: Row(
                  children: [
                    Image.network(
                      image,
                      width: 33.w,
                      height: 55.h,
                    ),
                    SizedBox(width: 3.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 140.w,
                          child: outfitTitleText(
                            text: name,
                            fontSize: 15.sp,
                            textOverflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        outfitNormalText(
                          text: weight,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w300,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: outfitNormalText(
                text: quantity.toString(),
                fontSize: 15.sp,
                fontWeight: FontWeight.w300,
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              flex: 2,
              child: Align(
                alignment: Alignment.centerRight,
                child: outfitTitleText(
                  text: 'Rs. $amount',
                  fontSize: 15.sp,
                  color: darkGreyColor,
                ),
              ),
            )
          ],
        ),
        const Divider(),
      ],
    );
  }
}
