part of 'profile_bloc.dart';

abstract class  ProfileEvent  {
  const ProfileEvent();
}


class LogOutEvent extends ProfileEvent{
}

class GetCurrentUserEvent extends ProfileEvent{
}