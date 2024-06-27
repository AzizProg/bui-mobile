part of 'app_bloc.dart';

sealed class AppEvent extends Equatable {}
class ChangeLanguageEvent extends AppEvent{
  ChangeLanguageEvent({required this.selectLanguage});
  final Language selectLanguage;

  @override
  List<Object?> get props => [selectLanguage];
}