import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_mobile/src/features/auth/interface/sign_up/view/sign_up_form.dart';
import 'package:test_mobile/src/shared/routes/routeName.dart';
import '../../../../../injection_container.dart';
import 'package:test_mobile/src/features/auth/core/application/usescases/save_user_usecase.dart';
import '../bloc/sign_up_bloc.dart';

@RoutePage()
class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            SignUpBloc(saveUserUseCase: getIt<SaveUserUseCase>()),
        child: const SignUpForm());
  }
}
