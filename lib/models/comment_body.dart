class CommentBody {
  int shopId;
  double grade;
  String comment;
  List<String> imagesUrl;

  CommentBody(
      {required this.shopId,
      required this.comment,
      required this.imagesUrl,
      required this.grade});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["shopId"] = this.shopId;
    data["comment"] = this.comment;
    data["imageUrl"] = this.imagesUrl;
    data['grade'] = this.grade;
    return data;
  }
}
