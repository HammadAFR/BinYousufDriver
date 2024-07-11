import 'package:bin_yousuf_driver/core/constants/assets.dart';
import 'package:bin_yousuf_driver/core/constants/colors.dart';
import 'package:bin_yousuf_driver/core/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../../core/enums/status.dart';
import 'notifications_view_model.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      final notificationProvider =
          Provider.of<NotificationsViewModel>(context, listen: false);
      await notificationProvider.fetchNotifications();
      if (notificationProvider.notifications.isNotEmpty) {
        await notificationProvider.markNotificationsAsRead();
      }
      notificationProvider.hasBeenRead();
    });
  }

  Future<bool> onWillPop(NotificationsViewModel notificationProvider) async {
    notificationProvider.clearUnreadCount();
    return true; // Return true to allow the pop
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NotificationsViewModel>(builder: (context, model, child) {
      return ModalProgressHUD(
        inAsyncCall: model.state == ViewState.busy,
        progressIndicator: const SpinKitFadingCube(color: goldenColor),
        child: PopScope(
          onPopInvoked: (didPop) async {
            await onWillPop(model);
          },
          child: Scaffold(
            appBar: AppBar(
              // leading: IconButton(
              //   onPressed: () {
              //     Get.back();
              //   },
              //   icon: const Icon(Icons.arrow_back_ios_new_rounded),
              // ),
              title: outfitTitleText(
                text: 'Notifications',
                fontSize: 18.sp,
              ),
              centerTitle: true,
              titleSpacing: 0.sp,
              actions: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 5.w),
                  margin: EdgeInsets.symmetric(horizontal: 15.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.sp),
                    color: mainColor,
                  ),
                  child: outfitMediumText(
                    text: '${model.unreadCount} New',
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: whiteColor,
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
            body: model.notifications.isEmpty
                ? Center(
                    child: outfitMediumText(text: 'No Notifications Yet'),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: model.notifications.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          SizedBox(
                            width: 1.sw,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: 48.w,
                                        height: 48.h,
                                        padding: EdgeInsets.all(8.sp),
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: lightGreyColor,
                                        ),
                                        child: Image.asset(
                                          model.notifications[index].status == 3
                                              ? redCross
                                              : greenTick,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 271.w,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            outfitMediumText(
                                              text: model.notifications[index]
                                                  .description!,
                                              fontSize: 16.sp,
                                              maxLines: 3,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            SizedBox(height: 15.h),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                outfitNormalText(
                                                  text: model
                                                      .notifications[index]
                                                      .notificationDate!,
                                                  color: textGreyColor,
                                                ),
                                                (model.notifications[index]
                                                            .readStatus ==
                                                        0)
                                                    ? outfitNormalText(
                                                        text: 'New',
                                                        color: mainColor)
                                                    : const SizedBox(),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5.h),
                                  const Divider(
                                    color: lightGreyColor,
                                    // thickness: 2,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
          ),
        ),
      );
    });
  }
}
