import 'dart:async';

import 'package:hive/hive.dart';
import 'package:test_mobile/src/features/auth/infrastructure/mappers/user_mapper.dart';
import 'package:test_mobile/src/shared/storage/hive_storage.dart';

import '../../../dashboard/infrastructure/mappers/transaction_mapper.dart';
import '../../core/domain/entities/user.dart';

abstract class IAuthLocalDataSource {

  Future<UserMapper> saveToken(String token);
  Future<void> saveUserData(UserMapper user);
  Future<UserEntity?> get getUserData;
  Future<bool> get verifyToken;
  Future<void> get deleteSession;
  Future<void> saveTransaction(List<TransactionMapper> transactions);
}

class AuthLocalDataSourceImpl implements IAuthLocalDataSource {
  AuthLocalDataSourceImpl();

  @override
  Future<void> saveUserData(UserMapper user) async {
    await HiveStorage.storeUserData(user);
  }

  @override
  Future<UserMapper> saveToken(String token) async {
    return await HiveStorage.storeToken(token);
  }

  @override
  Future<void> saveTransaction(List<TransactionMapper> transactions) async {
   await HiveStorage.storeTransactions(transactions);
  }

  @override
  Future<void> get deleteSession async{
    await HiveStorage.clearAllBox();
  }


  @override
  Future<UserEntity?> get  getUserData async {
    return await HiveStorage.loadUserData();
  }

  @override
  Future<bool> get verifyToken async{
 return await HiveStorage.isTokenExpired();
  }
}
