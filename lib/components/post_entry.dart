import 'package:dcard_clone/models/post.dart';
import 'package:dcard_clone/models/reaction.dart';
import 'package:dcard_clone/providers/reaction_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class PostEntry extends StatefulWidget {
  final PostModel post;

  const PostEntry({
    Key key,
    @required this.post,
  }) : super(key: key);

  @override
  _PostWidgetState createState() => _PostWidgetState();
}

Map<String, String> genderToIconName = {
  'F': 'female',
  'M': 'male',
  'A': 'anoymous',
  'D': 'dcard'
};

class _PostWidgetState extends State<PostEntry> {
  @override
  Widget build(BuildContext context) {
    final reactionProvider = Provider.of<ReactionProvider>(context);
    final reactionStore = reactionProvider.store;

    final title = widget.post.title ?? '';
    final excerpt = widget.post.excerpt ?? '';
    final forumName = widget.post.forumName ?? '';
    final gender = widget.post.gender ?? 'A';
    final withNickname = widget.post.withNickname ?? true;
    final school = widget.post.school ?? '匿名';
    final department = widget.post.department;
    final withImages = widget.post.withImages ?? false;
    final mediaMeta = widget.post.mediaMeta;
    final reactions = (reactionProvider.fetched && !reactionProvider.loading)
        ? widget.post.reactions.take(3).map((item) => reactionStore[item.id])
        : <ReactionModel>[];
    final likeCount = widget.post.likeCount.toString();
    final commentCount = widget.post.commentCount.toString();

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
                      child: CircleAvatar(
                        radius: 10,
                        backgroundColor:
                            Color(gender == 'M' ? 0xFF006EA5 : 0xFFCB3A6B),
                        child: (withNickname && gender != 'D')
                            ? Text(department[0].toUpperCase(),
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ))
                            : SvgPicture.asset(
                                'assets/icons/${genderToIconName[gender]}.svg'),
                      ),
                    ),
                    Text('$forumName・$school',
                        style: TextStyle(color: Colors.black54, fontSize: 15)),
                  ],
                ),
                Row(
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
                ),
                Padding(
                    padding: EdgeInsets.only(top: 12),
                    child: Row(
                      children: [
                        ...reactions
                            .map((reaction) => Container(
                                  padding: EdgeInsets.only(right: 2),
                                  child: Image(
                                    width: 18,
                                    height: 18,
                                    image: NetworkImage(reaction.thumbnail),
                                    fit: BoxFit.cover,
                                  ),
                                ))
                            .toList(),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          likeCount,
                          style: TextStyle(
                            color: Colors.black38,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        SvgPicture.asset(
                          'assets/icons/comment.svg',
                          width: 18,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          commentCount,
                          style: TextStyle(
                            color: Colors.black38,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    )),
              ]),
        ),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(color: Color(0x10000000), width: 8))));
  }
}
