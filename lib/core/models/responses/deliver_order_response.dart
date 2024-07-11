import '../models/deliver_order_model.dart';
import 'base_response/base_response.dart';

class DeliverOrderResponse extends BaseResponse {
  DeliverOrderResponse(success, {error}) : super(success, error: error);

  DeliverOrderModel? deliveredOrder;

  DeliverOrderResponse.fromJson(json) : super.fromJson(json) {
    if (json['body']['order'] != null) {
      deliveredOrder = DeliverOrderModel.fromJson(json['body']['order']);
    }
  }
}
