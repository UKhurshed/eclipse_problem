import 'package:eclipse_task/detail_user/user_post/model/album_model.dart';
import 'package:eclipse_task/detail_user/user_post/model/posts_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

abstract class PostRepository {
  Future<List<Post>> getUserPostByIndex(int id);

  Future<List<Post>> getUserPost();

  Future<List<Album>> getUserAlbumByIndex(int id);

  Future<List<Album>> getUserAlbum();
}

class PostRepositoryImpl implements PostRepository {
  static const postBaseUrl = "https://jsonplaceholder.typicode.com/posts";
  static const postAlbumUrl = "https://jsonplaceholder.typicode.com/albums";
  Future<SharedPreferences> prefs = SharedPreferences.getInstance();

  @override
  Future<List<Post>> getUserPostByIndex(int id) async {
    final SharedPreferences preferences = await prefs;

    final postsPref = preferences.getString('posts') ?? '';

    try {
      if (postsPref.isNotEmpty) {
        debugPrint('Posts preferences worked');
        List<dynamic> jsonResponse = jsonDecode(postsPref);
        List<Post> posts =
            jsonResponse.map((post) => Post.fromJson(post)).toList();

        List<Post> resultPosts =
            posts.where((element) => element.userId == id).toList();

        return resultPosts;
      } else {
        var response = await http.get(Uri.parse(postAlbumUrl));
        if (response.statusCode == 200) {
          List<dynamic> jsonResponse = jsonDecode(response.body);
          debugPrint('$jsonResponse type: ${jsonResponse.runtimeType}');
          List<Post> users =
              jsonResponse.map((data) => Post.fromJson(data)).toList();
          debugPrint('Posts length: ${users.length} $users');
          preferences.setString("posts", response.body);
          List<Post> resultPosts =
              users.where((element) => element.userId == id).toList();
          debugPrint('Post by $id index length: ${resultPosts.length} $users');
          return resultPosts;
        } else {
          throw Exception("Exception: ${response.statusCode}");
        }
      }
    } catch (error) {
      debugPrint("Post repository error: $error");
      rethrow;
    }
  }

  @override
  Future<List<Album>> getUserAlbumByIndex(int id) async {
    final SharedPreferences preferences = await prefs;

    final postsPref = preferences.getString('albums') ?? '';

    try {
      if (postsPref.isNotEmpty) {
        debugPrint('Albums preferences worked');
        List<dynamic> jsonResponse = jsonDecode(postsPref);
        List<Album> posts =
            jsonResponse.map((post) => Album.fromJson(post)).toList();

        List<Album> resultPosts =
            posts.where((element) => element.userId == id).toList();

        return resultPosts;
      } else {
        var response = await http.get(Uri.parse(postAlbumUrl));
        if (response.statusCode == 200) {
          List<dynamic> jsonResponse = jsonDecode(response.body);
          debugPrint('$jsonResponse type: ${jsonResponse.runtimeType}');
          List<Album> users =
              jsonResponse.map((data) => Album.fromJson(data)).toList();
          debugPrint('Albums length: ${users.length} $users');
          preferences.setString("albums", response.body);
          List<Album> resultPosts =
              users.where((element) => element.userId == id).toList();
          debugPrint('Album by $id index length: ${resultPosts.length} $users');
          return resultPosts;
        } else {
          throw Exception("Exception: ${response.statusCode}");
        }
      }
    } catch (error) {
      debugPrint("Album repository error: $error");
      rethrow;
    }
  }

  @override
  Future<List<Post>> getUserPost() async {
    final SharedPreferences preferences = await prefs;

    final postsPref = preferences.getString('posts') ?? '';

    try {
      if (postsPref.isNotEmpty) {
        debugPrint('Posts preferences worked');
        List<dynamic> jsonResponse = jsonDecode(postsPref);
        List<Post> posts =
            jsonResponse.map((post) => Post.fromJson(post)).toList();

        return posts;
      } else {
        var response = await http.get(Uri.parse(postAlbumUrl));
        if (response.statusCode == 200) {
          List<dynamic> jsonResponse = jsonDecode(response.body);
          debugPrint('$jsonResponse type: ${jsonResponse.runtimeType}');
          List<Post> posts =
              jsonResponse.map((data) => Post.fromJson(data)).toList();
          debugPrint('Posts length: ${posts.length} $posts');
          preferences.setString("posts", response.body);
          return posts;
        } else {
          throw Exception("Exception: ${response.statusCode}");
        }
      }
    } catch (error) {
      debugPrint("Post repository error: $error");
      rethrow;
    }
  }

  @override
  Future<List<Album>> getUserAlbum() async{
    final SharedPreferences preferences = await prefs;

    final postsPref = preferences.getString('albums') ?? '';

    try {
      if (postsPref.isNotEmpty) {
        debugPrint('Albums preferences worked');
        List<dynamic> jsonResponse = jsonDecode(postsPref);
        List<Album> albums =
        jsonResponse.map((post) => Album.fromJson(post)).toList();

        return albums;
      } else {
        var response = await http.get(Uri.parse(postAlbumUrl));
        if (response.statusCode == 200) {
          List<dynamic> jsonResponse = jsonDecode(response.body);
          debugPrint('$jsonResponse type: ${jsonResponse.runtimeType}');
          List<Album> albums =
          jsonResponse.map((data) => Album.fromJson(data)).toList();
          debugPrint('Albums length: ${albums.length} $albums');
          preferences.setString("albums", response.body);
          return albums;
        } else {
          throw Exception("Exception: ${response.statusCode}");
        }
      }
    } catch (error) {
      debugPrint("Album repository error: $error");
      rethrow;
    }
  }
}
