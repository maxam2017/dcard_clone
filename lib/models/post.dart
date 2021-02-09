class PostModel {
  int id;
  String title;
  String excerpt;
  String forumName;
  String forumAlias;
  String gender;
  String school;
  String department;
  bool withNickname;
  bool withImages;
  List<MediaMeta> mediaMeta;
  int likeCount;
  int commentCount;
  List<Reaction> reactions;

  PostModel(
      {this.id,
      this.title,
      this.excerpt,
      this.forumAlias,
      this.forumName,
      this.gender,
      this.school,
      this.withNickname,
      this.department,
      this.withImages,
      this.mediaMeta,
      this.reactions,
      this.likeCount,
      this.commentCount});

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
        id: json['id'],
        title: json['title'],
        excerpt: json['excerpt'],
        forumAlias: json['forumAlias'],
        forumName: json['forumName'],
        gender: json['gender'],
        school: json['school'],
        withNickname: json['withNickname'],
        department: json['department'],
        withImages: json['withImages'],
        mediaMeta: new List<MediaMeta>.from(
            json['mediaMeta'].map((i) => MediaMeta.fromJson(i))),
        likeCount: json['likeCount'],
        commentCount: json['commentCount'],
        reactions: new List<Reaction>.from(
            json['reactions'].map((i) => Reaction.fromJson(i))));
  }
}

class MediaMeta {
  String thumbnail;
  MediaMeta({this.thumbnail});

  factory MediaMeta.fromJson(Map<String, dynamic> json) {
    return MediaMeta(thumbnail: json['thumbnail']);
  }
}

class Reaction {
  String id;
  Reaction({this.id});
  factory Reaction.fromJson(Map<String, dynamic> json) {
    return Reaction(id: json['id']);
  }
}
