import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_mobile/src/app/bloc/app_bloc.dart';
import 'package:test_mobile/src/features/profil/interface/blocs/profile_bloc.dart';
import 'package:test_mobile/src/features/profil/interface/widgets/language_card.dart';
import 'package:test_mobile/src/features/profil/interface/widgets/logout_btn.dart';
import 'package:test_mobile/src/features/profil/interface/widgets/profil_appbar.dart';
import 'package:test_mobile/src/features/profil/interface/widgets/user_details_card.dart';
import 'package:test_mobile/src/injection_container.dart';
import 'package:test_mobile/src/shared/constants/app_colors.dart';
import 'package:test_mobile/src/shared/enums/langage_enum.dart';
import 'package:test_mobile/src/shared/extension/size_extension.dart';
import 'package:test_mobile/src/shared/l10n/l10n.dart';

import 'package:test_mobile/src/shared/widgets/container_wrapper.dart';


class Profile extends StatelessWidget {
  Profile({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: AppColors.background,
      appBar: ProfilAppbar(title: context.l10n.profileAppBarText),
      body: Padding(
        padding: EdgeInsets.all(context.setWidth(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _UserSection(),
            SizedBox(
              height: context.setWidth(15),
            ),
            _LanguageSection(),
          ],
        ),
      ),
    );
  }
}

class _UserSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        switch (state) {
          case ProfileLoaded():
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.l10n.profileDescriptionText,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontSize: 18,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                ContainerWrapper(
                    child: Column(
                  children: [
                    UserDetailsCard(
                      user: state.userEntity,
                    ),
                    SizedBox(
                      height: context.setWidth(5),
                    ),
                    Divider(
                      color: AppColors.background,
                    ),
                    SizedBox(
                      height: context.setWidth(5),
                    ),
                    LogoutButton(
                        onTap: () {
                          context.read<ProfileBloc>().add(LogOutEvent());
                        },
                        title: context.l10n.profileLogOutButtonText)
                  ],
                ))
              ],
            );

          default:
            return Center(
              child: Text(context.l10n.errorMessage),
            );
        }
      },
    );
  }
}

class _LanguageSection extends StatelessWidget {
  final appBloc = getIt<AppBloc>();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.profileLanguagesText,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontSize: 18,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
        ),
        ContainerWrapper(
            child: Column(
          children: [
            LanguageCard(
                onTap: () {
                  appBloc.add(
                      ChangeLanguageEvent(selectLanguage: Language.english));
                },
                title: "English",
                value: appBloc.state.language == Language.english
                    ? appBloc.state.language
                    : ''),
            LanguageCard(
                onTap: () {
                  print("click");
                  appBloc.add(
                      ChangeLanguageEvent(selectLanguage: Language.french));
                },
                title: "French",
                value: appBloc.state.language == Language.french
                    ? appBloc.state.language
                    : ''),
          ],
        ))
      ],
    );
  }
}
