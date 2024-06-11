import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  // static const String _userKey = 'user';
  // static const String _userIdKey = 'userId';
  static const String _tokenKey = 'accessToken';
  static const String _onboardingKey = 'onboarding';
  // static const String _userPhoneNumber = 'userPhoneNumber';

  Future<void> saveAccessToken({required String accessToken}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, accessToken);
    debugPrint('access Token ==============================> $accessToken');
  }

  Future<String?> getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  saveOnboardingPageCount(int count) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_onboardingKey, count);
  }

  getOnboardingPageCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final onboardingPageCount = prefs.getInt(_onboardingKey);
    return onboardingPageCount ?? 0;
  }
}
