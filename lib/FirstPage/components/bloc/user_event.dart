part of 'user_bloc.dart';

abstract class UserEvent {}

class InitialUserEvent extends UserEvent {
  InitialUserEvent();
}