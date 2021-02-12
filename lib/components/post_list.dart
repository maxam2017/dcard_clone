import 'package:dcard_clone/adapter/pagination.dart';
import 'package:dcard_clone/components/post_entry.dart';
import 'package:dcard_clone/models/post.dart';
import 'package:dcard_clone/providers/post_provider.dart';
import 'package:dcard_clone/providers/reaction_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostList extends StatefulWidget {
  final bool popular;
  // final String query;
  PostList({
    this.popular,
    // this.query,
  });

  @override
  _PostListState createState() => _PostListState(popular: this.popular);
}

class _PostListState extends State<PostList> {
  final bool popular;
  _PostListState({this.popular});

  Pagination<PostModel> pagination;

  @override
  void initState() {
    super.initState();
    final postProvider = Provider.of<PostProvider>(context, listen: false);
    final query = {
      "popular": this.popular,
    };
    pagination = postProvider.selectPagination(query);
    if (pagination.indices.length == 0) {
      postProvider.listPost(query);
    }

    final reactionProvider =
        Provider.of<ReactionProvider>(context, listen: false);
    if (!reactionProvider.fetched) {
      reactionProvider.listReaction();
    }
  }

  @override
  Widget build(BuildContext context) {
    final postProvider = Provider.of<PostProvider>(context);
    final query = {
      "popular": this.popular,
    };
    final entries = postProvider.selectEntryList(query);

    if (pagination.loading && !pagination.fetched)
      return Container(
        padding: const EdgeInsets.all(16),
        alignment: Alignment.topCenter,
        child: CircularProgressIndicator(),
      );

    return RefreshIndicator(
      child: ListView.builder(
          itemCount: entries.length,
          itemBuilder: (context, index) {
            if (index == entries.length - 5) {
              postProvider.listPost({
                "popular": this.popular,
                "before": pagination.indices.last,
              });
            }

            return PostEntry(post: entries[index]);
          }),
      onRefresh: () => postProvider.listPost({
        "popular": this.popular,
        "refresh": true,
      }),
    );
  }
}
