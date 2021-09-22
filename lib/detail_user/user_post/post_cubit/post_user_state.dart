part of 'post_user_cubit.dart';

@immutable
abstract class PostUserState {}

class PostUserInitial extends PostUserState {}

class PostLoading extends PostUserState {
  PostLoading();
}

class PostError extends PostUserState {
  final String message;

  PostError(this.message);
}

class PostLoaded extends PostUserState {
  final List<Post> posts;

  PostLoaded(this.posts);
}
