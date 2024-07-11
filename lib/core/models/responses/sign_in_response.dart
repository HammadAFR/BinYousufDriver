import '../models/user_model.dart';
import 'base_response/base_response.dart';

class AuthResponse extends BaseResponse {
  UserModel? userProfile;
  String? accessToken;

  ///Default Constructor
  AuthResponse(success, {error}) : super(success, error: error);

  ///Named Constructor
  AuthResponse.fromJson(json) : super.fromJson(json) {
    if (json['body'] != null) {
      accessToken = json['body']['token'];
      if (json['body']['user'] != null) {
        userProfile = UserModel.fromJson(json['body']['user']);
      }
    }
  }
}
