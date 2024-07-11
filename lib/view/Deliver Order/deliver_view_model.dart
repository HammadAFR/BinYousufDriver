import 'dart:developer';

import 'package:bin_yousuf_driver/core/constants/colors.dart';
import 'package:bin_yousuf_driver/core/enums/status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/models/models/deliver_order_model.dart';
import '../../core/models/responses/deliver_order_response.dart';
import '../../core/others/base_view_model.dart';
import '../../core/services/database_services.dart';
import '../../core/services/local_storage_services.dart';
import '../../core/utils/general_utils.dart';
import '../../core/utils/locator.dart';
import '../Delivery Success/delivery_success_screen.dart';
// import '../../core/utils/general_utils.dart';

class DeliverViewModel extends BaseViewModel {
  DeliverViewModel() {
    init();
  }

  init() async {
    await getCurrentPosition();
  }

  //////////////////////////Google Maps Location//////////////////////////
  GoogleMapController? mapController;
  Set<Marker> markers = {};
  double _lat = 0;
  double _lng = 0;
  double get lat => _lat;
  double get lng => _lng;
  late double _destinationLat;
  late double _destinationLng;
  double get destinationLat => _destinationLat;
  double get destinationLng => _destinationLng;
  Position? _currentPosition;
  Position get currentPosition => _currentPosition!;
  String? _currentAddress;
  String get currentAddress => _currentAddress!;
  String? _destinationAddress;
  String get destinationAddress => _destinationAddress!;
  List<Placemark> placemarks = [];
  late PolylinePoints polylinePoints;
  List<LatLng> polylineCoordinates = [];
  Map<PolylineId, Polyline> polylines = {};

  ///Following is the code for getting user's location as Lat and Lng as well as Address

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  //Setting destination lat and lng
  void setDestinationLatLng(double lat, double lng) {
    _destinationLat = lat;
    _destinationLng = lng;
    log('this is the destination lat and lng ==================> $_destinationLat & $_destinationLng');
  }

  //Function for getting drivers location
  Future<void> getCurrentPosition() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then(
      (Position position) async {
        _currentPosition = position;
        /////////////////////////hard coded location, have to change it later/////////////////
        updateLocation(33.9987, 71.4219);
        await getAddressFromPositionObject(_currentPosition!);
        await getAddressFromOnlyLatLng(_destinationLat, _destinationLng);
        // log('Delivery from $_currentAddress to $_destinationAddress');
        setMarkers();
        await createPolylines(_lat, _lng, _destinationLat, _destinationLng);
      },
    ).catchError(
      (e) {
        debugPrint(e);
        log(e.toString());
        notifyListeners();
      },
    );
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
      debugPrint(
          'this is current address ==================> $_currentAddress');

      notifyListeners();
    }).onError((error, stackTrace) {
      log(error.toString());
    });
  }

  ///Function for Getting Address from only lat lng
  Future<void> getAddressFromOnlyLatLng(double lat, double lng) async {
    await placemarkFromCoordinates(lat, lng).then((placemarks) {
      Placemark place = placemarks[0];
      _destinationAddress = ' ${place.street}, ${place.locality}';
      debugPrint(
          'this is current destination address =========================>$_destinationAddress');

      notifyListeners();
    }).onError((error, stackTrace) {
      log(error.toString());
    });
  }

  //Updated location on Google Map
  void updateLocation(double lat, double lng) {
    _lat = lat;
    _lng = lng;

    mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(lat, lng),
          zoom: 14,
        ),
      ),
    );
    notifyListeners();
  }

  //Setting Current Location and Destination markers
  void setMarkers() {
    // Start Location Marker
    Marker startMarker = Marker(
      markerId: const MarkerId('Current Location'),
      position: LatLng(_lat, _lng),
      infoWindow: InfoWindow(
        title: 'Current Address',
        snippet: _currentAddress,
      ),
      icon: BitmapDescriptor.defaultMarker,
    );

    // Destination Location Marker
    Marker destinationMarker = Marker(
      markerId: const MarkerId('Destination Address'),
      position: LatLng(_destinationLat, _destinationLng),
      infoWindow: InfoWindow(
        title: 'Destination Address',
        snippet: _destinationAddress,
      ),
      icon: BitmapDescriptor.defaultMarker,
    );

    markers.add(startMarker);
    markers.add(destinationMarker);

    // Calculating to check that the position relative
    // to the frame, and pan & zoom the camera accordingly.
    double miny = (_lat <= _destinationLat) ? _lat : _destinationLat;
    double minx = (_lng <= _destinationLng) ? _lng : _destinationLng;
    double maxy = (_lat >= _destinationLat) ? _lat : _destinationLat;
    double maxx = (_lng >= _destinationLng) ? _lng : _destinationLng;

    LatLng southWest = LatLng(miny, minx);
    LatLng northEast = LatLng(maxy, maxx);

    // Accommodate the two locations within the
    // camera view of the map
    mapController!.animateCamera(
      CameraUpdate.newLatLngBounds(
        LatLngBounds(
          northeast: northEast,
          southwest: southWest,
        ),
        100.0,
      ),
    );
  }

  //Calculating Polylines to show route on Google Maps
  Future<void> createPolylines(double startLatitude, double startLongitude,
      double destinationLatitude, double destinationLongitude) async {
    polylinePoints = PolylinePoints();

    // Generating the list of coordinates to be used for
    // drawing the polylines
    // PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
    //   'AIzaSyDJGa2TGdUMHYkg_Foex8W8ragCYvAfD_I',
    //   PointLatLng(startLatitude, startLongitude),
    //   PointLatLng(destinationLatitude, destinationLongitude),
    //   travelMode: TravelMode.driving,
    // );

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleApiKey: dotenv.env['GOOGLE_MAPS_API_KEY'],
      request: PolylineRequest(
        origin: PointLatLng(startLatitude, startLongitude),
        destination: PointLatLng(destinationLatitude, destinationLongitude),
        mode: TravelMode.driving,
        // wayPoints: [PolylineWayPoint(location: "Sabo, Yaba Lagos Nigeria")],
      ),
    );

    // Adding the coordinates to the list
    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    }

    // Defining an ID
    PolylineId id = const PolylineId('poly');

    // Initializing Polyline
    Polyline polyline = Polyline(
      polylineId: id,
      color: blueColor,
      points: polylineCoordinates,
      width: 3,
    );

    // Adding the polyline to the map
    polylines[id] = polyline;
  }

  //Launching google maps
  void launchMapOnAndroid(
      BuildContext context, double latitude, double longitude) async {
    try {
      const String markerLabel = 'Here';
      final url = Uri.parse(
          'geo:$latitude,$longitude?q=$latitude,$longitude($markerLabel)');
      await launchUrl(url);
    } catch (error) {
      if (context.mounted) {
        Utils.flushbarMessage(error.toString(), context);
      }
    }
  }

  //////////////////////////Deliver Order Api//////////////////////////
  final _localStorageService = locator<LocalStorageService>();
  final _dbService = locator<DatabaseServices>();
  late DeliverOrderModel deliverOrderModel;
  late DeliverOrderResponse _deliverOrderResponse;

  Future<bool> deliverOrder(String orderId) async {
    final String? driverId = await _localStorageService.getUserId();
    Map<String, dynamic> order = {
      'orderId': orderId,
      'driverId': driverId!,
    };
    setState(ViewState.busy);
    try {
      _deliverOrderResponse = await _dbService.deliverOrder(order);
      if (_deliverOrderResponse.success) {
        setState(ViewState.idle);
        Get.offAll(() => const DeliverySuccessScreen());
        deliverOrderModel = _deliverOrderResponse.deliveredOrder!;
      }
    } catch (e) {
      debugPrint('Error message ================> ${e.toString()}');
      setState(ViewState.idle);

      return false;
    }
    return true;
  }
}
