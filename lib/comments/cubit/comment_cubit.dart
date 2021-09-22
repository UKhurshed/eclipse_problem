import 'package:bloc/bloc.dart';
import 'package:eclipse_task/comments/model/comment.dart';
import 'package:eclipse_task/comments/repository/comment_repository.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'comment_state.dart';

class CommentCubit extends Cubit<CommentState> {
  final CommentRepositoryImpl _commentRepositoryImpl;

  CommentCubit(this._commentRepositoryImpl) : super(CommentInitial());

  Future<void> getComment() async {
    try {
      emit(CommentLoading());
      final currency = await _commentRepositoryImpl.getComment();
      emit(CommentLoaded(currency));
    } catch (error) {
      debugPrint('Cubit error: $error');
      emit(CommentError(error.toString()));
    }
  }
}
