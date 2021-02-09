class ReactionModel {
  String id;
  String thumbnail;

  ReactionModel({this.id, this.thumbnail});

  factory ReactionModel.fromJson(Map<String, dynamic> json) {
    return ReactionModel(id: json['id'], thumbnail: json['thumbnail']);
  }
}
