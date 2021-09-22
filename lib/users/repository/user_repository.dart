import 'dart:convert';

import 'package:eclipse_task/users/model/users.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

abstract class UserRepository {
  Future<List<User>> getUsers();
}

class UserRepositoryImpl implements UserRepository {
  static const baseUrl = "https://jsonplaceholder.typicode.com/users";
  Future<SharedPreferences> prefs = SharedPreferences.getInstance();

  @override
  Future<List<User>> getUsers() async {
    final SharedPreferences preferences = await prefs;

    var flag = preferences.getString("users") ?? '';

    try {
      if (flag.isNotEmpty) {
        debugPrint('User preferences worked');
        List<dynamic> resp = jsonDecode(flag);
        debugPrint('$resp type: ${resp.runtimeType}');
        List<User> users = resp.map((data) => User.fromJson(data)).toList();
        debugPrint('Length: ${users.length} $users');
        return users;
      } else {
        var response = await http.get(Uri.parse(baseUrl));
        if (response.statusCode == 200) {
          List<dynamic> resp = jsonDecode(response.body);
          debugPrint('$resp type: ${resp.runtimeType}');
          List<User> users = resp.map((data) => User.fromJson(data)).toList();
          debugPrint('Length: ${users.length} $users');
          preferences.setString("users", response.body);
          return users;
        } else {
          throw Exception("Exception: ${response.statusCode}");
        }
      }
    } catch (error) {
      debugPrint("Repository error: $error");
      rethrow;
    }
  }
}
