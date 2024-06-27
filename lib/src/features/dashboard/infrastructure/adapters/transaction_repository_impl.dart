import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:test_mobile/src/features/dashboard/core/domain/entities/transaction_entity.dart';
import 'package:test_mobile/src/features/dashboard/core/domain/ports/transaction_repository.dart';
import 'package:test_mobile/src/features/dashboard/infrastructure/data_source/transaction_local_data_source.dart';
import 'package:test_mobile/src/features/dashboard/infrastructure/data_source/transaction_remote_data_source.dart';
import 'package:test_mobile/src/shared/constants/response_message.dart';
import 'package:test_mobile/src/shared/errors/error_handler.dart';
import 'package:test_mobile/src/shared/network/network_checker.dart';

import '../../../../shared/errors/failure.dart';
import '../mappers/transaction_mapper.dart';

class TransactionRepositoryImpl implements ITransactionRepository {
  TransactionRepositoryImpl(
      {required this.localDataSource, required this.remoteDataSource,required this.networkChecker});
  final ITransactionRemoteDataSource remoteDataSource;
  final ITransactionLocalDataSource localDataSource;

  final NetworkChecker networkChecker;

  @override
  Future<Either<Failure, List<TransactionEntity>>> getTransactions() async {
    if(await networkChecker.isConnected){
      try {
        final res = await remoteDataSource.getTransactions();
        print(res);
        List<TransactionMapper> transactionMappers = res
            .map((transaction) => TransactionMapper.fromJson(
            Map<String, dynamic>.from(transaction)))
            .toList();

        await localDataSource.saveTransactions(transactionMappers);

        List<TransactionEntity> transactions =
        transactionMappers.map((mapper) => mapper.toEntity()).toList();

        return Right(transactions);
      }  catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    }else {
      return Left(Failure(message: ResponseMessage.NO_CONNECTION));
    }

  }
}
