import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final String message;
  final int? code;

  Failure({required this.message, this.code});

  @override
  List<Object?> get props => [message, code];
}
