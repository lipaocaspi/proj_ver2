import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj_ver1/data/repository/models/user_model.dart';
import 'package:proj_ver1/data/user_repository.dart';
part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UsersRepository repository;

  UserBloc({required this.repository}) : super(InitialUsersState());

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is InitialUserEvent) {
      yield InitialUsersState();
      try {
        List<Users> users = await repository.getUser();

        yield LoadingUsersState(users: users);
      } catch (_) {
        yield ErrorUsersState();
      }
    }
  }
}
