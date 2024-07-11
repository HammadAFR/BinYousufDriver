import '../models/order_model.dart';
import 'base_response/base_response.dart';

class GetPendingOrdersResponse extends BaseResponse {
  List<OrderModel> listOfOrders = [];

  ///Default Constructor
  GetPendingOrdersResponse(success, {error}) : super(success, error: error);

  ///Named Constructor
  GetPendingOrdersResponse.fromJson(json) : super.fromJson(json) {
    if (json['body']['pendingOrders'] != null) {
      json['body']['pendingOrders'].forEach((json) {
        listOfOrders.add(OrderModel.fromJson(json));
      });
    }
  }
}
