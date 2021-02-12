import 'package:dcard_clone/models/post.dart';
import 'package:flutter/material.dart';

class ClassicContent extends StatelessWidget {
  final PostModel post;
  ClassicContent({Key key, @required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final title = post.title ?? '';
    final excerpt = post.excerpt ?? '';
    final withImages = post.withImages ?? false;
    final mediaMeta = post.mediaMeta;
    return Row(
      children: [
        Flexible(
          fit: FlexFit.tight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 4),
                child: Text(
                  title,
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                excerpt,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 15,
                  color: Color(0xAA000000),
                ),
              ),
            ],
          ),
        ),
        // thumbnail
        withImages
            ? Container(
                margin: EdgeInsets.only(left: 16),
                decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(8)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image(
                    width: 72,
                    height: 72,
                    image: NetworkImage(mediaMeta[0].thumbnail),
                    fit: BoxFit.cover,
                  ),
                ))
            : Container()
      ],
    );
  }
}
