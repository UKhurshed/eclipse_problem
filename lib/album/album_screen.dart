import 'package:eclipse_task/detail_user/user_post/album_cubit/album_cubit.dart';
import 'package:eclipse_task/detail_user/user_post/model/album_model.dart';
import 'package:eclipse_task/detail_user/user_post/repository/post_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AlbumScreenInit extends StatelessWidget {
  const AlbumScreenInit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AlbumCubit(PostRepositoryImpl()),
        child: const AlbumScreen());
  }
}

class AlbumScreen extends StatefulWidget {
  const AlbumScreen({Key? key}) : super(key: key);

  @override
  _AlbumScreenState createState() => _AlbumScreenState();
}

class _AlbumScreenState extends State<AlbumScreen> {
  @override
  void initState() {
    super.initState();
    final albumCubit = context.read<AlbumCubit>();
    albumCubit.getAlbumList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AlbumCubit, AlbumState>(
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
            itemCount: state.albums.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
          );
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
