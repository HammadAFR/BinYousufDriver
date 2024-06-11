abstract class BaseApiServices {
  Future<dynamic> getApiService({required String url, data});

  Future<dynamic> postApiService({required String url, data});

  Future<dynamic> deleteApiService({required String url, data});

  Future<dynamic> putApiService({required String url, data});

  Future<dynamic> patchApiService({required String url, data});
}
