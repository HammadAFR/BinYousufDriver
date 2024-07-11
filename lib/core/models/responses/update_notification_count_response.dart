import '../models/count_update_model.dart';
import 'base_response/base_response.dart';

class CountUpdateResponse extends BaseResponse {
  CountUpdateResponse(success, {error}) : super(success, error: error);

  CountUpdateModel? updatedNotification;

  CountUpdateResponse.fromJson(json) : super.fromJson(json) {
    if (json['body'] != null) {
      updatedNotification = CountUpdateModel.fromJson(json['body']);
    }
  }
}
