class CommentPictures {
  int? pictureId;
  int? commentId;
  String? pictureLink;
  String? time;

  CommentPictures(
      {this.pictureId, this.commentId, this.pictureLink, this.time});

  CommentPictures.fromJson(Map<String, dynamic> json) {
    pictureId = json['picture_id'];
    commentId = json['comment_id'];
    pictureLink = json['picture_link'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['picture_id'] = this.pictureId;
    data['comment_id'] = this.commentId;
    data['picture_link'] = this.pictureLink;
    data['time'] = this.time;
    return data;
  }
}
