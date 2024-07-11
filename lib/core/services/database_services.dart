import 'package:flutter/material.dart';

import '../constants/api_endpoints.dart';
import '../models/responses/completed_orders_response.dart';
import '../models/responses/deliver_order_response.dart';
import '../models/responses/get_unread_notifications_count.dart';
import '../models/responses/notifications_response.dart';
import '../models/responses/pending_orders_response.dart';
import '../models/responses/sign_in_response.dart';
import '../models/responses/update_notification_count_response.dart';
import 'api_services.dart';
import 'base services/base_api_services.dart';

class DatabaseServices {
  final BaseApiServices _apiServices = ApiServices();

  //SignIn Api
  Future<dynamic> signInApi(String phoneNumber, String fcmToken) async {
    debugPrint(
        'this is fcm token when signing in ======================> $fcmToken');
    Map signInCredentials = {
      "mobile_number": phoneNumber,
      "fcmToken": fcmToken
    };
    try {
      final response = await _apiServices.postApiService(
          url: EndPoints.signIn, data: signInCredentials);
      debugPrint(
          'response ======================================> ${response.data['body']['token']}');
      return AuthResponse.fromJson(response.data);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  //Getting Pending Orders
  Future<dynamic> getPendingOrders(String driverId) async {
    Map uid = {
      "driverId": driverId,
    };
    try {
      final response = await _apiServices.getApiService(
          url: EndPoints.pendingOrders, data: uid);
      debugPrint(
          'response ======================================> ${response.data['body']}');
      return GetPendingOrdersResponse.fromJson(response.data);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  //Getting Completed Orders
  Future<dynamic> getCompletedOrders(String driverId) async {
    Map uid = {
      "driverId": driverId,
    };
    try {
      final response = await _apiServices.getApiService(
          url: EndPoints.deliveredOrders, data: uid);
      debugPrint(
          'response ======================================> ${response.data['body']}');
      return GetCompletedOrdersResponse.fromJson(response.data);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  //Marking Order as delivered
  Future<dynamic> deliverOrder(Map<String, dynamic> order) async {
    try {
      final response = await _apiServices.putApiService(
          url: EndPoints.deliverOrder, data: order);
      debugPrint(
          'response ======================================> ${response.data['body']}');
      return DeliverOrderResponse.fromJson(response.data);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  //Getting Notifications
  Future<dynamic> getNotifications() async {
    try {
      final response =
          await _apiServices.getApiService(url: EndPoints.getAllNotifications);
      debugPrint(
          'response ======================================> ${response.data['body']}');
      return NotificationsResponse.fromJson(response.data);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  //Getting Notifications Count
  Future<dynamic> getUnreadNotificationsCount() async {
    try {
      final response = await _apiServices.getApiService(
          url: EndPoints.getUnreadNotificationCount);
      debugPrint(
          'response ======================================> ${response.data['body']}');
      return GetNotificationCountResponse.fromJson(response.data);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  //Updating Notifications Count
  Future<dynamic> updateNotificationsCount() async {
    Map<String, dynamic> data = {"read_status": 1};
    try {
      final response = await _apiServices.patchApiService(
          url: EndPoints.markNotificationAsRead, data: data);
      debugPrint(
          'response ======================================> ${response.data['body']}');
      return CountUpdateResponse.fromJson(response.data);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
