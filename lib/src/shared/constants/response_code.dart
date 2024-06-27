import 'dart:io';

class ResponseCode {
  ResponseCode._();
  static const int CREATED = 201; // user created
  static const int SUCCESS = 200; // login success
  static const int CONFLICT = 409; // user exist
  static const int NOT_FOUND = 404; // user not found or transaction not found
  static const int BAD_REQUEST = 400; // incorrect password
  static const int NOT_AUTHORIZED = 401; // token expired
  static const int SERVER_INTERNAL_ERROR = 500; // server error
}
