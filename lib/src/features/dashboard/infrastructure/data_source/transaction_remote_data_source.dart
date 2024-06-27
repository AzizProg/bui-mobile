import 'dart:async';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:test_mobile/src/features/dashboard/infrastructure/mappers/transaction_mapper.dart';
import 'package:test_mobile/src/shared/constants/api_constants.dart';


abstract class ITransactionRemoteDataSource {
  Future<List> getTransactions();
}

class TransactionRemoteDataSourceImpl implements ITransactionRemoteDataSource {
  TransactionRemoteDataSourceImpl({required this.dio});

  final Dio dio;

  @override
  Future<List> getTransactions() async {
    try {
      var res = await dio.get(
        'http://${ApiConstants.baseUrl}${ApiConstants.getTransactionsEndpoint}',
      );

      return res.data;
    } catch (e) {
      rethrow;
    }
  }
}
