import 'package:dcard_clone/models/post.dart';
import 'package:flutter/material.dart';

class PostEntry extends StatefulWidget {
  final PostModel post;

  const PostEntry({
    Key key,
    @required this.post,
  }) : super(key: key);

  @override
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostEntry> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child:
                        CircleAvatar(backgroundColor: Colors.grey, radius: 10),
                  ),
                  Text(widget.post.forumName ?? '',
                      style: TextStyle(color: Colors.black54)),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 4),
                child: Text(
                  widget.post.title ?? '',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                widget.post.excerpt ?? '',
                style: TextStyle(
                  fontSize: 15,
                  color: Color(0xAA000000),
                ),
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(color: Color(0x10000000), width: 8))));
  }
}
