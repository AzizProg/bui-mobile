part of 'details_transaction_bloc.dart';

enum DescriptionFormStatus { initial, editing, submitting, failed }

enum DetailsTransactionStatus { loading, loaded, failed }

class DetailsTransactionState extends Equatable {
  DetailsTransactionState(
      {this.detailsTransactionStatus = DetailsTransactionStatus.loading,
      this.descriptionFormStatus = DescriptionFormStatus.initial,
      this.newDescription = '',
      this.transaction,
      this.errorMessage = ''});
  final DescriptionFormStatus descriptionFormStatus;
  final DetailsTransactionStatus detailsTransactionStatus;
  final TransactionEntity? transaction;
  final String errorMessage;
  final String newDescription;
  DetailsTransactionState copyWith(
      {DescriptionFormStatus? descriptionFormStatus,
      DetailsTransactionStatus? detailsTransactionStatus,
      TransactionEntity? transaction,
      String? errorMessage,
      String? newDescription}) {
    return DetailsTransactionState(
        transaction: transaction ?? this.transaction,
        newDescription: newDescription ?? this.newDescription,
        errorMessage: errorMessage ?? this.errorMessage,
        descriptionFormStatus:
            descriptionFormStatus ?? this.descriptionFormStatus,
        detailsTransactionStatus:
            detailsTransactionStatus ?? this.detailsTransactionStatus);
  }

  @override
  List<Object?> get props => [
        detailsTransactionStatus,
        descriptionFormStatus,
        newDescription,
        errorMessage,
        transaction
      ];
}
