import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_mobile/src/shared/enums/langage_enum.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(AppState()) {
    on<ChangeLanguageEvent>(_changeLanguage);
  }

  Future<void> _changeLanguage(ChangeLanguageEvent event,Emitter<AppState> emit)async{
    emit(state.copyWith(event.selectLanguage));
  }
}
