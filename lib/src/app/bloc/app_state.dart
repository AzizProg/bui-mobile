part of 'app_bloc.dart';

class AppState extends Equatable {
  AppState({this.language = Language.english});
  final Language language;


  AppState copyWith(Language? language){
   return AppState(
    language: language?? this.language
   );
  }
  @override
  List<Object?> get props => [language];
}
