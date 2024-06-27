
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_mobile/src/features/auth/core/application/usescases/get_user_usecase.dart';
import 'package:test_mobile/src/features/auth/interface/login/view/login_form.dart';

import '../../../../../injection_container.dart';
import '../bloc/login_bloc.dart';

@RoutePage()
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            LoginBloc(getUserUseCase: getIt<GetUserUseCase>()),
        child: const LogInForm());
  }
}
