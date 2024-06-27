class ResponseMessage{
  ResponseMessage._();

  static String get  SUCCESS => 'Success';
  static String get  USER_CREATED => 'User has been created';

  static String get USER_EXIST => 'User exist';
  static String get USER_NOT_FOUND => 'User not found';
  static String get INCORRECT_PASSWORD => 'Incorrect password';
  static String get TOKEN_EXPIRE => 'Access token expire or not available';
  static String get  TRANSACTION_NOT_FOUND => 'Transaction not found';

  static String get  NO_CONNECTION => 'Please enable your connection';
  static String get  CONNECTION_TIMEOUT => 'Server not available';

  static String get  RECEIVE_TIMEOUT_OR_SEND_TIMEOUT => 'Check your connection and try again please';
  static String get  SERVER_ERROR => 'Server error';

  static String get  DEFAULT => 'Unknown error';
}