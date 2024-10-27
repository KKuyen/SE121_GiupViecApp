import 'package:equatable/equatable.dart';
import 'package:se121_giupviec_app/domain/entities/response.dart';
import '../../../domain/entities/user.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final User user;

  const AuthSuccess(this.user);

  @override
  List<Object> get props => [user];
}

class AuthResponseSuccess extends AuthState {
  final Response response;

  const AuthResponseSuccess(this.response);

  @override
  List<Object> get props => [response];
}

class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object> get props => [message];
}
