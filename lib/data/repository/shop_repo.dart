import 'package:get/get.dart';
import 'package:goforcate_app/data/api/api_client.dart';
import 'package:goforcate_app/utils/app_constants.dart';

import '../../models/comment_body.dart';

class ShopRepo extends GetxService {
  final ApiClient apiClient;

  ShopRepo({
    required this.apiClient,
  });

  Future<Response> getShopInfo(int shopId) async {
    return await apiClient
        .postData(Appconstants.QUERY_SHOP_URI, {"shopId": shopId});
  }

  Future<Response> getShopCommentList(int shopId) async {
    return await apiClient
        .postData(Appconstants.QUERY_SHOPCOMMENT_LIST_URI, {"shopId": shopId});
  }

  Future<Response> getShopComment(int commentId) async {
    return await apiClient
        .postData(Appconstants.QUERY_SHOPCOMMEN_URI, {"commentId": commentId});
  }

  Future<Response> releaseComment(CommentBody commentBody) async {
    return await apiClient.postData(
        Appconstants.COMMENT_RELEASE_URI, commentBody.toJson());
  }
}
