import 'package:eclipse_task/posts/posts_screen.dart';
import 'package:eclipse_task/users/user_screen.dart';
import 'package:flutter/material.dart';

import 'album/album_screen.dart';
import 'comments/comments_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> pageList = [];

  @override
  void initState() {
    super.initState();
    pageList.add(const UserInitScreen());
    pageList.add(const PostsScreenInit());
    pageList.add(const AlbumScreenInit());
    pageList.add(const CommentsScreenInit());
  }

  final PageStorageBucket bucket = PageStorageBucket();
  int _currentIndex = 0;

  Widget _bottomNavigationBar(int currentIndex) => BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.red,
          unselectedItemColor: Colors.green,
          onTap: (int index) => setState(() => _currentIndex = index),
          currentIndex: currentIndex,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Users'),
            BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: "Posts"),
            // BottomNavigationBarItem(icon: Icon(Icons.monetization_on), label: ''),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.photo_album,
                ),
                label: 'Albums'),
            BottomNavigationBarItem(
                icon: Icon(Icons.comment), label: "Comments"),
          ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _bottomNavigationBar(_currentIndex),
      body: IndexedStack(
        index: _currentIndex,
        children: pageList,
      ),
    );
  }
}
