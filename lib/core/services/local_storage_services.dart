import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/models/user_model.dart';

class LocalStorageService {
  static const String _userKey = 'user';
  static const String _userIdKey = 'userId';
  static const String _tokenKey = 'accessToken';
  static const String _onboardingKey = 'onboarding';
  static const String _userPhoneNumber = 'userPhoneNumber';
  static const String _userFcmToken = 'userFcmToken';

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

  // Save user data
  Future<void> saveUser(UserModel user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String userJson = jsonEncode(user.toJson());
    await prefs.setString(_userKey, userJson);
  }

  // Retrieve user data
  getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString(_userKey);

    if (userJson != null) {
      Map<String, dynamic> userMap = jsonDecode(userJson);
      return UserModel.fromJson(userMap);
    }
    // return null;
  }

  // Remove user data
  Future<void> removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
  }

  // Save user phone number
  Future<void> saveUserPhoneNumber(String userPhoneNumber) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userPhoneNumber, userPhoneNumber);
    debugPrint('Phone Number ==============================> $userPhoneNumber');
  }

  // Retrieve user phone number from SharedPreferences
  Future<String?> getUserPhoneNumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userPhoneNumber);
  }

  // Save user ID to SharedPreferences
  Future<void> saveUserId(String userId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userIdKey, userId);
  }

  // Retrieve user ID from SharedPreferences
  Future<String?> getUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userIdKey);
  }

  Future<void> saveFcmToken({required String fcmToken}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userFcmToken, fcmToken);
    debugPrint('FCM Token ==============================> $fcmToken');
  }

  Future<String?> getFcmToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userFcmToken);
  }
}
