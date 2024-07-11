import '../models/unread_count_model.dart';
import 'base_response/base_response.dart';

class GetNotificationCountResponse extends BaseResponse {
  GetNotificationCountResponse(success, {error}) : super(success, error: error);

  NotificationCountModel? notificationCountModel;

  GetNotificationCountResponse.fromJson(json) : super.fromJson(json) {
    if (json['body'] != null) {
      notificationCountModel = NotificationCountModel.fromJson(json['body']);
    }
  }
}
