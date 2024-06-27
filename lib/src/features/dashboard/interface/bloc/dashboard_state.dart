part of 'dashboard_bloc.dart';

sealed class DashboardState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DashboardInitial extends DashboardState {
  @override
  List<Object?> get props => [];
}

class DashboardLoading extends DashboardState {
  @override
  List<Object?> get props => [];
}

class DashboardLoaded extends DashboardState {
  DashboardLoaded({
    required this.transactions,
  });
  final List<TransactionEntity> transactions;

  @override
  List<Object?> get props => [transactions];
}

class DashboardError extends DashboardState {
  DashboardError({
    required this.errorMessage,
  });

  final String errorMessage;

  @override
  List<Object?> get props => [errorMessage];
}
