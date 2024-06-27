import 'package:auto_route/annotations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_mobile/src/features/auth/core/application/usescases/current_user_usecase.dart';

import 'package:test_mobile/src/features/profil/interface/blocs/profile_bloc.dart';
import 'package:test_mobile/src/features/profil/interface/view/profile.dart';
import 'package:test_mobile/src/injection_container.dart';

import '../../../auth/core/application/usescases/log_out_usecase.dart';

@RoutePage()
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc(
          logOutUsecase: getIt<LogOutUsecase>(),
          currentUserUsecase: getIt<CurrentUserUsecase>())
        ..add(GetCurrentUserEvent()),
      child: Profile(),
    );
  }
}
