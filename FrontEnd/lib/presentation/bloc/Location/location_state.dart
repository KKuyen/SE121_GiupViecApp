// lib/presentation/cubit/task_state.dart
import 'package:equatable/equatable.dart';

import '../../../domain/entities/location.dart';

abstract class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object> get props => [];

  Object get prop => Location;
}

class LocationInitial extends LocationState {}

class LocationLoading extends LocationState {}

class DefaultLocationLoading extends LocationState {}

class LocationSuccess extends LocationState {
  final List<Location> locations;

  const LocationSuccess(this.locations);

  @override
  List<Object> get props => [locations];
}

class DefaultLocationSuccess extends LocationState {
  final Location location;

  const DefaultLocationSuccess(this.location);

  @override
  Object get prop => location;
}

class LocationError extends LocationState {
  final String message;

  const LocationError(this.message);

  @override
  List<Object> get props => [message];
}

class DefaultLocationError extends LocationState {
  final String message;

  const DefaultLocationError(this.message);

  @override
  List<Object> get props => [message];
}
