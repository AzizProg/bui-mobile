import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_mobile/src/features/dashboard/interface/bloc/dashboard_bloc.dart';
import 'package:test_mobile/src/features/dashboard/interface/widgets/dashboard_appbar.dart';
import 'package:test_mobile/src/features/dashboard/interface/widgets/others_services.dart';
import 'package:test_mobile/src/features/dashboard/interface/widgets/transaction_button.dart';
import 'package:test_mobile/src/features/dashboard/interface/widgets/transaction_card.dart';
import 'package:test_mobile/src/shared/constants/app_colors.dart';
import 'package:test_mobile/src/shared/enums/snackbar_message_type.dart';
import 'package:test_mobile/src/shared/extension/size_extension.dart';
import 'package:test_mobile/src/shared/l10n/l10n.dart';
import 'package:test_mobile/src/shared/routes/app_router.gr.dart';

import 'package:test_mobile/src/shared/widgets/box_shadow.dart';
import 'package:test_mobile/src/shared/widgets/custom_snackbar.dart';

class Dashboard extends StatelessWidget {
  Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final event = context.read<DashboardBloc>();
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const DashboardAppbar(),
      body: BlocListener<DashboardBloc, DashboardState>(
        listenWhen: (prev, next) => prev.runtimeType != next.runtimeType,
        listener: (context, state) {
          if (state is DashboardError) {
            ScaffoldMessenger.of(context).showSnackBar(CustomSnackbar(
                message: state.errorMessage, messageType: MessageType.error));
          }
        },
        child: SafeArea(
          child: RefreshIndicator(
            onRefresh: () async {
              event.add(GetTransactionsEvent());
            },
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics()),
              padding: EdgeInsets.all(context.setWidth(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  //balance section
                  _BalanceSection(),
                  SizedBox(
                    height: context.setHeight(20),
                  ),
                  _ServiceSection(),

                  SizedBox(
                    height: context.setHeight(20),
                  ),

                  _TransactionsSection(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _BalanceSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.screenWidth,
      padding: EdgeInsets.all(context.setWidth(10)),
      decoration: BoxDecoration(
        boxShadow: customShadow(),
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(
            context.l10n.dashboardBalanceText,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontSize: 18, color: Colors.grey),
          ),
          Text(
            '100.000 FCFA',
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: Colors.black),
          ),
          SizedBox(
            height: context.setWidth(10),
          ),
          const Divider(),
          SizedBox(
            height: context.setWidth(10),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TransactionButton(
                icon: Icons.arrow_downward_outlined,
                onTap: () {},
                title: context.l10n.depositText,
              ),
              TransactionButton(
                icon: Icons.compare_arrows_outlined,
                onTap: () {},
                title: context.l10n.buiTransferText,
              ),
              TransactionButton(
                icon: Icons.arrow_upward_outlined,
                onTap: () {},
                title: context.l10n.transferText,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ServiceSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> buiPayItems = [
      context.l10n.serviceAText,
      context.l10n.serviceBText,
      context.l10n.serviceCText,
      context.l10n.serviceDText,
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.othersServiceText,
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontSize: 18, color: Colors.grey),
        ),
        //Others services
        OthersServices(
          servicesItems: buiPayItems,
        ),
      ],
    );
  }
}

class _TransactionsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      //  buildWhen: (prev, next) => prev.runtimeType != next.runtimeType,
      builder: (context, state) {
        if (state is DashboardLoaded)
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${context.l10n.dashboardTransactionsText}(${state.transactions.length})',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontSize: 18, color: Colors.grey),
              ),
              ListView.separated(
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: context.setHeight(10),
                    );
                  },
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: state.transactions.length,
                  itemBuilder: (context, index) {
                    final transaction = state.transactions[index];
                    return TransactionCard(
                      onTap: () => context.router.push(
                          DetailsTransactionPageRoute(id: transaction.id)),
                      transaction: transaction,
                    );
                  }),
            ],
          );
        else if (state is DashboardLoading)
          return Center(child: CircularProgressIndicator());
        return Center(
          child: Text(context.l10n.dashboardNotTransactionsText),
        );
      },
    );
  }
}
