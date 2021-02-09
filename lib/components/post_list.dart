import 'package:dcard_clone/components/post_entry.dart';
import 'package:dcard_clone/providers/post_provider.dart';
import 'package:dcard_clone/providers/reaction_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostList extends StatefulWidget {
  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  @override
  void initState() {
    super.initState();
    final postProvider = Provider.of<PostProvider>(context, listen: false);
    if (postProvider.entries.length == 0) {
      postProvider.fetchData();
    }

    final reactionProvider =
        Provider.of<ReactionProvider>(context, listen: false);
    if (!reactionProvider.fetched) {
      reactionProvider.fetchData();
    }
  }

  @override
  Widget build(BuildContext context) {
    final postProvider = Provider.of<PostProvider>(context);
    final entries = postProvider.entries;

    if (postProvider.loading)
      return Container(
        padding: const EdgeInsets.all(16),
        alignment: Alignment.topCenter,
        child: CircularProgressIndicator(),
      );

    return RefreshIndicator(
      child: ListView(
          children: entries.map((entry) => PostEntry(post: entry)).toList()),
      onRefresh: () => postProvider.fetchData(),
    );
  }
}
