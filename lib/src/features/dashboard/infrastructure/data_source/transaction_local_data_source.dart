import 'dart:async';
import 'package:test_mobile/src/features/dashboard/core/domain/entities/transaction_entity.dart';
import 'package:test_mobile/src/features/dashboard/infrastructure/mappers/transaction_mapper.dart';
import 'package:test_mobile/src/shared/storage/hive_storage.dart';

abstract class ITransactionLocalDataSource {
  Future<void> saveTransactions(List<TransactionMapper> transactions);
  Future<List<TransactionEntity>> getTransactions();
}

class TransactionLocalDataSourceImpl implements ITransactionLocalDataSource {
  @override
  Future<List<TransactionEntity>> getTransactions() async {
    final transactions = await HiveStorage.loadTransactions();
    return transactions;
  }

  @override
  Future<void> saveTransactions(List<TransactionMapper> transactions) async {
    await HiveStorage.storeTransactions(transactions);
  }
}
