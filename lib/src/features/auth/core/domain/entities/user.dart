import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:test_mobile/src/features/dashboard/core/domain/entities/transaction_entity.dart';
part 'user.g.dart';

@HiveType(typeId: 0)
class UserEntity extends Equatable {
  const UserEntity({
    required this.id,
    required this.username,
    required this.createdAt,
    this.transactions,
  });

  @HiveField(0)
  final int id;
  @HiveField(1)
  final String username;
  @HiveField(2)
  final DateTime createdAt;
  @HiveField(3)
  final List<TransactionEntity>? transactions;

  @override
  List<Object?> get props => [id, username, transactions, createdAt];
}
