import 'package:eclipse_task/detail_user/user_post/model/posts_model.dart';
import 'package:eclipse_task/detail_user/user_post/post_cubit/post_user_cubit.dart';
import 'package:eclipse_task/detail_user/user_post/repository/post_repository.dart';
import 'package:eclipse_task/posts/detail_post/detail_post_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsScreenInit extends StatelessWidget {
  const PostsScreenInit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => PostUserCubit(PostRepositoryImpl()),
        child: const PostsScreen());
  }
}

class PostsScreen extends StatefulWidget {
  const PostsScreen({Key? key}) : super(key: key);

  @override
  _PostsScreenState createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  @override
  void initState() {
    final postCubit = context.read<PostUserCubit>();
    postCubit.getPostList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostUserCubit, PostUserState>(
      builder: (context, state) {
        if (state is PostError) {
          return const Center(
            child: Text("error has occurred"),
          );
        }
        if (state is PostLoading) {
          return loadingIndicator();
        }
        if (state is PostUserInitial) {
          return loadingIndicator();
        }
        if (state is PostLoaded) {
          return ListView.separated(
              separatorBuilder: (context, index) {
                return const Divider(
                  height: 2.0,
                );
              },
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: state.posts.length,
              itemBuilder: (context, index) {
                Post postItem = state.posts[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailPostScreen(
                                  post: postItem,
                                )));
                  },
                  child: ListTile(
                    title: Text(postItem.body),
                    leading: Text(postItem.title),
                    trailing: Text(postItem.id.toString()),
                    subtitle: Text(postItem.userId.toString()),
                  ),
                );
              });
        } else {
          return const Center(
            child: Text("error has occurred"),
          );
        }
      },
    );
  }

  Widget loadingIndicator() {
    return const Center(child: CircularProgressIndicator());
  }
}
