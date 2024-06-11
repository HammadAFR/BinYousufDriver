import 'package:dio/dio.dart';
import '../utils/locator.dart';
import 'base services/base_api_services.dart';
import 'error_handling_services.dart';
import 'local_storage_services.dart';

class ApiServices extends BaseApiServices {
  Future<Dio> launchDio() async {
    String? accessToken = await locator<LocalStorageService>().getAccessToken();
    Dio dio = Dio();
    dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
    dio.options.headers['Content-Type'] = 'application/json';
    dio.options.headers["accept"] = 'application/json';
    dio.options.headers["Authorization"] = '$accessToken';

    dio.options.followRedirects = false;
    dio.options.validateStatus = (val) {
      if (val != null) {
        return val < 500;
      } else {
        return false;
      }
    };
    return dio;
  }

  /////Get Api
  @override
  Future getApiService({required String url, data}) async {
    Dio dio = await launchDio();
    try {
      final response = await dio.get(url, data: data);
      return response;
    } on DioException catch (e) {
      ErrorHandler.handleError(e);
      return null;
    } catch (e) {
      ErrorHandler.handleGenericError(e);
      return null;
    }
  }

  ///Post Api
  @override
  Future postApiService({required String url, data}) async {
    Dio dio = await launchDio();
    try {
      final response = await dio.post(url, data: data);
      return response;
    } on DioException catch (e) {
      ErrorHandler.handleError(e);
      return null;
    } catch (e) {
      ErrorHandler.handleGenericError(e);
      return null;
    }
  }

  ///Delete Api
  @override
  Future deleteApiService({required String url, data}) async {
    Dio dio = await launchDio();
    try {
      final response = await dio.delete(url, queryParameters: data);
      return response;
    } on DioException catch (e) {
      ErrorHandler.handleError(e);
      return null;
    } catch (e) {
      ErrorHandler.handleGenericError(e);
      return null;
    }
  }

  ///Put Api
  @override
  Future putApiService({required String url, data}) async {
    Dio dio = await launchDio();
    try {
      final response = await dio.put(url, data: data);
      return response;
    } on DioException catch (e) {
      ErrorHandler.handleError(e);
      return null;
    } catch (e) {
      ErrorHandler.handleGenericError(e);
      return null;
    }
  }

  ///Patch Api
  @override
  Future patchApiService({required String url, data}) async {
    Dio dio = await launchDio();
    try {
      final response = await dio.patch(url, data: data);
      return response;
    } on DioException catch (e) {
      ErrorHandler.handleError(e);
      return null;
    } catch (e) {
      ErrorHandler.handleGenericError(e);
      return null;
    }
  }
}
