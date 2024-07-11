import '../models/notifications_model.dart';
import 'base_response/base_response.dart';

class NotificationsResponse extends BaseResponse {
  List<NotificationModel> listOfNotifications = [];

  ///Default Constructor
  NotificationsResponse(success, {error}) : super(success, error: error);

  ///Named Constructor
  NotificationsResponse.fromJson(json) : super.fromJson(json) {
    if (json['body']['notifications'] != null) {
      json['body']['notifications'].forEach((json) {
        listOfNotifications.add(NotificationModel.fromJson(json));
      });
    }
  }
}
