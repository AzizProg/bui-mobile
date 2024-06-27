import 'package:flutter/cupertino.dart';

class ApiConstants{
  ApiConstants._();

  static String baseUrl="10.0.2.2:3001/api/v1";// It's emulator
  static String signUpEndpoint="/customers/signup";
  static String loginEndpoint="/customers/login";
  static String getTransactionsEndpoint="/transactions";

}