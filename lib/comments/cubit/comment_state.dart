part of 'comment_cubit.dart';

@immutable
abstract class CommentState {}

class CommentInitial extends CommentState{}

class CommentLoading extends CommentState {
  CommentLoading();
}

class CommentError extends CommentState {
  final String message;
  CommentError(this.message);
}

class CommentLoaded extends CommentState {
  final List<Comment> comments;
  CommentLoaded(this.comments);
}
