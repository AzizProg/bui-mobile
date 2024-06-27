
import 'package:test_mobile/src/features/dashboard/core/domain/entities/transaction_entity.dart';
import 'package:test_mobile/src/shared/extension/transaction_type_extension.dart';

class TransactionMapper extends TransactionEntity {
  TransactionMapper(
      {required super.id,
      required super.amount,
      required super.type,
      required super.description,
      required super.createdAt});

  factory TransactionMapper.fromJson(Map<String, dynamic> json) {

    return TransactionMapper(
      id: json["id"],
      amount: double.parse(json['amount'].toString()),
      createdAt: DateTime.parse(json['created_at']),
      type: json['type'].toString().typeFromJson,
      description: json['description'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "amount": amount,
      "type": type.toString().split('.').last,
      "description": description,
      "created_at": createdAt.toString()
    };
  }

  TransactionEntity toEntity() {
    return TransactionEntity(
        id: id,
        amount: amount,
        type: type,
        description: description,
        createdAt: createdAt);
  }

  factory TransactionMapper.fromEntity(TransactionEntity transaction) {
    return TransactionMapper(
        id: transaction.id,
        amount: transaction.amount,
        type: transaction.type,
        description: transaction.description,
        createdAt: transaction.createdAt);
  }
}
