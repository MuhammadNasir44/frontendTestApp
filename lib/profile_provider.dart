import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:testfrontendapp/base_view_model.dart';
import 'package:testfrontendapp/view_state.dart';

class ProfileProvider extends BaseViewModel {
  ProfileProvider() {
    initFun();
  }

  Future<void> initFun() async {
    await getPostApi();
  }

  List<Posts> postsList = [];

  void onLikeButtonTap(int index) {
    postsList[index].likeCount += 1;

    print("increaming like:");

    notifyListeners();
  }

  Future<void> getPostApi() async {
    try {
      setState(ViewState.busy);
      final String profileApiUrl = "https://jsonplaceholder.typicode.com/posts";

      final response = await http.get(Uri.parse(profileApiUrl));

      if (response.statusCode == 200) {
        // Successful GET request
        List<dynamic> decodedResponse = json.decode(response.body);
        List<Posts> posts =
            decodedResponse.map((json) => Posts.fromJson(json)).toList();

        postsList = posts;
      }
      notifyListeners();

      setState(ViewState.idle);
    } catch (error) {
      // Handle network or other errors
      print("Error fetching post data: $error");
    }
  }
}

class Posts {
  int? userId;
  int? id;
  String? title;
  String? body;
  int likeCount = 0; // Added likeCount property

  Posts({this.userId, this.id, this.title, this.body});

  Posts.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['id'] = this.id;
    data['title'] = this.title;
    data['body'] = this.body;
    return data;
  }
}
