import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:test_mobile/src/shared/constants/api_constants.dart';

abstract class IAuthRemoteDataSource {
  FutureOr<String> saveUser(String username, String password);
  Future<String> getUser(String username, String password);
}

class AuthRemoteDataSourceImpl implements IAuthRemoteDataSource {
  AuthRemoteDataSourceImpl({required this.dio});

  final Dio dio;

  @override
  Future<String> getUser(String username, String password) async {
    try {
      final res = await dio.post<String>(
        'http://${ApiConstants.baseUrl}${ApiConstants.loginEndpoint}',
        data: jsonEncode({
          'username': username,
          'password': password,
        }),
      );
      return res.data!;
    } catch (e) {
      rethrow;
    }
  }

  @override
  FutureOr<String> saveUser(String username, String password) async {
    try {
      final res = await dio.post<String>(
        'http://${ApiConstants.baseUrl}${ApiConstants.signUpEndpoint}',
        data: jsonEncode({
          'username': username,
          'password': password,
        }),
      );

      return res.data!;
    } catch (e) {
      rethrow;
    }
  }
}
