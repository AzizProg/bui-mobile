import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:test_mobile/src/injection_container.dart';

class LoggerDioInterceptor extends Interceptor {
  final Logger log = getIt<Logger>();
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log.i('''
================================== REQUEST :: ==========================================
///////
/// method : ${options.method}
/// url : ${options.uri}
/// headers : ${options.headers}
/// body : ${options.data}
//////////////////////////////////////////////////////////////////////////////////////''');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log.i('''
================================== RESPONSE :: ==========================================
///////
/// status code : ${response.statusCode}
/// status message : ${response.statusMessage}
/// data : ${response.data}
//////////////////////////////////////////////////////////////////////////////////////''');

    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    log.e('''
================================== ERROR :: ==========================================
///////
/// error type : ${err.type}
/// error message : ${err.message}
/// stackTrace : ${err.stackTrace}
//////////////////////////////////////////////////////////////////////////////////////''',
        error: "DIO EXCEPTION");
    super.onError(err, handler);
  }
}
