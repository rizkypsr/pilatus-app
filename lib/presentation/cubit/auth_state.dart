part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class LoadingLogoutState extends AuthState {}

class LoadingLoginState extends AuthState {}

class ForcingLoginState extends AuthState {}

class UnlogedState extends AuthState {}

class LogedState extends AuthState {}

class LoginErrorState extends AuthState {
  final String message;

  const LoginErrorState(this.message);

  @override
  List<Object> get props => [message];
}

class LoadingSignUpState extends AuthState {}

class ErrorSignUpState extends AuthState {
  final String message;

  const ErrorSignUpState(this.message);

  @override
  List<Object> get props => [message];
}
