part of 'ride_bloc.dart';

abstract class RideState {}

class InitialRidesState extends RideState {}

class LoadingRidesState extends RideState {

  final List<Ride> rides;

  LoadingRidesState({required this.rides});
}

class ErrorRidesState extends RideState {}