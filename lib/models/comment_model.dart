import 'comment_pictures.dart';

class ShopComment {
  int? commentId;
  int? shopId;
  int? userId;
  String? content;
  double? grade;
  String? time;
  String? keyword;
  int? picturecount;
  late List<CommentPictures> _pictures;

  List<CommentPictures> get pictures => _pictures;

  ShopComment(
      {required this.commentId,
      required this.shopId,
      required this.userId,
      required this.content,
      required this.grade,
      required this.time,
      required this.keyword,
      required this.picturecount,
      required pictures});

  ShopComment.fromJson(Map<String, dynamic> json) {
    commentId = json['id'];
    shopId = json['shop_id'];
    userId = json['user_id'];
    content = json['content'];
    grade = json['grade'];
    time = json['time'];
    keyword = json['keyword'];
    picturecount = json['picturecount'];
    if (json['pictures'] != null) {
      _pictures = <CommentPictures>[];
      json['pictures'].forEach((v) {
        pictures!.add(new CommentPictures.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.commentId;
    data['shop_id'] = this.shopId;
    data['user_id'] = this.userId;
    data['content'] = this.content;
    data['grade'] = this.grade;
    data['time'] = this.time;
    data['keyword'] = this.keyword;
    data['picturecount'] = this.picturecount;
    if (this.pictures != null) {
      data['pictures'] = this.pictures!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
