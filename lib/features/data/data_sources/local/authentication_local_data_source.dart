import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/errors/exceptions.dart';

abstract class AuthenLocalDataSrc {
  Future<void> storeRefreshToken(String refreshToken);
  Future<void> storeAccessToken(String accessToken);
  Future<String> getRefreshToken();
  Future<String> getAccessToken();
  Future<void> deleteRefreshToken();
  Future<void> deleteAccessToken();
}

class AuthenLocalDataSrcImpl implements AuthenLocalDataSrc {
  AuthenLocalDataSrcImpl();

  @override
  Future<String> getAccessToken() async {
    try {
      SharedPreferences client = await SharedPreferences.getInstance();
      String? token = client.getString('accessToken');
      if (token != null) {
        return token;
      } else {
        return "";
      }
    } catch (error) {
      throw SharedPreferencesException(
          message: error.toString(), statusCode: 500);
    }
  }

  @override
  Future<String> getRefreshToken() async {
    try {
      SharedPreferences client = await SharedPreferences.getInstance();
      String? token = client.getString('refreshToken');
      if (token != null) {
        return token;
      } else {
        return "";
      }
    } catch (error) {
      throw SharedPreferencesException(
          message: error.toString(), statusCode: 500);
    }
  }

  @override
  Future<void> storeAccessToken(String accessToken) async {
    try {
      SharedPreferences client = await SharedPreferences.getInstance();
      await client.setString('accessToken', accessToken);
    } catch (error) {
      throw SharedPreferencesException(
          message: error.toString(), statusCode: 500);
    }
  }

  @override
  Future<void> storeRefreshToken(String refreshToken) async {
    try {
      SharedPreferences client = await SharedPreferences.getInstance();
      await client.setString('refreshToken', refreshToken);
    } catch (error) {
      throw SharedPreferencesException(
          message: error.toString(), statusCode: 500);
    }
  }

  @override
  Future<void> deleteAccessToken() async {
    try {
      SharedPreferences client = await SharedPreferences.getInstance();
      await client.remove("accessToken");
    } catch (error) {
      throw SharedPreferencesException(
          message: error.toString(), statusCode: 500);
    }
  }

  @override
  Future<void> deleteRefreshToken() async {
    try {
      SharedPreferences client = await SharedPreferences.getInstance();
      await client.remove("refreshToken");
    } catch (error) {
      throw SharedPreferencesException(
          message: error.toString(), statusCode: 500);
    }
  }
}
