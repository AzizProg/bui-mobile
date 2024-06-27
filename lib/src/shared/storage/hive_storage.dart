import 'dart:async';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:test_mobile/src/features/dashboard/core/domain/entities/transaction_entity.dart';
import 'package:test_mobile/src/shared/constants/hive_constants.dart';
import 'package:test_mobile/src/shared/enums/transaction_type.dart';

import '../../features/auth/core/domain/entities/user.dart';
import '../../features/auth/infrastructure/mappers/user_mapper.dart';
import '../../features/dashboard/infrastructure/mappers/transaction_mapper.dart';

class HiveStorage {
  HiveStorage._();

  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(TransactionTypeAdapter());
    Hive.registerAdapter(TransactionEntityAdapter());
    Hive.registerAdapter(UserEntityAdapter());
    await Future.wait([
      getAuthBox(),
      getUserBox(),
      getTransactionsBox(),
    ]);
  }

//==========================init or get hive boxes===================================
  static Future<Box<String>> getAuthBox() async {
    try {
      if (!Hive.isBoxOpen(HiveConstants.authBox)) {
        return Hive.openBox<String>(HiveConstants.authBox);
      }
      return Hive.box(HiveConstants.authBox);
    } catch (e) {
      rethrow;
    }
  }

  static Future<LazyBox<UserEntity>> getUserBox() async {
    try {
      if (!Hive.isBoxOpen(HiveConstants.userBox)) {
        return await Hive.openLazyBox<UserEntity>(HiveConstants.userBox);
      }
      return Hive.lazyBox<UserEntity>(HiveConstants.userBox);
    } catch (e) {
      rethrow;
    }
  }

  static Future<LazyBox> getTransactionsBox() async {
    try {
      if (!Hive.isBoxOpen(HiveConstants.transactionBox)) {
        return await Hive.openLazyBox(HiveConstants.transactionBox);
      }
      return Hive.lazyBox(HiveConstants.transactionBox);
    } catch (e) {
      rethrow;
    }
  }
  //===============================user preferences=============================
//user preferences : theme, languages ,etc....


  //===============================auth box=====================================

  static Future<UserMapper> storeToken(String token) async {
    try {
      final authBox = await getAuthBox();
      await authBox.put(HiveConstants.tokenKey, token);
      final customer =
          JwtDecoder.decode(token)['customer'] as Map<String, dynamic>;
      return UserMapper.fromJson(customer);
    } catch (e) {
      rethrow;
    }
  }

  static Future<String?> loadToken() async {
    try {
      final auth = await getAuthBox();
      final token = auth.get(HiveConstants.tokenKey);
      return token;
    } catch (e) {
      rethrow;
    }
  }

  static FutureOr<bool> isTokenExpired() async {
    try {
      final authBox = await getAuthBox();
      final token = await authBox.get(HiveConstants.tokenKey);
      print("token value:"+token.toString());
      if (token != null) {
        if (JwtDecoder.isExpired(token)) {
          await clearAllBox();
          return true;
        }
        return false;
      }
      return false;
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> deleteToken() async {
    try {
      final authBox = await getAuthBox();
      authBox.delete(HiveConstants.tokenKey);
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> clearAllBox() async {
    try {
      await Future.wait([
        getAuthBox().then((box) => box.clear()),
        getUserBox().then((box) => box.clear()),
        getTransactionsBox().then((box) => box.clear()),
      ]);
    } catch (e) {
      rethrow;
    }
  }

//==============================User box======================================
  static Future<void> storeUserData(UserMapper user) async {
    try {
      final userBox = await getUserBox();
      await userBox.put(HiveConstants.userKey, user);
    } catch (e) {
      rethrow;
    }
  }

  static Future<UserEntity?> loadUserData() async {
    try {
      final userBox = await getUserBox();
      final user = await userBox.get(HiveConstants.userKey);
      if (user != null) return user;
    } catch (e) {
      rethrow;
    }
    return null;
  }

//=====================================transaction box=============================
  static Future<void> storeTransactions(
      List<TransactionMapper> transactions) async {
    try {
      final transactionBox = await getTransactionsBox();
      await transactionBox.put(HiveConstants.transactionsKey,
          transactions.map((transaction) => transaction.toJson()).toList());
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<TransactionEntity>> loadTransactions() async {
    try {
      final transactionBox = await getTransactionsBox();
      final transactions = await transactionBox
          .get(HiveConstants.transactionsKey) as List<dynamic>;
      if (transactions != null) {
        return transactions
            .map((transaction) => TransactionMapper.fromJson(
                    Map<String, dynamic>.from(transaction))
                .toEntity())
            .toList();
      }

      return [];
    } catch (e) {
      rethrow;
    }
  }
}
