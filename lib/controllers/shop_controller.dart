import 'package:get/get.dart';
import 'package:goforcate_app/models/comment_body.dart';
import 'package:goforcate_app/models/comment_model.dart';
import 'package:goforcate_app/models/response_model.dart';
import 'package:goforcate_app/models/shop_comment_list.dart';

import '../data/repository/shop_repo.dart';
import '../models/shop_model.dart';

class ShopController extends GetxController implements GetxService {
  final ShopRepo shopRepo;

  ShopController({required this.shopRepo});

  bool _isLoading1 = false;
  bool _isLoading2 = false;
  bool _isLoading3 = false;
  late ShopModel _shopModel;
  late ShopCommentList _shopCommentList;
  late ShopComment _shopComment;

  bool get isLoading1 => _isLoading1;

  bool get isLoading2 => _isLoading2;

  bool get isLoading3 => _isLoading3;

  ShopModel get shopModel => _shopModel;

  ShopCommentList get shopCommentList => _shopCommentList;

  ShopComment get shopComment => _shopComment;

  Future<ResponseModel> getShopInfo(int shopId) async {
    Response response = await shopRepo.getShopInfo(shopId);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      _shopModel = ShopModel.fromJson(response.body);
      print("Get shop: " + _shopModel.name!);
      _isLoading1 = true;
      responseModel = ResponseModel(true, response.toString());
    } else {
      responseModel = ResponseModel(false, response.body['message']);
    }
    update();
    return responseModel;
  }


  Future<ResponseModel> getShopCommentList(int shopId) async {
    Response response = await shopRepo.getShopCommentList(shopId);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      _shopCommentList = ShopCommentList.fromJson(response.body);
      print("Get shopcommentlist: " + _shopModel.name!);
      update();
      _isLoading2 = true;
      responseModel = ResponseModel(true, response.toString());
    } else {
      responseModel = ResponseModel(false, response.body['message']);
    }
    update();
    return responseModel;
  }

  Future<ResponseModel> getShopComment(int commentId) async {
    Response response = await shopRepo.getShopComment(commentId);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      _shopComment = ShopComment.fromJson(response.body);
      print("Get shopcomment: " + _shopModel.name!);
      update();
      _isLoading3 = true;
      responseModel = ResponseModel(true, response.toString());
    } else {
      responseModel = ResponseModel(false, response.body['message']);
    }
    update();
    return responseModel;
  }

  Future<ResponseModel> releaseComment(CommentBody commentBody) async {
    Response response = await shopRepo.releaseComment(commentBody);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      print("Releasing Comment");
      responseModel =
          ResponseModel(true, response.body['commentId'].toString());
    } else {
      responseModel = ResponseModel(false, response.body['message']);
    }
    update();
    return responseModel;
  }
}
