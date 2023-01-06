import 'dart:async';
import 'package:proj_ver1/data/repository/models/ride_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj_ver1/data/ride_repository.dart';

part 'ride_event.dart';

part 'ride_state.dart';

class RideBloc extends Bloc<RideEvent, RideState> {
  RideRepository repository;

  RideBloc({required this.repository}) : super(InitialRidesState());

  @override
  Stream<RideState> mapEventToState(
    RideEvent event,
  ) async* {
    if (event is InitialRideEvent) {
      yield InitialRidesState();
      try {
        //UsersRepository? repository;
        List<Ride> rides = await repository.getRide();

        yield LoadingRidesState(rides: rides);
      } catch (_) {
        yield ErrorRidesState();
      }
    }
  }
}