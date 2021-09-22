import 'package:eclipse_task/comments/cubit/comment_cubit.dart';
import 'package:eclipse_task/comments/model/comment.dart';
import 'package:eclipse_task/comments/repository/comment_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentsScreenInit extends StatelessWidget {
  const CommentsScreenInit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => CommentCubit(CommentRepositoryImpl()),
        child: const CommentsScreen());
  }
}

class CommentsScreen extends StatefulWidget {
  const CommentsScreen({Key? key}) : super(key: key);

  @override
  _CommentsScreenState createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {



  @override
  void initState() {
    final commentCubit = context.read<CommentCubit>();
    commentCubit.getComment();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comments'),
      ),
      body: BlocBuilder<CommentCubit, CommentState>(
        builder: (context, state) {
          if (state is CommentError) {
            return const Center(
              child: Text("error has occurred"),
            );
          }
          if (state is CommentInitial) {
            return loadingIndicator();
          }
          if (state is CommentLoading) {
            return loadingIndicator();
          }
          if (state is CommentLoaded) {
            return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: state.comments.length,
                itemBuilder: (context, index) {
                  Comment userItem = state.comments[index];
                  return ListTile(
                    title: Text(
                      userItem.name,
                      maxLines: 1,
                    ),
                    leading: Text(
                      userItem.body,
                      maxLines: 1,
                    ),
                  );
                });
          } else {
            return const Center(
              child: Text("error has occurred"),
            );
          }
        },
      ),

    );
  }


  Widget loadingIndicator() {
    return const Center(child: CircularProgressIndicator());
  }
}
