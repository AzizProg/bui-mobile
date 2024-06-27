import 'package:dio/dio.dart';
import 'package:test_mobile/src/features/auth/interface/bloc/auth_bloc.dart';
import 'package:test_mobile/src/features/profil/interface/blocs/profile_bloc.dart';
import 'package:test_mobile/src/injection_container.dart';
import 'package:test_mobile/src/shared/constants/api_constants.dart';
import 'package:test_mobile/src/shared/constants/response_code.dart';
import 'package:test_mobile/src/shared/routes/app_router.dart';
import 'package:test_mobile/src/shared/routes/app_router.gr.dart';
import 'package:test_mobile/src/shared/storage/hive_storage.dart';

class AuthDioInterceptors extends Interceptor {
  var token;

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.path.contains(ApiConstants.loginEndpoint) ||
        options.path.contains(ApiConstants.signUpEndpoint)) {
      options.headers.addAll({
        "Content-Type": "application/json",
      });
    } else {
      final isTokenExpired = await HiveStorage.isTokenExpired();

      if (isTokenExpired) {

        handler.reject(DioException(
            requestOptions: RequestOptions(),
            type: DioExceptionType.badResponse,
            response: Response(
                requestOptions: RequestOptions(),
                statusCode: ResponseCode.NOT_AUTHORIZED)));
        getIt<AuthBloc>().add(AuthLogOutEvent());
      } else {
        final token = await HiveStorage.loadToken();
        options.headers.addAll({
          "Authorization": "Bearer ${token}",
        });
      }
    }
    super.onRequest(options, handler);
  }
}
