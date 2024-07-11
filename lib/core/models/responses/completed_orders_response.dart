import '../models/order_model.dart';
import 'base_response/base_response.dart';

class GetCompletedOrdersResponse extends BaseResponse {
  List<OrderModel> listOfOrders = [];

  ///Default Constructor
  GetCompletedOrdersResponse(success, {error}) : super(success, error: error);

  ///Named Constructor
  GetCompletedOrdersResponse.fromJson(json) : super.fromJson(json) {
    if (json['body']['deliveredOrders'] != null) {
      json['body']['deliveredOrders'].forEach((json) {
        listOfOrders.add(OrderModel.fromJson(json));
      });
    }
  }
}
