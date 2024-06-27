import 'package:hive/hive.dart';
part 'transaction_type.g.dart';
@HiveType(typeId: 2)
enum TransactionType { @HiveField(0)deposit, @HiveField(1)transfer, @HiveField(2)withdraw }