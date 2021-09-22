import 'package:bloc/bloc.dart';
import 'package:eclipse_task/users/model/users.dart';
import 'package:eclipse_task/users/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  final UserRepositoryImpl _userRepositoryImpl;

  UsersCubit(this._userRepositoryImpl) : super(UsersInitial());

  Future<void> getUsersCubit() async {
    try {
      emit(UserLoading());
      final currency = await _userRepositoryImpl.getUsers();
      emit(UserLoaded(currency));
    } catch (error) {
      debugPrint('Cubit error: $error');
      emit(UserError(error.toString()));
    }
  }
}
