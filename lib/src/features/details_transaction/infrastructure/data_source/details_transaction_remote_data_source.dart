import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../shared/constants/api_constants.dart';
import '../../../dashboard/infrastructure/data_source/transaction_remote_data_source.dart';
import '../../../dashboard/infrastructure/mappers/transaction_mapper.dart';


abstract class IDetailsTransactionRemoteDataSource {
  Future<TransactionMapper> getTransactionById(int id);
  Future updateTransactionById(int id, String description);
}

class DetailsTransactionRemoteDataSourceImpl
    implements IDetailsTransactionRemoteDataSource {
  DetailsTransactionRemoteDataSourceImpl({required this.dio});
  final Dio dio;
  @override
  Future<TransactionMapper> getTransactionById(int id) async {
    try {
      var res = await dio.get(
        'http://${ApiConstants.baseUrl}${ApiConstants.getTransactionsEndpoint}/$id',
      );

      return TransactionMapper.fromJson(res.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future updateTransactionById(int id, String description) async {
    try {
      await dio.put(
        'http://${ApiConstants.baseUrl}${ApiConstants.getTransactionsEndpoint}/$id',
        data: jsonEncode({
          'description': description,
        }),
      );
    } catch (e) {
      rethrow;
    }
  }
}
