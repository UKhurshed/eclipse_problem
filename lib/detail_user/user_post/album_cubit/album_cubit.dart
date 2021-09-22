import 'package:bloc/bloc.dart';
import 'package:eclipse_task/detail_user/user_post/model/album_model.dart';
import 'package:eclipse_task/detail_user/user_post/repository/post_repository.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'album_state.dart';

class AlbumCubit extends Cubit<AlbumState> {
  final PostRepositoryImpl _postRepositoryImpl;

  AlbumCubit(this._postRepositoryImpl) : super(AlbumInitial());

  Future<void> getAlbumCubit(int id) async {
    try {
      emit(AlbumLoading());
      final posts = await _postRepositoryImpl.getUserAlbumByIndex(id);
      emit(AlbumLoaded(posts));
    } catch (error) {
      debugPrint('Cubit error: $error');
      emit(AlbumError(error.toString()));
    }
  }

  Future<void> getAlbumList() async {
    try {
      emit(AlbumLoading());
      final posts = await _postRepositoryImpl.getUserAlbum();
      emit(AlbumLoaded(posts));
    } catch (error) {
      debugPrint('Cubit error: $error');
      emit(AlbumError(error.toString()));
    }
  }
}
