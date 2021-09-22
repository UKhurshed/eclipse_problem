part of 'album_cubit.dart';

@immutable
abstract class AlbumState {}

class AlbumInitial extends AlbumState {}

class AlbumLoading extends AlbumState {
  AlbumLoading();
}

class AlbumError extends AlbumState {
  final String message;

  AlbumError(this.message);
}

class AlbumLoaded extends AlbumState {
  final List<Album> albums;

  AlbumLoaded(this.albums);
}
