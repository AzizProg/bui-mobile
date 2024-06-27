part of 'profile_bloc.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();
}

final class ProfileInitial extends ProfileState {
  @override
  List<Object> get props => [];
}

class ProfileLoading extends ProfileState {
  @override
  List<Object?> get props => [];
}

class ProfileLoaded extends ProfileState {
  ProfileLoaded({required this.userEntity});
  final UserEntity userEntity;

  @override
  List<Object?> get props => [userEntity];
}

class ProfileError extends ProfileState {
  ProfileError({required this.errorMessage});
  final String errorMessage;
  @override
  List<Object?> get props => [];
}
