import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/enums/status.dart';
import '../../core/models/models/order_model.dart';
import '../../core/models/models/user_model.dart';
import '../../core/models/responses/completed_orders_response.dart';
import '../../core/models/responses/pending_orders_response.dart';
import '../../core/others/base_view_model.dart';
import '../../core/services/database_services.dart';
import '../../core/services/local_storage_services.dart';
import '../../core/utils/general_utils.dart';
import '../../core/utils/locator.dart';

late UserModel globalUserModel;

class HomeScreenViewModel extends BaseViewModel {
  final _dbService = locator<DatabaseServices>();
  final _localStorageService = locator<LocalStorageService>();
  late GetPendingOrdersResponse _pendingOrdersResponse;
  late GetCompletedOrdersResponse _completedOrdersResponse;
  List<OrderModel> _listOfPendingOrders = [];
  List<OrderModel> _listOfCompletedOrders = [];
  List<OrderModel> get listOfPendingOrders => [..._listOfPendingOrders];
  List<OrderModel> get listOfCompletedOrders => [..._listOfCompletedOrders];

  //////////////////////////Refreshing Orders//////////////////////////
  Future<void> refreshOrders() async {
    _listOfPendingOrders.clear();
    _listOfCompletedOrders.clear();
    await getPendingOrders();
    await getCompletedOrders();
    getUser();
  }

  void getUser() async {
    globalUserModel = await _localStorageService.getUser();
  }

  //////////////////////////Getting Pending Orders from DB//////////////////////////
  Future<void> getPendingOrders() async {
    String? uid = await _localStorageService.getUserId();
    setState(ViewState.busy);
    try {
      _pendingOrdersResponse = await _dbService.getPendingOrders(uid!);
      if (_pendingOrdersResponse.success) {
        _listOfPendingOrders = List.from(_pendingOrdersResponse.listOfOrders);
        setState(ViewState.idle);

        debugPrint(
            'the following is the response =============> ${_pendingOrdersResponse.listOfOrders}...total ===> ${_pendingOrdersResponse.listOfOrders.length}');
      }
    } catch (e) {
      setState(ViewState.idle);
      debugPrint(
          'this is the error encountered ==============> ${e.toString()}');
    }
  }

  //////////////////////////Getting Pending Orders from DB//////////////////////////
  Future<void> getCompletedOrders() async {
    String? uid = await _localStorageService.getUserId();
    setState(ViewState.busy);
    try {
      _completedOrdersResponse = await _dbService.getCompletedOrders(uid!);
      if (_completedOrdersResponse.success) {
        _listOfCompletedOrders =
            List.from(_completedOrdersResponse.listOfOrders);
        setState(ViewState.idle);

        debugPrint(
            'the following is the response =============> ${_completedOrdersResponse.listOfOrders}...total ===> ${_completedOrdersResponse.listOfOrders.length}');
      }
    } catch (e) {
      setState(ViewState.idle);
      debugPrint(
          'this is the error encountered ==============> ${e.toString()}');
    }
  }

  //////////////////////////Function for Location Permission//////////////////////////
  Future<bool> handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Utils.toastMessage('Location Service on karain');
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Utils.toastMessage('Location Permission nahi di gai');
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      Utils.toastMessage(
          'Location permissions are permanently denied, we cannot request permissions.');
      return false;
    }
    return true;
  }

  //////////////////////////Redirecting to WhatsApp//////////////////////////
  openWhatsapp(BuildContext context) async {
    String message = "Aoa.";
    String mobileNumber = "+923000202606";

    try {
      await launchUrl(
          Uri.parse("whatsapp://send?phone=$mobileNumber&text=$message"));
    } catch (e) {
      Utils.flushbarMessage('Could Not Open Whatsapp', context);
    }
  }
}
