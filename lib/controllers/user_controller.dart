import 'package:get/get.dart';
import 'package:goforcate_app/models/response_model.dart';
import 'package:goforcate_app/models/shop_list.dart';
import 'package:goforcate_app/models/user_body.dart';
import 'package:goforcate_app/models/user_list.dart';
import 'package:goforcate_app/models/user_model.dart';

import '../data/repository/user_repo.dart';
import '../models/shop_comment_list.dart';

class UserController extends GetxController implements GetxService {
  final UserRepo userRepo;

  UserController({required this.userRepo});

  bool _isLoading1 = false;
  bool _isLoading2 = false;
  bool _isLoading3 = false;
  late UserModel _userModel;
  List<dynamic> _userList = [];
  List<dynamic> _searchUserList = [];
  List<dynamic> _userFavourite = [];
  late ShopCommentList _userCommentList;

  bool get isLoading1 => _isLoading1;

  bool get isLoading2 => _isLoading2;

  bool get isLoading3 => _isLoading3;

  UserModel get userModel => _userModel;

  List<dynamic> get userList => _userList;

  List<dynamic> get searchUserList => _searchUserList;

  List<dynamic> get userFavourite => _userFavourite;

  ShopCommentList get userCommentList => _userCommentList;

  Future<ResponseModel> getUserInfo() async {
    Response response = await userRepo.getUserInfo();
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      _userModel = UserModel.fromJson(response.body);
      responseModel = ResponseModel(true, "成功获取用户信息");
    } else {
      responseModel = ResponseModel(false, response.body['message']);
    }
    _isLoading1 = true;
    update();
    return responseModel;
  }

  Future<ResponseModel> getUserList() async {
    Response response = await userRepo.getUserList();
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      print("got userlist");
      _userList = [];
      _userList.addAll(UserList.fromJson(response.body).users);
      responseModel = ResponseModel(true, "成功获取用户列表");
    } else {
      responseModel = ResponseModel(false, response.body['message']);
    }
    _isLoading1 = true;
    update();
    return responseModel;
  }

  Future<ResponseModel> getSearchUser(String keyword) async {
    Response response = await userRepo.getSearchUser(keyword);
    late ResponseModel responseModel;
    print(response.statusCode);
    if (response.statusCode == 200) {
      print("got search user");
      _searchUserList = [];
      _searchUserList.addAll(UserList.fromJson(response.body).users);
      update();
      responseModel = ResponseModel(true, "成功搜索用户列表");
    } else {
      responseModel = ResponseModel(false, "无法搜索用户列表");
    }
    return responseModel;
  }

  Future<ResponseModel> getUserFavourite(int userId) async {
    Response response = await userRepo.getUserFavourite(userId);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      _userFavourite = [];
      _userFavourite.addAll(ShopList.fromJson(response.body).shops);
      print("Get user favourite");
      update();
      _isLoading2 = true;
      responseModel = ResponseModel(true, response.toString());
    } else {
      responseModel = ResponseModel(false, response.body['message']);
    }
    update();
    return responseModel;
  }

  Future<ResponseModel> createFavourite(int shopId) async {
    Response response = await userRepo.createFavourite(shopId);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      print("create user favourite");
      update();
      _isLoading2 = true;
      responseModel = ResponseModel(true, "success");
    } else {
      responseModel = ResponseModel(false, response.body['message']);
    }
    update();
    return responseModel;
  }

  Future<ResponseModel> deleteFavourite(int shopId) async {
    Response response = await userRepo.deleteFavourite(shopId);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      print("delete user favourite");
      update();
      _isLoading2 = true;
      responseModel = ResponseModel(true, "success");
    } else {
      responseModel = ResponseModel(false, response.body['message']);
    }
    update();
    return responseModel;
  }

  Future<ResponseModel> getUserComment(int userId) async {
    Response response = await userRepo.getUserComment(userId);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      _userCommentList = ShopCommentList.fromJson(response.body);
      print("Get usercommentlist");
      update();
      _isLoading3 = true;
      responseModel = ResponseModel(true, response.toString());
    } else {
      responseModel = ResponseModel(false, response.body['message']);
    }
    update();
    return responseModel;
  }

  Future<ResponseModel> updateUserComment(int commentId) async {
    Response response = await userRepo.updateUserComment(commentId);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      print("create user comment");
      update();
      _isLoading2 = true;
      responseModel = ResponseModel(true, "success");
    } else {
      responseModel = ResponseModel(false, response.body['message']);
    }
    update();
    return responseModel;
  }

  Future<ResponseModel> deleteUserComment(int commentId) async {
    Response response = await userRepo.deleteUserComment(commentId);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      print("delete user comment");
      update();
      _isLoading2 = true;
      responseModel = ResponseModel(true, "success");
    } else {
      responseModel = ResponseModel(false, response.body['message']);
    }
    update();
    return responseModel;
  }

  Future<ResponseModel> updateUserInfo(UserBody userBody) async {
    Response response = await userRepo.updateUserInfo(userBody);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      print("Saving UserInfo");
      responseModel = ResponseModel(true, "Success");
    } else {
      responseModel = ResponseModel(false, response.body['message']);
    }
    update();
    return responseModel;
  }

  Future<ResponseModel> updateUserArea(int areaId) async {
    Response response = await userRepo.updateUserArea(areaId);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      print("Saving UserArea");
      responseModel = ResponseModel(true, "Success");
    } else {
      responseModel = ResponseModel(false, response.body['message']);
    }
    update();
    return responseModel;
  }

  Future<ResponseModel> updateUserAvatar(String imageUrl) async {
    Response response = await userRepo.updateUserAvatar(imageUrl);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      print("Saving UserAvatar");
      responseModel = ResponseModel(true, "Success");
    } else {
      responseModel = ResponseModel(false, response.body['message']);
    }
    update();
    return responseModel;
  }

  Future<ResponseModel> updateUserPhone(String phone) async {
    Response response = await userRepo.updateUserPhone(phone);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      print("Saving UserPhone");
      responseModel = ResponseModel(true, "Success");
    } else {
      responseModel = ResponseModel(false, response.body['message']);
    }
    update();
    return responseModel;
  }
}
