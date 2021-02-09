import 'package:dcard_clone/models/api.dart';
import 'package:dcard_clone/models/reaction.dart';
import 'package:flutter/material.dart';

class ReactionProvider with ChangeNotifier {
  // List<String> index = [];
  Map<String, ReactionModel> store = {};
  bool loading = false;
  bool fetched = false;
  ApiModel api = ApiModel();

  fetchData() async {
    loading = true;
    final payload = await api.fetch('https://dcard.tw/_api/reactions');
    Iterable list = payload;
    store = new Map.fromIterable(list,
        key: (item) => ReactionModel.fromJson(item).id,
        value: (item) => ReactionModel.fromJson(item));

    loading = false;
    fetched = true;
    notifyListeners();
  }
}
