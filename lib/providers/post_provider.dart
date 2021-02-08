import 'package:dcard_clone/models/api.dart';
import 'package:dcard_clone/models/post.dart';
import 'package:flutter/material.dart';

class PostProvider with ChangeNotifier {
  List<PostModel> entries = [];
  bool loading = false;
  ApiModel api = ApiModel();

  fetchData() async {
    loading = true;
    final payload = await api.fetch('https://dcard.tw/_api/posts?popular=true');
    Iterable list = payload;
    entries = list.map((json) => PostModel.fromJson(json)).toList();
    loading = false;
    notifyListeners();
  }
}
