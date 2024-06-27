import 'package:test_mobile/src/features/auth/core/domain/entities/user.dart';
import 'package:test_mobile/src/features/dashboard/core/domain/entities/transaction_entity.dart';

import '../../../dashboard/infrastructure/mappers/transaction_mapper.dart';

class UserMapper extends UserEntity {
  const UserMapper(
      {required super.id,
      required super.username,
      required super.createdAt,
      super.transactions});

  factory UserMapper.fromJson(Map<String, dynamic> json) {
    final List<dynamic> transactionsJson = json['transactions'] ?? [];
    final List<TransactionEntity> transactions = transactionsJson
        .map((transaction) =>
            TransactionMapper.fromJson(Map<String, dynamic>.from(transaction))
                .toEntity())
        .toList();

    return UserMapper(
      id: json["id"] as int,
      username: json["username"],
      createdAt: DateTime.parse(json["create_at"]),
      transactions: transactions,
    );
  }

  UserEntity toEntity() {
    return UserEntity(
        id: id,
        username: username,
        createdAt: createdAt,
        transactions: transactions ?? []);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "username": username,
      "create_at": createdAt.toString(),
      "transactions": transactions ?? []
    };
  }
}
