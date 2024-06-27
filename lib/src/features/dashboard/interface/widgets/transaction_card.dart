import 'package:flutter/material.dart';
import 'package:test_mobile/src/features/dashboard/core/domain/entities/transaction_entity.dart';
import 'package:test_mobile/src/shared/constants/app_colors.dart';
import 'package:test_mobile/src/shared/extension/size_extension.dart';
import 'package:test_mobile/src/shared/widgets/container_wrapper.dart';

import '../../../../shared/enums/transaction_type.dart';

class TransactionCard extends StatelessWidget {
  const TransactionCard(
      {super.key, required this.onTap, required this.transaction});
  final VoidCallback onTap;
  final TransactionEntity transaction;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ContainerWrapper(
        child: Row(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(context.setWidth(10)),
              decoration: BoxDecoration(
                color: AppColors.black,
                shape: BoxShape.circle,
              ),
              child: Icon(
                transaction.type == TransactionType.deposit
                    ? Icons.arrow_downward_outlined
                    : Icons.arrow_upward_outlined,
                color: Colors.white,
              ),
            ),
            SizedBox(
              width: context.setWidth(10),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${transaction.amount} FCFA'),
                Text(
                  '${transaction.createdAt.day}/${transaction.createdAt.month}/${transaction.createdAt.year}',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Colors.grey),
                ),
              ],
            ),
            const Spacer(),
            Container(
              padding: EdgeInsets.all(context.setWidth(2)),
              decoration: BoxDecoration(
                color: AppColors.background,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.keyboard_arrow_right_outlined,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
