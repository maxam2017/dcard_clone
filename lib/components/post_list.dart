import 'package:dcard_clone/components/post_entry.dart';
import 'package:dcard_clone/providers/post_provider.dart';
import 'package:dcard_clone/providers/reaction_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostList extends StatefulWidget {
  final popular;
  PostList([this.popular]);

  @override
  _PostListState createState() => _PostListState(this.popular);
}

class _PostListState extends State<PostList> {
  final popular;
  _PostListState([this.popular]);

  @override
  void initState() {
    super.initState();
    final postProvider = Provider.of<PostProvider>(context, listen: false);
    if (postProvider.indices.length == 0) {
      postProvider.listPost({
        "popular": this.popular,
      });
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
    final entries =
        postProvider.indices.map((id) => postProvider.store[id]).toList();

    if (postProvider.loading && !postProvider.fetched)
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
                "before": postProvider.indices.last,
              });
            }

            return PostEntry(post: entries[index]);
          }),
      onRefresh: () => postProvider.listPost({
        "popular": this.popular,
      }),
    );
  }
}
