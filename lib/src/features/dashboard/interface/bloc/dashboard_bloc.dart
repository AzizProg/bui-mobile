import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_mobile/src/features/dashboard/core/application/usecases/get_transactions_usecase.dart';
import 'package:test_mobile/src/shared/storage/hive_storage.dart';

import '../../core/domain/entities/transaction_entity.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc({required this.getTransactionsUsecase})
      : super(DashboardInitial()) {
    on<GetTransactionsEvent>(_getTransactions);

  }
  final GetTransactionsUsecase getTransactionsUsecase;
  Future<void> _getTransactions(
      GetTransactionsEvent event, Emitter<DashboardState> emit) async {
    emit(DashboardLoading());
    //I load cache transactions before remote data because local data load more easily and quickly
    final cacheTransactions = await HiveStorage.loadTransactions();
    if (cacheTransactions.isNotEmpty) {
      emit(DashboardLoaded(transactions: cacheTransactions));
    }
    await Future.delayed(Duration(seconds: 2));
    final res = await getTransactionsUsecase.call();
    res.fold((failure) {
      emit(DashboardError(errorMessage: failure.message));
    }, (transactions) {
      emit(DashboardLoaded(transactions: transactions));
    });
  }

}
