import 'package:test_mobile/src/shared/enums/transaction_type.dart';

extension TransactionExtensionWithString on String {
  ///accept a [String]
  ///Search the enum [TransactionType] value corresponding to this String
  //parse into transaction type
  TransactionType get typeFromJson => TransactionType.values.firstWhere(
      (e) => e.toString().split('.').last.contains(this.toLowerCase()));
}

///get value from enum: [TransactionType]
extension TransactionExtensionWithTransactionType on TransactionType {
  String get getEnumValue => this.toString().split('.').last;
}
