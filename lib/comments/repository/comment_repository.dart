import 'dart:convert';

import 'package:eclipse_task/comments/model/comment.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

abstract class CommentRepository {
  Future<List<Comment>> getComment();
}

class CommentRepositoryImpl implements CommentRepository {
  static const baseUrl = "https://jsonplaceholder.typicode.com/comments";
  Future<SharedPreferences> prefs = SharedPreferences.getInstance();

  @override
  Future<List<Comment>> getComment() async {
    final SharedPreferences preferences = await prefs;

    var flag = preferences.getString("comment") ?? '';

    try {
      if (flag.isNotEmpty) {
        debugPrint('Comment preferences worked');
        List<dynamic> resp = jsonDecode(flag);
        debugPrint('$resp type: ${resp.runtimeType}');
        List<Comment> comments =
            resp.map((data) => Comment.fromJson(data)).toList();
        debugPrint('Length: ${comments.length} $comments');
        return comments;
      } else {
        var response = await http.get(Uri.parse(baseUrl));
        if (response.statusCode == 200) {
          List<dynamic> resp = jsonDecode(response.body);
          debugPrint('$resp type: ${resp.runtimeType}');
          List<Comment> comments =
              resp.map((data) => Comment.fromJson(data)).toList();
          debugPrint('Length: ${comments.length} $comments');
          preferences.setString("comment", response.body);
          return comments;
        } else {
          throw Exception("Exception: ${response.statusCode}");
        }
      }
    } catch (error) {
      debugPrint("Comment repository error: $error");
      rethrow;
    }
  }
}
