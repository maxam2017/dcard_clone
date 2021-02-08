class PostModel {
  int id;
  String title;
  String excerpt;
  String forumName;
  String forumAlias;
  String gender;
  String school;
  PostModel(
      {this.id,
      this.title,
      this.excerpt,
      this.forumAlias,
      this.forumName,
      this.gender,
      this.school});

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
        id: json['id'],
        title: json['title'],
        excerpt: json['excerpt'],
        forumAlias: json['forumAlias'],
        forumName: json['forumName'],
        gender: json['gender'],
        school: json['school']);
  }
}
