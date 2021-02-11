import 'package:dcard_clone/adapter/store.dart';
import 'package:dcard_clone/models/reaction.dart';
import 'package:flutter/material.dart';

FromJsonFunc<ReactionModel> fromJson = (json) => ReactionModel.fromJson(json);
SelectIdFunc<ReactionModel> selectId = (reaction) => reaction.id;

class ReactionProvider extends StoreAdapter<ReactionModel> with ChangeNotifier {
  ReactionProvider()
      : super(
          fromJson = fromJson,
          selectId = selectId,
        );

  Future<void> listReaction() async {
    await super.list('/_api/reactions');
    notifyListeners();
  }
}
