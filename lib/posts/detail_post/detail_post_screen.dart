import 'dart:convert';

import 'package:eclipse_task/detail_user/user_post/model/posts_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DetailPostScreen extends StatefulWidget {
  final Post post;

  const DetailPostScreen({required this.post, Key? key}) : super(key: key);

  @override
  _DetailPostScreenState createState() => _DetailPostScreenState();
}

class _DetailPostScreenState extends State<DetailPostScreen> {
  bool _showBottomSheet = false;
  TextEditingController titleController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text('User Id: ${widget.post.userId}'),
              const SizedBox(
                height: 10,
              ),
              Text('Title: ${widget.post.title}'),
              const SizedBox(
                height: 10,
              ),
              Text('Body: ${widget.post.body}'),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _showBottomSheet = true;
          });
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
      bottomSheet: _showBottomSheet
          ? BottomSheet(
          elevation: 10,
          backgroundColor: Colors.amber,
          onClosing: () {
            // Do something
          },
          builder: (BuildContext ctx) =>
              Container(
                width: double.infinity,
                height: 250,
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: titleController,
                        keyboardType: TextInputType.text,
                        decoration:
                        const InputDecoration(labelText: 'title'),
                      ),
                      TextFormField(
                        controller: bodyController,
                        keyboardType: TextInputType.text,
                        decoration:
                        const InputDecoration(labelText: 'body'),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            setState(() {
                              createComment(widget.post.userId,
                                  titleController.text, bodyController.text);
                              _showBottomSheet = false;
                            });
                          },
                          child: const Text('Submit'))
                    ],
                  ),
                ),
              ))
          : null,
    );
  }

  Future<void> createComment(int userId, String title, String body) async {
    final response = await http.post(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'title': title,
        'body': body,
        'userId': userId
      }),
    );

    if (response.statusCode == 201) {
      debugPrint('Post was created');
    } else {
      throw Exception('Failed to create post.');
    }
  }
}
