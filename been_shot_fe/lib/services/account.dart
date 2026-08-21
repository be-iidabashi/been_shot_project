import 'package:dio/dio.dart';

import '../models/login_user.dart';
import '../models/signup_user.dart';
import '../repositories/secure_storage.dart';
import '../services/dio.dart';

class AccountService {
  static const _protocol =
      String.fromEnvironment('PROTOCOL', defaultValue: 'http');
  static const _domain =
      String.fromEnvironment('DOMAIN', defaultValue: 'localhost:8000');
  static String baseUrl = '$_protocol://$_domain/api/auth';

  Future<void> login({
    required LoginUser loginUser,
  }) async {
    final dioClient = DioClient();
    final url = '$baseUrl/token/';
    final response = await dioClient.unauthDio.post(
      url,
      data: loginUser.toJson(),
    );     

    final accessToken = response.data['access'] as String;
    final refreshToken = response.data['refresh'] as String;
    final secureStorage = SecureStorage();
    await secureStorage.saveToken('access', accessToken);
    await secureStorage.saveToken('refresh', refreshToken);

    await dioClient.unauthDio.post(
      url,
      data: loginUser.toJson(),
    );
  }

  Future<void> signup({
    required SignupUser signupUser,
  }) async {
    final dioClient = DioClient();
    final url = '$baseUrl/users/';
    await dioClient.unauthDio.post(
      url,
      data: signupUser.toJson(),
    );
  }

  Future<String?> refreshAccessToken(String refreshToken) async {
    final dioClient = DioClient();
    final url = '$baseUrl/token/refresh/';
    final response =
        await dioClient.unauthDio.post(url, data: {'refresh': refreshToken});

    if (response.statusCode == 200) {
      final newAccessToken = response.data['access'];
      final secureStorage = SecureStorage();
      await secureStorage.saveToken(
        'access',
        newAccessToken,
      );
      return newAccessToken;
    } else {
      throw Exception('アクセストークンの更新に失敗しました');
    }
  }

  Future<bool> verify() async {
    final dioClient = DioClient();
    final url = '$baseUrl/token/verify/';
    final secureStorage = SecureStorage();
    final accessToken = await secureStorage.getToken('access');
    if (accessToken?.isEmpty ?? true) return false;
    try {
      final response =
          await dioClient.unauthDio.post(url, data: {'token': accessToken});
      if (response.statusCode == 200) {
        return true;
      }
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      if (statusCode == 401) {
        final refreshToken = await secureStorage.getToken('refresh');
        if (refreshToken == null) return false;

        final newAccessToken = await refreshAccessToken(refreshToken);
        final response = await dioClient.unauthDio
            .post(url, data: {'token': newAccessToken});
        if (response.statusCode == 200) {
          return true;
        }
      }
    }
    return false;
  }
}