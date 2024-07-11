import 'package:bin_yousuf_driver/core/constants/assets.dart';
import 'package:bin_yousuf_driver/core/constants/colors.dart';
import 'package:bin_yousuf_driver/core/constants/styles.dart';
import 'package:bin_yousuf_driver/view/Home/Widgets/completed_order_container.dart';
import 'package:bin_yousuf_driver/view/Home/Widgets/pending_order_container.dart';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../../core/enums/status.dart';
import 'home_screen_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int currentIndex = 0;

  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();

    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Provider.of<HomeScreenViewModel>(context, listen: false).refreshOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<HomeScreenViewModel>(builder: (context, model, child) {
        return ModalProgressHUD(
          inAsyncCall: model.state == ViewState.busy,
          progressIndicator: const SpinKitFadingCube(color: goldenColor),
          child: Padding(
            padding: EdgeInsets.only(left: 18.w, right: 18.w, top: 60.h),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      outfitNormalText(text: 'Khush Amdeed', fontSize: 14.sp),
                      SizedBox(width: 5.w),
                      Image.asset(
                        handIcon,
                        width: 14.w,
                        height: 21.h,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 11.h),
                TabBar(
                  controller: _tabController,
                  indicatorColor: mainColor,
                  labelPadding: EdgeInsets.zero,
                  indicatorPadding: EdgeInsets.zero,
                  indicator: const BoxDecoration(),
                  dividerColor: Colors.transparent,
                  // padding: EdgeInsets.zero,
                  onTap: (val) {
                    currentIndex = val;
                    setState(() {});
                  },
                  tabs: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 400),
                      width: 169.w,
                      height: 46.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7.r),
                        border: Border.all(
                            color:
                                currentIndex == 0 ? mainColor : lightGreyColor),
                        color: currentIndex == 0 ? tabColor : whiteColor,
                        boxShadow: [
                          BoxShadow(
                            color: lightGreyColor.withOpacity(.5),
                            spreadRadius: 2,
                            blurRadius: 3,
                          )
                        ],
                      ),
                      child: Center(
                        child: outfitMediumText(
                          text: 'Pending Orders',
                          fontSize: 16.sp,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 400),
                      width: 169.w,
                      height: 46.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7.r),
                        border: Border.all(
                            color:
                                currentIndex == 1 ? mainColor : lightGreyColor),
                        color: currentIndex == 1 ? tabColor : whiteColor,
                        boxShadow: [
                          BoxShadow(
                            color: lightGreyColor.withOpacity(.5),
                            spreadRadius: 2,
                            blurRadius: 3,
                          )
                        ],
                      ),
                      child: Center(
                        child: outfitMediumText(
                          text: 'Completed Orders',
                          fontSize: 16.sp,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: model.listOfPendingOrders.length + 1,
                        itemBuilder: (context, index) {
                          if (index == model.listOfPendingOrders.length) {
                            return SizedBox(height: 80.h);
                          }
                          return PendingOrderContainer(
                            order: model.listOfPendingOrders[index],
                          );
                        },
                      ),
                      ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: model.listOfCompletedOrders.length + 1,
                        itemBuilder: (context, index) {
                          if (index == model.listOfCompletedOrders.length) {
                            return SizedBox(height: 80.h);
                          }
                          return CompletedOrderContainer(
                            order: model.listOfCompletedOrders[index],
                          );
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
