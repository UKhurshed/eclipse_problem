import 'package:eclipse_task/detail_user/detail_user_screen.dart';
import 'package:eclipse_task/users/cubit/users_cubit.dart';
import 'package:eclipse_task/users/model/users.dart';
import 'package:eclipse_task/users/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserInitScreen extends StatelessWidget {
  const UserInitScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UsersCubit(UserRepositoryImpl()),
      child: const UserScreen(),
    );
  }
}

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  void initState() {
    super.initState();
    final userCubit = context.read<UsersCubit>();
    userCubit.getUsersCubit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Users'),
        ),
        body: BlocBuilder<UsersCubit, UsersState>(
          builder: (context, state) {
            if (state is UserError) {
              return const Center(
                child: Text("error has occurred"),
              );
            }
            if (state is UsersInitial) {
              return loadingIndicator();
            }
            if (state is UserLoading) {
              return loadingIndicator();
            }
            if (state is UserLoaded) {
              return ListView.separated(
                  separatorBuilder: (context, index) {
                    return const Divider(
                      height: 2.0,
                    );
                  },
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: state.users.length,
                  itemBuilder: (context, index) {
                    User userItem = state.users[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    DetailUserScreenInit(user: userItem)));
                      },
                      child: ListTile(
                        title: Text(userItem.name),
                        leading: Text(userItem.username),
                      ),
                    );
                  });
            } else {
              return const Center(
                child: Text("error has occurred"),
              );
            }
          },
        ));
  }

  Widget loadingIndicator() {
    return const Center(child: CircularProgressIndicator());
  }
}
