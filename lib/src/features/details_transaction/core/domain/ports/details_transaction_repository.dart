import 'package:dartz/dartz.dart';

import '../../../../../shared/errors/failure.dart';
import '../../../../dashboard/core/domain/entities/transaction_entity.dart';

typedef GetTransactionByIdResponse= Either<Failure,TransactionEntity>;
typedef UpdateTransactionByIdResponse= Either<Failure,int>;

abstract class IDetailsTransactionRepository<T> {
  Future<GetTransactionByIdResponse> getTransactionById(int id);
  Future<UpdateTransactionByIdResponse> updateTransactionById(int id,String description);
}
