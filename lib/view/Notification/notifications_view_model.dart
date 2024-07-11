import 'dart:developer';

import 'package:flutter/material.dart';

import '../../core/enums/status.dart';
import '../../core/models/models/count_update_model.dart';
import '../../core/models/models/notifications_model.dart';
import '../../core/models/responses/notifications_response.dart';
import '../../core/models/responses/update_notification_count_response.dart';
import '../../core/others/base_view_model.dart';
import '../../core/services/database_services.dart';
import '../../core/utils/locator.dart';
import '../splash_screen.dart';

class NotificationsViewModel extends BaseViewModel {
  final _dbService = locator<DatabaseServices>();
  late NotificationsResponse _notificationsResponse;
  List<NotificationModel> _notifications = [];
  List<NotificationModel> get notifications => [..._notifications];
  late CountUpdateResponse _countUpdateResponse;
  late CountUpdateModel countUpdateModel;
  int _unreadCount = 0;
  int get unreadCount => _unreadCount;
  bool _hasRead = false;
  bool get hasRead => _hasRead;

  void hasBeenRead() {
    _hasRead = true;
  }

  ////////////////////Fetching Notifications////////////////////
  Future<void> fetchNotifications() async {
    setState(ViewState.busy);
    try {
      _notificationsResponse = await _dbService.getNotifications();
      if (_notificationsResponse.success) {
        _notifications = List.from(_notificationsResponse.listOfNotifications);
        setUnreadCount();
        setState(ViewState.idle);
        debugPrint(
            'the following is the response =============> ${_notificationsResponse.listOfNotifications}...total ===> ${_notificationsResponse.listOfNotifications}');
      }
    } catch (e) {
      setState(ViewState.idle);
      debugPrint(
          'this is the error encountered ==============> ${e.toString()}');
    }
  }

  ////////////////////Marking Notifications as Read///////////////////
  Future<void> markNotificationsAsRead() async {
    setState(ViewState.busy);
    try {
      log('inside mark as read api');
      _countUpdateResponse = await _dbService.updateNotificationsCount();

      if (_countUpdateResponse.success) {
        log('response is success');

        countUpdateModel = _countUpdateResponse.updatedNotification!;
        setState(ViewState.idle);
        debugPrint(
            'the following is the response =============> ${_countUpdateResponse.updatedNotification}');
      }
    } catch (e) {
      setState(ViewState.idle);
      log('response is failure');

      debugPrint(
          'this is the error encountered ==============> ${e.toString()}');
    }
  }

  ////////////////////Setting Unread Count////////////////////
  void setUnreadCount() {
    for (NotificationModel notification in _notifications) {
      if (notification.readStatus == 0) {
        _unreadCount++;
      }
      log('The number of unread notifications are ======================> $_unreadCount');
    }
  }

  ////////////////////Clearing Unread Count////////////////////
  void clearUnreadCount() {
    _unreadCount = 0;
    globalNotificationCountModel!.unreadCount = 0;
    _hasRead = false;
  }
}
