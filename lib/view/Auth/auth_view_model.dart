import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/enums/status.dart';
import '../../core/others/base_view_model.dart';
import '../../core/utils/general_utils.dart';
import '../Home/bottom_navigation_bar.dart';
import 'Otp Verification/otp_verification_screen.dart';

class AuthViewModel extends BaseViewModel {
  //////////////////////////Sign In and OTP//////////////////////////
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

      setState(ViewState.idle);
      Get.offAll(() => CustomBottomNavigationBar(pageIndex: 0));
    } catch (e) {
      setState(ViewState.idle);

      Utils.flushbarMessage('Error verifying SMS code: $e', context);
    }
  }
}
