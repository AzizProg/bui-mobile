import 'package:dio/dio.dart';

import 'package:test_mobile/src/shared/constants/api_constants.dart';
import 'package:test_mobile/src/shared/constants/response_code.dart';
import 'package:test_mobile/src/shared/constants/response_message.dart';

import 'failure.dart';

class ErrorHandler {
  late Failure failure;

  ErrorHandler.handle(dynamic error) {
    if (error is DioException) {
      failure = _handleDioException(error);
    } else {
      failure = Failure(message: ResponseMessage.DEFAULT);
    }
  }

  Failure _handleDioException(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return Failure(message: ResponseMessage.CONNECTION_TIMEOUT);
      case DioExceptionType.receiveTimeout || DioExceptionType.sendTimeout:
        return Failure(
            message: ResponseMessage.RECEIVE_TIMEOUT_OR_SEND_TIMEOUT);

      case DioExceptionType.badResponse:
        return _handleResponseException(dioException);

      default:
        return Failure(
            message: ResponseMessage.SERVER_ERROR,
            code: ResponseCode.SERVER_INTERNAL_ERROR);
        ;
    }
  }

  Failure _handleResponseException(DioException dioException) {
    try {
      switch (dioException.response?.statusCode!) {
        case ResponseCode.NOT_FOUND:
          if (dioException.requestOptions.path
              .contains(ApiConstants.loginEndpoint))
            return Failure(
                message: ResponseMessage.USER_NOT_FOUND,
                code: ResponseCode.NOT_FOUND);
          else
            return Failure(
                message: ResponseMessage.TRANSACTION_NOT_FOUND,
                code: ResponseCode.NOT_FOUND);
        case ResponseCode.BAD_REQUEST:
          return Failure(
              message: ResponseMessage.INCORRECT_PASSWORD,
              code: ResponseCode.BAD_REQUEST);
        case ResponseCode.NOT_AUTHORIZED:
          return Failure(
              message: ResponseMessage.TOKEN_EXPIRE,
              code: ResponseCode.NOT_AUTHORIZED);
        case ResponseCode.CONFLICT:
          return Failure(
              message: ResponseMessage.USER_EXIST, code: ResponseCode.CONFLICT);

        default:
          return Failure(message: ResponseMessage.DEFAULT);
      }
    } catch (e) {
      return Failure(message: ResponseMessage.DEFAULT);
      ;
    }
  }
}
