import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_mobile/src/features/details_transaction/core/application/usecases/get_Transaction_by_id_usecase.dart';
import 'package:test_mobile/src/features/details_transaction/core/application/usecases/update_transaction_by_id.dart';
import 'package:test_mobile/src/shared/constants/response_code.dart';

import '../../../dashboard/core/domain/entities/transaction_entity.dart';

part 'details_transaction_event.dart';
part 'details_transaction_state.dart';

class DetailsTransactionBloc
    extends Bloc<DetailsTransactionEvent, DetailsTransactionState> {
  DetailsTransactionBloc({
    required this.getTransactionByIdUsecase,
    required this.updateTransactionById,
  }) : super(DetailsTransactionState()) {
    on<GetTransactionByIdEvent>(_getTransactionById);
    on<StartDescriptionEditingEvent>(_startEditing);
    on<StopDescriptionEditingEvent>(_stopEditing);
    on<TransactionDescriptionChangedEvent>(_descriptionChanged);
    on<SubmitNewDescriptionEvent>(_updateTransactionDescription);
  }

  final GetTransactionByIdUsecase getTransactionByIdUsecase;
  final UpdateTransactionById updateTransactionById;

  Future<void> _startEditing(StartDescriptionEditingEvent event,
      Emitter<DetailsTransactionState> emit) async {
    if (state.detailsTransactionStatus == DetailsTransactionStatus.loaded) {
      emit(
        state.copyWith(descriptionFormStatus: DescriptionFormStatus.editing),
      );
    }
  }

  Future<void> _stopEditing(StopDescriptionEditingEvent event,
      Emitter<DetailsTransactionState> emit) async {
    if (state.detailsTransactionStatus == DetailsTransactionStatus.loaded) {
      emit(
        state.copyWith(descriptionFormStatus: DescriptionFormStatus.initial),
      );
    }
  }

  Future<void> _descriptionChanged(TransactionDescriptionChangedEvent event,
      Emitter<DetailsTransactionState> emit) async {
    print(event.text);
    if (state.detailsTransactionStatus == DetailsTransactionStatus.loaded) {
      emit(state.copyWith(newDescription: event.text));
    }
  }

  Future<void> _getTransactionById(GetTransactionByIdEvent event,
      Emitter<DetailsTransactionState> emit) async {
    if (state.descriptionFormStatus == DescriptionFormStatus.submitting) {
      emit(state.copyWith(
          detailsTransactionStatus: DetailsTransactionStatus.loading));
    await Future.delayed(Duration(seconds: 2));
  }

    final res = await getTransactionByIdUsecase.call(event.id);
    res.fold(
      (failure) {
        emit(state.copyWith(
            errorMessage: failure.message,
            detailsTransactionStatus: DetailsTransactionStatus.failed));
      },
      (transaction) {
        emit(state.copyWith(
          transaction: transaction,
          detailsTransactionStatus: DetailsTransactionStatus.loaded,
        ));
      },
    );
  }

  Future<void> _updateTransactionDescription(SubmitNewDescriptionEvent event,
      Emitter<DetailsTransactionState> emit) async {
    if (state.descriptionFormStatus == DescriptionFormStatus.editing &&
        state.detailsTransactionStatus == DetailsTransactionStatus.loaded &&
        state.newDescription.isNotEmpty) {
      emit(state.copyWith(
          descriptionFormStatus: DescriptionFormStatus.submitting));

      final res = await updateTransactionById.call(
          state.transaction!.id, state.newDescription);
      res.fold(
        (failure) {
          emit(state.copyWith(
              errorMessage: failure.message,
              descriptionFormStatus: DescriptionFormStatus.failed));
        },
        (code) async {
          if (code == ResponseCode.SUCCESS) {
            add(GetTransactionByIdEvent(id: state.transaction!.id));
          }
        },
      );
    }
  }
}
