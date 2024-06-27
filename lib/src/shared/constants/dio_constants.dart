import 'package:dio/dio.dart';
import 'package:test_mobile/src/shared/constants/api_constants.dart';

class DioConstants {
  DioConstants._();
  static BaseOptions get dioDefaultOptions => BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 3),
      );
}
