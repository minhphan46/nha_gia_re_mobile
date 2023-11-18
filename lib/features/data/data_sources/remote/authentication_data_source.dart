import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/utils/typedef.dart';

abstract class AuthenRemoteDataSrc {
  Future<HttpResponse<Map<String, String>>> login(
      String email, String password);
  Future<HttpResponse<void>> signUp(
      String email, String password, String confirmPassword);
  Future<HttpResponse<void>> changePassword(
      String oldPassword, String newPassword, String confirmNewPassword);
  Future<HttpResponse<void>> signOut();
  Future<HttpResponse<void>> signOutAll();
  Future<HttpResponse<void>> activeAccount(
      String email, String password, String code);
  Future<HttpResponse<void>> resendOTP(String email);
  Future<HttpResponse<String>> refreshToken(String refreshToken);
}

class AuthenRemoteDataSrcImpl implements AuthenRemoteDataSrc {
  final Dio client;

  AuthenRemoteDataSrcImpl(this.client);

  @override
  Future<HttpResponse<void>> activeAccount(
      String email, String password, String code) async {
    // TODO: implement activeAccount
    throw UnimplementedError();
  }

  @override
  Future<HttpResponse<void>> changePassword(
      String oldPassword, String newPassword, String confirmNewPassword) async {
    // TODO: implement changePassword
    throw UnimplementedError();
  }

  @override
  Future<HttpResponse<Map<String, String>>> login(
      String email, String password) async {
    const url = '$apiBaseUrl$kSignIn';
    try {
      // Gửi yêu cầu đăng nhập
      print('email: $email, password: $password');
      final response = await client.post(
        url,
        data: {'email': email, 'password': password},
      );
      if (response.statusCode != 200) {
        throw ApiException(
          message: response.data,
          statusCode: response.statusCode!,
        );
      }

      // Nếu yêu cầu thành công, giải mã dữ liệu JSON
      final DataMap data = DataMap.from(response.data["result"]);

      // Lấy AccessToken và RefreshToken từ dữ liệu giải mã
      String accessToken = data['access_token'];
      String refreshToken = data['refresh_token'];

      // Trả về AccessToken và RefreshToken
      Map<String, String> value = {
        'accessToken': accessToken,
        'refreshToken': refreshToken
      };

      return HttpResponse(value, response);
    } on ApiException {
      rethrow;
    } catch (error) {
      throw ApiException(message: error.toString(), statusCode: 505);
    }
  }

  @override
  Future<HttpResponse<String>> refreshToken(String refreshToken) async {
    // TODO: implement refreshToken
    throw UnimplementedError();
  }

  @override
  Future<HttpResponse<void>> resendOTP(String email) async {
    // TODO: implement resendOTP
    throw UnimplementedError();
  }

  @override
  Future<HttpResponse<void>> signOut() async {
    // TODO: implement signOut
    throw UnimplementedError();
  }

  @override
  Future<HttpResponse<void>> signOutAll() async {
    // TODO: implement signOutAll
    throw UnimplementedError();
  }

  @override
  Future<HttpResponse<void>> signUp(
      String email, String password, String confirmPassword) async {
    // TODO: implement signUp
    throw UnimplementedError();
  }
}
