import 'package:flutter/material.dart';
import 'package:test_mobile/src/features/dashboard/core/domain/entities/transaction_entity.dart';
import 'package:test_mobile/src/shared/extension/size_extension.dart';
import 'package:test_mobile/src/shared/extension/transaction_type_extension.dart';
import 'package:test_mobile/src/shared/l10n/l10n.dart';
import 'package:test_mobile/src/shared/widgets/container_wrapper.dart';

class TransactionDetailsCard extends StatelessWidget {
  const TransactionDetailsCard({super.key, required this.transactionEntity});
  final TransactionEntity transactionEntity;

  @override
  Widget build(BuildContext context) {
    return ContainerWrapper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _row(
              context: context,
              label: context.l10n.detailsTransactionAmountText,
              value: "${transactionEntity.amount} FCFA"),
          _row(
              context: context,
              label: context.l10n.detailsTransactionDateText,
              value:
                  "${transactionEntity.createdAt.day}/${transactionEntity.createdAt.month}/${transactionEntity.createdAt.year}"),
          _row(
              context: context,
              label: context.l10n.detailsTransactionTimeText,
              value: "${transactionEntity.createdAt.hour}:${transactionEntity.createdAt.minute}"),
          _row(
              context: context,
              label: context.l10n.detailsTransactionTypeText,
              value: "${transactionEntity.type.getEnumValue}"),
        ],
      ),
    );
  }

  Widget _row(
      {required BuildContext context,
      required String label,
      required String value}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: context.setWidth(5)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$label :",
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Colors.grey, fontWeight: FontWeight.bold),
          ),
          Text(
            "$value",
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
