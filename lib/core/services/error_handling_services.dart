import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ErrorHandler {
  static void handleError(DioException error) {
    String errorMessage = '';

    switch (error.type) {
      case DioException.connectionTimeout:
        errorMessage = 'Connection Timeout';
        break;
      case DioException.sendTimeout:
        errorMessage = 'Send Timeout';
        break;
      case DioException.receiveTimeout:
        errorMessage = 'Receive Timeout';
        break;
      case DioException.badResponse:
        errorMessage =
            'Received invalid status code: ${error.response?.statusCode}';
        break;
      case DioException.requestCancelled:
        errorMessage = 'Request to API server was cancelled';
        break;
      default:
        errorMessage = 'Unexpected Error';
        break;
    }

    Get.defaultDialog(
      title: 'Error',
      middleText: errorMessage,
      textConfirm: 'Ok',
      onConfirm: () {
        Get.back();
      },
    );
    debugPrint('Error: $errorMessage');
  }

  static void handleGenericError(dynamic error) {
    String errorMessage = 'An unexpected error occurred';

    Get.defaultDialog(
      title: 'Error',
      middleText: errorMessage,
      textConfirm: 'OK',
      onConfirm: () {
        Get.back();
      },
    );
    debugPrint('Unexpected Error: $error');
  }
}
