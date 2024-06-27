import 'package:dartz/dartz.dart';
import 'package:test_mobile/src/features/dashboard/core/domain/entities/transaction_entity.dart';
import 'package:test_mobile/src/features/dashboard/core/domain/ports/transaction_repository.dart';

import '../../../../../shared/errors/failure.dart';

class GetTransactionsUsecase {
  GetTransactionsUsecase({required this.transactionRepository});
  ITransactionRepository transactionRepository;

  Future<GetTransactionsResponse> call() async {
    return  await transactionRepository.getTransactions();
  }
}