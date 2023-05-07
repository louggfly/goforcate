import 'package:get/get.dart';

import '../data/repository/commentlist_repo.dart';
import '../models/comment_model.dart';
import '../models/response_model.dart';
import '../models/shop_comment_list.dart';

class CommentListController extends GetxController {
  final CommentListRepo commentListRepo;

  CommentListController({required this.commentListRepo});

  List<dynamic> _commentList = [];
  List<dynamic> _searchCommentList = [];

  List<dynamic> get commentList => _commentList;

  List<dynamic> get searchCommentList => _searchCommentList;

  Future<ResponseModel> getCommentList() async {
    Response response = await commentListRepo.getCommentList();
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      print("got commentlist");
      _commentList = [];
      _commentList.addAll(ShopCommentList.fromJson(response.body).shopComments);
      update();
      responseModel = ResponseModel(true, "成功获取评论列表");
    } else {
      responseModel = ResponseModel(false, "无法获取评论列表");
    }
    return responseModel;
  }

  Future<ResponseModel> getSearchComment(String keyword) async {
    Response response = await commentListRepo.getSearchComment(keyword);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      print("got search commentlist");
      _searchCommentList = [];
      _searchCommentList
          .addAll(ShopCommentList.fromJson(response.body).shopComments);
      update();
      responseModel = ResponseModel(true, "成功获取搜索评论列表");
    } else {
      responseModel = ResponseModel(false, "无法获取搜索评论列表");
    }
    return responseModel;
  }

  int getCommentListLength() {
    return commentList.length;
  }

  ShopComment getCommentInfo(int commentId) {
    ShopComment comment = ShopComment(commentId: 0, shopId: 0, userId: 0, content: '', grade: 0, time: '', keyword: '', picturecount: 0, pictures: '');
    for(int i = 0; i < _commentList.length; i++) {
      if(commentId == _commentList[i].commentId){
        comment = _commentList[i];
      }
    }
    return comment;
  }
}
