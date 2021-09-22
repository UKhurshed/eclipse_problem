part of 'users_cubit.dart';

@immutable
abstract class UsersState {}

class UsersInitial extends UsersState {}

class UserLoading extends UsersState {
  UserLoading();
}

class UserError extends UsersState {
  final String message;
  UserError(this.message);
}

class UserLoaded extends UsersState {
  final List<User> users;
  UserLoaded(this.users);
}
