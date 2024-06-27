import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_mobile/src/features/dashboard/core/application/usecases/get_transactions_usecase.dart';

import 'package:test_mobile/src/features/dashboard/interface/bloc/dashboard_bloc.dart';
import 'package:test_mobile/src/features/dashboard/interface/view/dashboard.dart';
import 'package:test_mobile/src/injection_container.dart';

@RoutePage()
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => DashboardBloc(
            getTransactionsUsecase: getIt<GetTransactionsUsecase>())
          ..add(GetTransactionsEvent()),
        child: Dashboard());
  }
}
