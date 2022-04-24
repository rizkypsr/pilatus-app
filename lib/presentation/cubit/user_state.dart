part of 'user_cubit.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserError extends UserState {
  final String message;

  const UserError(this.message);

  @override
  List<Object> get props => [message];
}

class UserHasData extends UserState {
  final User user;

  const UserHasData(this.user);

  @override
  List<Object> get props => [user];
}

class UserUpdated extends UserState {
  final String message;

  const UserUpdated(this.message);

  @override
  List<Object> get props => [message];
}
