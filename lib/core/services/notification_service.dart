import 'dart:io';
import 'dart:math';

import 'package:bin_yousuf_driver/core/utils/locator.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import '../../view/Notification/notification_controller.dart';
import 'local_storage_services.dart';

class PushNotificationService {
  final NotificationsController _notificationsController =
      Get.put(NotificationsController());
  final _localStorageService = locator<LocalStorageService>();

  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  //////////////////Initialization of local notifications for UI//////////////////
  void initLocalNotifications(
      BuildContext context, RemoteMessage message) async {
    var androidInitializationSettings =
        const AndroidInitializationSettings('@mipmap/bin_yousuf');
    var iosInitializationSettings = const DarwinInitializationSettings();

    var initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (payload) {
      handleNotifications(message);
    });
  }

  //////////////////Initialization of notifications received from firebase//////////////////
  Future initialize(BuildContext context) async {
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) async {
        debugPrint('Got a message whilst in foreground');
        debugPrint('Message data ${message.data}');
        debugPrint(message.notification!.title.toString());
        debugPrint(message.notification!.body.toString());
        debugPrint(message.data['type']);
        debugPrint(message.data['payload']);

        // Increment the unread notifications count
        _notificationsController.incrementUnreadCount();

        if (Platform.isAndroid) {
          initLocalNotifications(context, message);
          showNotification(message);
        } else {
          showNotification(message);
        }
      },
    );
  }

  //////////////////Showing notifications on UI//////////////////
  Future<void> showNotification(RemoteMessage message) async {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
      Random.secure().nextInt(100000).toString(),
      'High Importance Notification',
      importance: Importance.max,
    );

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      channel.id,
      channel.name,
      channelDescription: 'My channel description',
      importance: Importance.high,
      priority: Priority.high,
      ticker: 'ticker',
      icon: '@mipmap/ic_launcher',
    );

    DarwinNotificationDetails darwinNotificationDetails =
        const DarwinNotificationDetails(
            presentAlert: true, presentBadge: true, presentSound: true);

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );

    Future.delayed(Duration.zero, () {
      _flutterLocalNotificationsPlugin.show(
          0,
          message.notification!.title.toString(),
          message.notification!.body.toString(),
          notificationDetails);
    });
  }

  //////////////////Getting notification permission from user//////////////////
  void getPermission() async {
    NotificationSettings settings = await _fcm.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint('Device has been authorized');
    } else {
      debugPrint('Not Authorized');
    }
  }

  //////////////////Getting fcm token//////////////////
  Future<String?> getToken() async {
    String? token = await _fcm.getToken();
    debugPrint('Token: $token');
    return token;
  }

  //////////////////Checking whether the token has been refreshed//////////////////
  void hasTokenRefreshed() {
    _fcm.onTokenRefresh.listen((event) {
      debugPrint('Token has been refreshed ==========> ${event.toString()}');
      _localStorageService.saveFcmToken(fcmToken: event);
    });
  }

  //////////////////Handle Notifications//////////////////
  void handleNotifications(RemoteMessage payload) {
    _notificationsController.resetUnreadCount();
    // Get.to(() => const NotificationScreen());
  }

  //////////////////Handle Notifications when in background or kill mode//////////////////
  Future<void> setupInterectMessage() async {
    ///When App is Terminated
    RemoteMessage? initialMessage = await _fcm.getInitialMessage();

    if (initialMessage != null) {
      handleNotifications(initialMessage);
    }

    ///When app is in Background
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      handleNotifications(event);
    });
  }
}
