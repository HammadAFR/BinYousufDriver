import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../../core/enums/status.dart';
import '../../core/models/responses/get_unread_notifications_count.dart';
import '../../core/models/responses/sign_in_response.dart';
import '../../core/others/base_view_model.dart';
import '../../core/services/database_services.dart';
import '../../core/services/local_storage_services.dart';
import '../../core/utils/general_utils.dart';
import '../../core/utils/locator.dart';
import '../Home/bottom_navigation_bar.dart';
import '../splash_screen.dart';
import 'Otp Verification/otp_verification_screen.dart';

class AuthViewModel extends BaseViewModel {
  //////////////////////////OTP Verification//////////////////////////
  TextEditingController phoneNumberContoller = TextEditingController();
  String _verificationId = '';
  String otp = '';
  final _auth = FirebaseAuth.instance;

  ///Function for Otp verification

  Future<void> verifyPhoneNumber(
      String phoneNumber, bool resend, BuildContext context) async {
    setState(ViewState.busy);
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        setState(ViewState.idle);

        Utils.flushbarMessage('Verification Successful $phoneNumber', context);
      },
      verificationFailed: (FirebaseAuthException e) {
        setState(ViewState.idle);

        Utils.flushbarMessage('Verification failed: ${e.message}', context);
      },
      codeSent: (String verificationId, int? resendToken) {
        _verificationId = verificationId;
        setState(ViewState.idle);
        Get.to(
          () => OtpVerificationScreen(
            number: phoneNumber,
          ),
        );

        Utils.successflushbarMessage('Verification code sent', context);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        if (resend != true) setState(ViewState.idle);
        _verificationId = verificationId;
      },
      timeout: const Duration(seconds: 60),
    );
  }

  ///Function for recieving sms code

  Future<void> submitSmsCode(String smsCode, BuildContext context) async {
    setState(ViewState.busy);
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: smsCode,
      );

      bool userSignedIn = await signIn();

      if (userSignedIn) {
        phoneNumberContoller.clear();

        Get.offAll(() => CustomBottomNavigationBar(pageIndex: 0));
      } else {
        Utils.flushbarMessage(
            'Ye number kisi driver ke pass nahi hai', context);
      }

      setState(ViewState.idle);
    } catch (e) {
      setState(ViewState.idle);

      Utils.flushbarMessage('Error verifying SMS code: $e', context);
    }
  }

  // Function for Location Permission
  Future<bool> handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Utils.toastMessage('Location Service On Karain');
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

  //////////////////////////Sign In User//////////////////////////
  final _dbService = locator<DatabaseServices>();
  final _localStorageService = locator<LocalStorageService>();
  late AuthResponse _authResponse;

  //Signing In User
  Future<bool> signIn() async {
    log('in sign in function');
    setState(ViewState.busy);

    final String? fcmToken = await _localStorageService.getFcmToken();
    try {
      log('trying api');

      _authResponse = await _dbService.signInApi(
          '0${phoneNumberContoller.text}', fcmToken!);
      if (_authResponse.success) {
        log('success api');

        _localStorageService.saveUser(_authResponse.userProfile!);
        debugPrint(
            'SignIn is successful of user ${_authResponse.userProfile!.mobileNumber}');
        _localStorageService.saveAccessToken(
            accessToken: _authResponse.accessToken!);
        _localStorageService
            .saveUserPhoneNumber(_authResponse.userProfile!.mobileNumber!);
        _localStorageService.saveUserId(_authResponse.userProfile!.userId!);
        await fetchNotificationsCount();

        setState(ViewState.idle);

        return true;
      }
    } catch (e) {
      setState(ViewState.idle);

      debugPrint('error ===============> $e');
      return false;
    }
    return false;
  }

  //////////////////////////Getting New Notification Count from DB//////////////////////////
  late GetNotificationCountResponse _notificationCountResponse;

  Future<void> fetchNotificationsCount() async {
    try {
      _notificationCountResponse =
          await _dbService.getUnreadNotificationsCount();
      if (_notificationCountResponse.success) {
        globalNotificationCountModel =
            _notificationCountResponse.notificationCountModel!;

        debugPrint(
            'the following is the response =============> ${_notificationCountResponse.notificationCountModel}');
      }
    } catch (e) {
      debugPrint(
          'this is the error encountered ==============> ${e.toString()}');
    }
  }
}
