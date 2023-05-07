import 'comment_model.dart';

class ShopCommentList {
  int? _commentcount;
  late List<ShopComment> _shopComments;

  List<ShopComment> get shopComments => _shopComments;

  ShopCommentList({required commentcount, required shopComments});

  ShopCommentList.fromJson(Map<String, dynamic> json) {
    _commentcount = json['commentcount'];
    if (json['comments'] != null) {
      _shopComments = <ShopComment>[];
      json['comments'].forEach((v) {
        _shopComments!.add(new ShopComment.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['commentcount'] = this._commentcount;
    if (this._shopComments != null) {
      data['comments'] = this._shopComments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
