import 'package:dcard_clone/models/api.dart';
import 'package:dcard_clone/models/post.dart';
import 'package:flutter/material.dart';

const POST_API_ENDPOINT = 'https://dcard.tw/_api/posts';

class PostProvider with ChangeNotifier {
  List<PostModel> entries = [];
  bool loading = false;
  bool fetched = false;
  ApiModel api = ApiModel();

  fetchData() async {
    loading = true;
    final endpoint = entries.length == 0
        ? '$POST_API_ENDPOINT?popular=true'
        : '$POST_API_ENDPOINT?popular=true&before=${entries[entries.length - 1].id}';

    print(endpoint);
    final payload = await api.fetch(endpoint);
    Iterable list = payload;
    entries = [
      ...entries,
      ...list.map((json) => PostModel.fromJson(json)).toList(),
    ];
    loading = false;
    fetched = true;
    notifyListeners();
  }
}
