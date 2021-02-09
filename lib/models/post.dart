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
      this.mediaMeta});

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
            json['mediaMeta'].map((i) => MediaMeta.fromJson(i))));
  }
}

class MediaMeta {
  String thumbnail;
  MediaMeta({this.thumbnail});

  factory MediaMeta.fromJson(Map<String, dynamic> json) {
    return MediaMeta(thumbnail: json['thumbnail']);
  }
}
