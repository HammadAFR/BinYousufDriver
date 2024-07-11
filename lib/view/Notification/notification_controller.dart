import 'dart:developer';

import 'package:get/get.dart';

class NotificationsController extends GetxController {
  var unreadCount = 0.obs;

  void incrementUnreadCount() {
    log('inside increment counter');
    unreadCount++;
    log('counter value is ===================> ${unreadCount.toString()}');
  }

  void resetUnreadCount() {
    unreadCount.value = 0;
  }
}
