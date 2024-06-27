import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_mobile/src/features/dashboard/core/application/usecases/get_transactions_usecase.dart';
import 'package:test_mobile/src/features/dashboard/interface/bloc/dashboard_bloc.dart';
import 'package:test_mobile/src/features/dashboard/interface/view/dashboard.dart';
import 'package:test_mobile/src/features/details_transaction/core/application/usecases/update_transaction_by_id.dart';
import 'package:test_mobile/src/features/details_transaction/interface/blocs/details_transaction_bloc.dart';
import 'package:test_mobile/src/features/details_transaction/interface/views/details_transaction.dart';
import 'package:test_mobile/src/injection_container.dart';

import '../../core/application/usecases/get_Transaction_by_id_usecase.dart';

@RoutePage()
class DetailsTransactionPage extends StatelessWidget {
  const DetailsTransactionPage({super.key, required this.id});
  final int id;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => DetailsTransactionBloc(
            getTransactionByIdUsecase: getIt<GetTransactionByIdUsecase>(), updateTransactionById: getIt<UpdateTransactionById>())
          ..add(GetTransactionByIdEvent(id: id)),
        child: DetailsTransaction());
  }
}
