import 'package:get/get_connect/http/src/response/response.dart';
import 'package:goforcate_app/data/api/api_client.dart';
import 'package:goforcate_app/models/user_body.dart';
import 'package:goforcate_app/utils/app_constants.dart';

class UserRepo {
  final ApiClient apiClient;

  UserRepo({required this.apiClient});

  Future<Response> getUserInfo() async {
    return await apiClient.getData(Appconstants.USER_INFO_URI);
  }

  Future<Response> getUserList() async {
    return await apiClient.getData(Appconstants.USER_LIST_URI);
  }

  Future<Response> getSearchUser(String keyword) async {
    return await apiClient
        .postData(Appconstants.SEARCH_USER_URI, {"keyword": keyword});
  }

  Future<Response> getUserFavourite(int userId) async {
    return await apiClient
        .postData(Appconstants.USER_FAVOURITE_URI, {"userId": userId});
  }

  Future<Response> createFavourite(int shopId) async {
    return await apiClient
        .postData(Appconstants.USER_FAVOURITE_CREATE_URI, {"shopId": shopId});
  }

  Future<Response> deleteFavourite(int shopId) async {
    return await apiClient
        .postData(Appconstants.USER_FAVOURITE_DELETE_URI, {"shopId": shopId});
  }

  Future<Response> getUserComment(int userId) async {
    return await apiClient
        .postData(Appconstants.USER_COMMENT_URI, {"userId": userId});
  }

  Future<Response> updateUserComment(int commentId) async {
    return await apiClient
        .postData(Appconstants.COMMENT_UPDATE_URI, {"commentId": commentId});
  }

  Future<Response> deleteUserComment(int commentId) async {
    return await apiClient
        .postData(Appconstants.COMMENT_DELETE_URI, {"commentId": commentId});
  }

  Future<Response> updateUserInfo(UserBody userBody) async {
    return await apiClient.postData(
        Appconstants.USER_UPDATE_INFO_URI, userBody.toJson());
  }

  Future<Response> updateUserArea(int areaId) async {
    return await apiClient
        .postData(Appconstants.USER_UPDATE_AREA_URI, {"areaId": areaId});
  }

  Future<Response> updateUserAvatar(String imageUrl) async {
    return await apiClient
        .postData(Appconstants.USER_UPDATE_AVATAR_URI, {'imageUrl': imageUrl});
  }

  Future<Response> updateUserPhone(String phone) async {
    return await apiClient
        .postData(Appconstants.USER_UPDATE_PHONE_URI, {'phone': phone});
  }
}
