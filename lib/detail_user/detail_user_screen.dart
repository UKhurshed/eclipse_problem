import 'package:eclipse_task/detail_user/user_post/album_cubit/album_cubit.dart';
import 'package:eclipse_task/detail_user/user_post/model/album_model.dart';
import 'package:eclipse_task/detail_user/user_post/model/posts_model.dart';
import 'package:eclipse_task/detail_user/user_post/post_cubit/post_user_cubit.dart';
import 'package:eclipse_task/detail_user/user_post/repository/post_repository.dart';
import 'package:eclipse_task/users/model/users.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailUserScreenInit extends StatelessWidget {
  final User user;

  const DetailUserScreenInit({required this.user, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PostUserCubit>(
            create: (context) => PostUserCubit(PostRepositoryImpl())),

        BlocProvider<AlbumCubit>(
          create: (context) => AlbumCubit(PostRepositoryImpl()),
        )
      ],
      child: DetailUserScreen(
        user: user,
      ),
    );
  }
}

class DetailUserScreen extends StatefulWidget {
  final User user;

  const DetailUserScreen({required this.user, Key? key}) : super(key: key);

  @override
  _DetailUserScreenState createState() => _DetailUserScreenState();
}

class _DetailUserScreenState extends State<DetailUserScreen> {
  @override
  void initState() {
    final postCubit = context.read<PostUserCubit>();
    postCubit.getPostCubit(widget.user.id);
    final albumCubit = context.read<AlbumCubit>();
    albumCubit.getAlbumCubit(widget.user.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user.username),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Image.asset(
                "assets/user${widget.user.id}.jpeg",
                height: 100,
                width: 100,
              ),
              const SizedBox(
                height: 20,
              ),
              Text('Name: ${widget.user.name}'),
              const SizedBox(
                height: 8,
              ),
              Text('Email: ${widget.user.email}'),
              const SizedBox(
                height: 8,
              ),
              Text('Phone: ${widget.user.phone}'),
              const SizedBox(
                height: 8,
              ),
              Text('Website: ${widget.user.website}'),
              const SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  Expanded(
                    child: addressColumn(),
                  ),
                  Expanded(
                    child: companyColumn(),
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Expanded(
                child: Center(
                  child: BlocBuilder<PostUserCubit, PostUserState>(
                    builder: (context, state) {
                      if (state is PostError) {
                        return Center(
                          child: Text("error has occurred ${state.message}"),
                        );
                      }
                      if (state is PostLoading) {
                        return loadingIndicator();
                      }
                      if (state is PostUserInitial) {
                        return loadingIndicator();
                      }
                      if (state is PostLoaded) {
                        return ListView.builder(
                          itemBuilder: (context, index) {
                            Post itemsPost = state.posts[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                color: Colors.grey,
                                child: Card(
                                  child: Center(
                                    child: Column(
                                      children: [
                                        Text(itemsPost.userId.toString()),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        SizedBox(
                                          width: 150,
                                          child: Text(
                                            itemsPost.body,
                                            maxLines: 5,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          itemCount: 3,
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                        );
                      } else {
                        return const Center(
                          child: Text("error has occurred"),
                        );
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(height: 15,),
              Expanded(
                child: Center(
                  child: BlocBuilder<AlbumCubit, AlbumState>(
                    builder: (context, state) {
                      if (state is AlbumError) {
                        return Center(
                          child: Text("error has occurred ${state.message}"),
                        );
                      }
                      if (state is AlbumLoading) {
                        return loadingIndicator();
                      }
                      if (state is AlbumInitial) {
                        return loadingIndicator();
                      }
                      if (state is AlbumLoaded) {
                        return ListView.builder(
                          itemBuilder: (context, index) {
                            Album itemsAlbum = state.albums[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                color: Colors.grey,
                                child: Card(
                                  child: Center(
                                    child: Column(
                                      children: [
                                        Text(itemsAlbum.userId.toString()),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        SizedBox(
                                          width: 150,
                                          child: Text(
                                            itemsAlbum.title,
                                            maxLines: 5,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          itemCount: 3,
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                        );
                      } else {
                        return const Center(
                          child: Text("error has occurred"),
                        );
                      }
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Center companyColumn() {
    return Center(
      child: Column(
        children: [
          const Text('Company'),
          const SizedBox(
            height: 8,
          ),
          Text('Name: ${widget.user.company.name}'),
          const SizedBox(
            height: 6,
          ),
          Text(
            'CatchPhrase: ${widget.user.company.catchPhrase}',
            style: const TextStyle(fontStyle: FontStyle.italic),
          ),
          const SizedBox(
            height: 6,
          ),
          Text('Bs: ${widget.user.company.bs}'),
          const SizedBox(
            height: 6,
          ),
        ],
      ),
    );
  }

  Center addressColumn() {
    return Center(
      child: Column(children: [
        const Text('Address'),
        const SizedBox(
          height: 8,
        ),
        Text('Street: ${widget.user.address.street}'),
        const SizedBox(
          height: 6,
        ),
        Text('Suite: ${widget.user.address.suite}'),
        const SizedBox(
          height: 6,
        ),
        Text('City: ${widget.user.address.city}'),
        const SizedBox(
          height: 6,
        ),
        Text('zipCode: ${widget.user.address.zipcode}'),
        const SizedBox(
          height: 6,
        ),
      ]),
    );
  }

  Widget loadingIndicator() {
    return const Center(child: CircularProgressIndicator());
  }
}
