import 'package:dcard_clone/adapter/store.dart';
import 'package:dcard_clone/models/post.dart';
import 'package:flutter/material.dart';

FromJsonFunc<PostModel> fromJson = (json) => PostModel.fromJson(json);
SelectIdFunc<PostModel> selectId = (post) => post.id.toString();

class PostProvider extends StoreAdapter<PostModel> with ChangeNotifier {
  PostProvider()
      : super(
          fromJson = fromJson,
          selectId = selectId,
        );

  Future<void> listPost([Map<String, dynamic> query]) async {
    await super.list('/_api/posts', query);
    notifyListeners();
  }
}
