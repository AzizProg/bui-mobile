import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:test_mobile/src/features/dashboard/core/domain/entities/transaction_entity.dart';
import 'package:test_mobile/src/features/details_transaction/core/domain/ports/details_transaction_repository.dart';
import 'package:test_mobile/src/features/details_transaction/infrastructure/data_source/details_transaction_remote_data_source.dart';
import 'package:test_mobile/src/shared/constants/response_code.dart';
import 'package:test_mobile/src/shared/constants/response_message.dart';
import 'package:test_mobile/src/shared/errors/error_handler.dart';
import 'package:test_mobile/src/shared/errors/failure.dart';
import 'package:test_mobile/src/shared/network/network_checker.dart';

class DetailsTransactionRepositoryImpl
    implements IDetailsTransactionRepository {
  DetailsTransactionRepositoryImpl(
      {required this.remoteDataSource, required this.networkChecker});
  final IDetailsTransactionRemoteDataSource remoteDataSource;
  final NetworkChecker networkChecker;
  @override
  Future<GetTransactionByIdResponse> getTransactionById(int id) async {
    if (await networkChecker.isConnected) {
      try {
        final res = await remoteDataSource.getTransactionById(id);
        return Right(res.toEntity());
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(Failure(message: ResponseMessage.NO_CONNECTION));
    }
  }

  @override
  Future<UpdateTransactionByIdResponse> updateTransactionById(
      int id, String description) async {
    if (await networkChecker.isConnected) {
      try {
        await remoteDataSource.updateTransactionById(id, description);

        return Right(ResponseCode.SUCCESS);
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(Failure(message: ResponseMessage.NO_CONNECTION));
    }
  }
}
