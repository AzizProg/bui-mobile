import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_mobile/src/features/auth/interface/login/bloc/login_bloc.dart';
import 'package:test_mobile/src/features/auth/interface/widgets/auth_appbar.dart';
import 'package:test_mobile/src/features/auth/interface/widgets/password_field.dart';
import 'package:test_mobile/src/features/auth/interface/widgets/username_field.dart';
import 'package:test_mobile/src/shared/constants/app_images.dart';
import 'package:test_mobile/src/shared/extension/form_validation_extension.dart';
import 'package:test_mobile/src/shared/extension/size_extension.dart';
import 'package:test_mobile/src/shared/l10n/l10n.dart';
import 'package:test_mobile/src/shared/routes/app_router.gr.dart';
import 'package:test_mobile/src/shared/routes/routeName.dart';
import 'package:test_mobile/src/shared/widgets/submit_button.dart';
import '../../../../../shared/enums/form_status.dart';
import '../../../../../shared/enums/snackbar_message_type.dart';
import '../../../../../shared/enums/submit_button_enums.dart';
import '../../../../../shared/widgets/custom_snackbar.dart';

class LogInForm extends StatelessWidget {
  const LogInForm({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar:  AuthAppbar(title: context.l10n.loginAppBarText),
      body: BlocListener<LoginBloc, LoginState>(
        listenWhen: (prev, next) => prev.status != next.status,
        listener: (context, state) {
          if (state.status == FormStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              CustomSnackbar(
                message: state.message,
                messageType: MessageType.error,
              ),
            );
          }
          if (state.status == FormStatus.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              CustomSnackbar(
                message: state.message,
                messageType: MessageType.success,
              ),
            );
          }
        },
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(context.setWidth(10)),
              child: IntrinsicHeight(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      AppImages.logo,
                      width: context.setWidth(80),
                    ),
                    Column(
                      children: [
                        _UsernameSection(),
                        SizedBox(
                          height: context.setWidth(10),
                        ),
                        _PasswordSection(),
                        SizedBox(
                          height: context.setWidth(25),
                        ),
                        _SubmitButtonSection(),
                        SizedBox(
                          height: context.setWidth(10),
                        ),
                        InkWell(
                          onTap: () =>
                              context.router.pushNamed(RouteNames.signup),
                          child: RichText(
                            text: TextSpan(
                              style: Theme.of(context).textTheme.bodyMedium,
                              text: context.l10n.loginNoAccountText,
                              children: [
                                TextSpan(
                                  text: context.l10n.loginSignUpText,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _UsernameSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, next) => previous.username != next.username,
      builder: (context, state) {
        return Column(
          children: [
            UsernameField(
              title: context.l10n.usernameFieldText,
              onChanged: (username) => context
                  .read<LoginBloc>()
                  .add(LoginUsernameChangedEvent(username: username)),
              errorMessage: state.username.validUsername(),
            ),
          ],
        );
      },
    );
  }
}

class _PasswordSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, next) =>
          previous.password != next.password ||
          previous.isHidden != next.isHidden,
      builder: (context, state) {
        return Column(
          children: [
            PasswordField(
              title: context.l10n.passwordFieldText,
              onChanged: (password) => context
                  .read<LoginBloc>()
                  .add(LoginPasswordChangedEvent(password: password)),
              errorMessage: state.password.validPassword(),
              passwordToggle: () {
                if (state.isHidden)
                  return context
                      .read<LoginBloc>()
                      .add(const LoginShowPasswordEvent());
                return context
                    .read<LoginBloc>()
                    .add(const LoginHidePasswordEvent());
              },
              isHidden: state.isHidden,
            ),
          ],
        );
      },
    );
  }
}

class _SubmitButtonSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      // buildWhen: (previous, next) => previous.status != next.status,
      builder: (context, state) {
        return SubmitButton(
          title: context.l10n.loginSubmitButtonText,
          onTap: () {
            FocusScope.of(context).unfocus();
            context.read<LoginBloc>().add(const LoginSubmittedEvent());
          },
          buttonState: (state.password.validSubmitPassword() &&
                  state.username.validSubmitUsername())
              ? (state.status == FormStatus.loading
                  ? ButtonState.loading
                  : ButtonState.initial)
              : ButtonState.disabled,
        );
      },
    );
  }
}
