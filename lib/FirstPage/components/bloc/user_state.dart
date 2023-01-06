part of 'user_bloc.dart';

abstract class UserState {}

class InitialUsersState extends UserState {}

class LoadingUsersState extends UserState {

  final List<Users> users;

  LoadingUsersState({required this.users});
}

class ErrorUsersState extends UserState {}