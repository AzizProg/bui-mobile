import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

import '../../../../../shared/enums/transaction_type.dart';
part 'transaction_entity.g.dart';

@HiveType(typeId: 1)
class TransactionEntity extends Equatable {

  const TransactionEntity(
      {required this.id,
      required this.amount,
      required this.type,
      required this.description,
      required this.createdAt});
@HiveField(0)
  final int id;
  @HiveField(1)
  final double amount;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final TransactionType type;
  @HiveField(4)
  final DateTime createdAt;

  @override
  List<Object?> get props => [id, amount, type, description, createdAt];
}
