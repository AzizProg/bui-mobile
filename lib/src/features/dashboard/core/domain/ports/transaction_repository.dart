
import 'package:dartz/dartz.dart';

import '../../../../../shared/errors/failure.dart';
import '../entities/transaction_entity.dart';

typedef GetTransactionsResponse= Either<Failure,List<TransactionEntity>>;

abstract class ITransactionRepository<T> {
  Future<GetTransactionsResponse> getTransactions();
}
