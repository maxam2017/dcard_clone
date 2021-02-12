import 'package:dcard_clone/adapter/pagination.dart';
import 'package:dcard_clone/models/post.dart';
import 'package:flutter/material.dart';

FromJsonFunc<PostModel> fromJson = (json) => PostModel.fromJson(json);
SelectIdFunc<PostModel> selectId = (post) => post.id.toString();
GetPaginationKeyFunc getPaginationKey =
    (query) => 'popular: ${query['popular']}';

class PostProvider extends PaginationAdapter<PostModel> with ChangeNotifier {
  PostProvider()
      : super(
          fromJson = fromJson,
          selectId = selectId,
          getPaginationKey = getPaginationKey,
        );

  Future<void> listPost([Map<String, dynamic> query]) async {
    await super.list('/_api/posts', query);
    notifyListeners();
  }
}
