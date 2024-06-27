part of 'details_transaction_bloc.dart';

sealed class DetailsTransactionEvent {
}

class GetTransactionByIdEvent extends DetailsTransactionEvent {
  GetTransactionByIdEvent({required this.id});
  final int id;
}

class StartDescriptionEditingEvent extends DetailsTransactionEvent {
}


class TransactionDescriptionChangedEvent extends DetailsTransactionEvent {
  TransactionDescriptionChangedEvent({required this.text});
  final String text;
}
class StopDescriptionEditingEvent extends DetailsTransactionEvent {
}

class SubmitNewDescriptionEvent extends DetailsTransactionEvent {

}
