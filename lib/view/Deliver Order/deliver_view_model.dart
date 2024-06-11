import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../core/others/base_view_model.dart';
import '../../core/utils/general_utils.dart';

class DeliverViewModel extends BaseViewModel {
  //////////////////////////Google Maps Location//////////////////////////
  ///Following is the code for getting user's location as Lat and Lng as well as Address
  TextEditingController searchController = TextEditingController();
  GoogleMapController? mapController;

  double _lat = 0;
  double _lng = 0;
  double get lat => _lat;
  double get lng => _lng;

  AuthViewModel() {
    init();
  }

  init() async {
    await getCurrentPosition();
  }

  /// Setting Latitude and Longitude
  Future<void> setLatLng(double lat, double lng) async {
    _lat = lat;
    _lng = lng;
    await getAddressFromOnlyLatLng(_lat, _lng);
    log(lat.toString());
    log(lng.toString());

    notifyListeners();
  }

  ///Updated location on Google Map
  void updateLocation(double lat, double lng) {
    _lat = lat;
    _lng = lng;

    mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(_lat, _lng),
          zoom: 14,
        ),
      ),
    );
    notifyListeners();
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Position? _currentPosition;
  List<Placemark> placemarks = [];

  String? _currentAddress;
  Position get currentPosition => _currentPosition!;
  String get currentAddress => _currentAddress!;

  /// Function for Location Permission
  Future<bool> _handleLocationPermission() async {
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

  ///Function for getting users location
  Future<void> getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      _currentPosition = position;
      log(_currentPosition!.latitude.toString());
      log(_currentPosition!.longitude.toString());
      await getAddressFromPositionObject(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
      log(e.toString());
      notifyListeners();
    });
    notifyListeners();
  }

  ///Function for Getting Address from Position Object
  Future<void> getAddressFromPositionObject(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((placemarks) {
      Placemark place = placemarks[0];
      _currentAddress =
          '${place.street}, ${place.subLocality},${place.subAdministrativeArea}, ${place.postalCode}';
      debugPrint(_currentAddress);
      searchController.text = _currentAddress ?? '';
      // userModel.latitude = _currentPosition!.latitude;
      // userModel.longitude = _currentPosition!.longitude;
      // userModel.location = _currentAddress;
      log('this is lat ${_currentPosition!.latitude} and lng ${_currentPosition!.longitude}');
      log(_currentAddress!);
      if (searchController.text.isNotEmpty) {
        updateLocation(_currentPosition!.latitude, _currentPosition!.longitude);
      }
      notifyListeners();
    }).onError((error, stackTrace) {
      log(error.toString());
    });
  }

  ///Function for Getting Address from only lat lng
  Future<void> getAddressFromOnlyLatLng(double lat, double lng) async {
    await placemarkFromCoordinates(lat, lng).then((placemarks) {
      Placemark place = placemarks[0];
      _currentAddress =
          '${place.street}, ${place.subLocality},${place.subAdministrativeArea}, ${place.postalCode}';
      debugPrint(_currentAddress);
      log('this is lat $lat and lng $lng');
      log(_currentAddress!);
      // userModel.latitude = lat;
      // userModel.longitude = lng;
      // userModel.location = _currentAddress;
      searchController.text = _currentAddress ?? '';

      notifyListeners();
    }).onError((error, stackTrace) {
      log(error.toString());
    });
  }
}
