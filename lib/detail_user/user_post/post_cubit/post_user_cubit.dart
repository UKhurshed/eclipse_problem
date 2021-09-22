import 'package:bloc/bloc.dart';
import 'package:eclipse_task/detail_user/user_post/model/posts_model.dart';
import 'package:eclipse_task/detail_user/user_post/repository/post_repository.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'post_user_state.dart';

class PostUserCubit extends Cubit<PostUserState> {
  final PostRepositoryImpl _postRepositoryImpl;

  PostUserCubit(this._postRepositoryImpl) : super(PostUserInitial());

  Future<void> getPostCubit(int id) async {
    try {
      emit(PostLoading());
      final posts = await _postRepositoryImpl.getUserPostByIndex(id);
      emit(PostLoaded(posts));
    } catch (error) {
      debugPrint('Cubit error: $error');
      emit(PostError(error.toString()));
    }
  }

  Future<void> getPostList() async {
    try {
      emit(PostLoading());
      final posts = await _postRepositoryImpl.getUserPost();
      emit(PostLoaded(posts));
    } catch (error) {
      debugPrint('Cubit error: $error');
      emit(PostError(error.toString()));
    }
  }
}
