import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_mobile/src/features/details_transaction/interface/blocs/details_transaction_bloc.dart';

import 'package:test_mobile/src/features/details_transaction/widgets/transaction_details_card.dart';
import 'package:test_mobile/src/shared/enums/snackbar_message_type.dart';
import 'package:test_mobile/src/shared/extension/size_extension.dart';
import 'package:test_mobile/src/shared/l10n/l10n.dart';
import 'package:test_mobile/src/shared/widgets/custom_snackbar.dart';

import '../../../../shared/constants/app_colors.dart';
import '../../../../shared/enums/submit_button_enums.dart';
import '../../../../shared/widgets/container_wrapper.dart';
import '../../../../shared/widgets/submit_button.dart';
import '../../../dashboard/core/domain/entities/transaction_entity.dart';

class DetailsTransaction extends StatelessWidget {
  const DetailsTransaction({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.l10n.detailsTransactionAppBarText,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: true,
        backgroundColor: AppColors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      backgroundColor: AppColors.background,
      body: BlocListener<DetailsTransactionBloc, DetailsTransactionState>(
        listenWhen: (prev, next) =>
            (prev.detailsTransactionStatus != next.detailsTransactionStatus) !=
            (prev.descriptionFormStatus != next.descriptionFormStatus),
        listener: (context, state) {
          if (state.detailsTransactionStatus ==
              DetailsTransactionStatus.failed) {
            ScaffoldMessenger.of(context).showSnackBar(CustomSnackbar(
                message: state.errorMessage, messageType: MessageType.error));
          }
        },
        child: BlocBuilder<DetailsTransactionBloc, DetailsTransactionState>(
          builder: (context, state) {
            if (state.detailsTransactionStatus ==
                DetailsTransactionStatus.loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.detailsTransactionStatus ==
                    DetailsTransactionStatus.loaded &&
                state.transaction != null) {
              return SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TransactionDetailsCard(
                      transactionEntity: state.transaction!,
                    ),
                    SizedBox(
                      height: context.setWidth(10),
                    ),
                    _DescriptionSection(
                      transactionEntity: state.transaction!,
                    )
                  ],
                ),
              );
            } else {
              return Center(
                child: Text(state.errorMessage),
              );
            }
          },
        ),
      ),
    );
  }
}

class _DescriptionSection extends StatelessWidget {
  _DescriptionSection({super.key, required this.transactionEntity});
  final TransactionEntity transactionEntity;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailsTransactionBloc, DetailsTransactionState>(
      buildWhen: (prev, next) =>
          (prev.descriptionFormStatus != next.descriptionFormStatus) ||
          (prev.newDescription != next.newDescription),
      builder: (context, state) {
        return Column(
          children: [
            ContainerWrapper(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        context.l10n.detailsTransactionDescriptionText,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.background,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          onPressed: () => context
                              .read<DetailsTransactionBloc>()
                              .add(StartDescriptionEditingEvent()),
                          icon: const Icon(Icons.edit),
                        ),
                      ),
                    ],
                  ),
                  TextFormField(
                    initialValue: transactionEntity.description,
                    maxLength: 80,
                    maxLines: state.descriptionFormStatus ==
                            DescriptionFormStatus.editing
                        ? 2
                        : null,
                    enabled: state.descriptionFormStatus ==
                        DescriptionFormStatus.editing,
                    onChanged: (value) {
                      context
                          .read<DetailsTransactionBloc>()
                          .add(TransactionDescriptionChangedEvent(text: value));
                    },
                    decoration: InputDecoration(
                        counterText: state.descriptionFormStatus !=
                                DescriptionFormStatus.editing
                            ? ''
                            : null,
                        border: InputBorder.none),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: context.setWidth(10),
            ),
            state.descriptionFormStatus == DescriptionFormStatus.editing
                ? (state.descriptionFormStatus ==
                        DescriptionFormStatus.submitting
                    ? Center(child: CircularProgressIndicator())
                    : _EditingButtonSection())
                : SizedBox.shrink(),
          ],
        );
      },
    );
  }
}

class _EditingButtonSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: SubmitButton(
          title: "Update",
          onTap: () {
            context
                .read<DetailsTransactionBloc>()
                .add(SubmitNewDescriptionEvent());
          },
        )),
        SizedBox(
          width: context.setWidth(10),
        ),
        Expanded(
          child: SubmitButton(
            title: "Cancel",
            onTap: () => context
                .read<DetailsTransactionBloc>()
                .add(StopDescriptionEditingEvent()),
            buttonType: Buttontype.cancel,
          ),
        ),
      ],
    );
  }
}
