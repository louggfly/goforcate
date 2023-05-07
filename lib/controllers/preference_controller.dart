import 'package:get/get.dart';
import 'package:goforcate_app/controllers/user_controller.dart';

import '../data/repository/area_repo.dart';
import '../data/repository/preference_repo.dart';
import '../models/area_list.dart';
import '../models/category_list.dart';
import '../models/preference_list.dart';
import '../models/response_model.dart';

class PreferenceController extends GetxController {
  final PreferenceRepo preferenceRepo;

  PreferenceController({required this.preferenceRepo});

  List<dynamic> _categoryList = [];
  List<dynamic> _preferenceList = [];

  List<dynamic> get categoryList => _categoryList;
  List<dynamic> get preferenceList => _preferenceList;

  Future<ResponseModel> getCategoryList() async {
    Response response = await preferenceRepo.getCategoryList();
    late ResponseModel responseModel;
    print(response.statusCode);
    if (response.statusCode == 200) {
      print("got categorylist");
      _categoryList = [];
      _categoryList.addAll(CategoryList.fromJson(response.body).categories);
      update();
      responseModel = ResponseModel(true, "成功获取类别列表");
    } else {
      responseModel = ResponseModel(false, "无法获取类别列表");
    }
    return responseModel;
  }

  Future<ResponseModel> getUserPreference() async {
    Response response = await preferenceRepo.getUserPreference();
    late ResponseModel responseModel;
    print(response.statusCode);
    if (response.statusCode == 200) {
      print("got user preference");
      _preferenceList = [];
      _preferenceList.addAll(PreferenceList.fromJson(response.body).preferences);
      update();
      responseModel = ResponseModel(true, "成功获取用户偏好列表");
    } else {
      responseModel = ResponseModel(false, "无法获取用户偏好列表");
    }
    return responseModel;
  }

  Future<ResponseModel> createPreference(int categoryId) async {
    Response response = await preferenceRepo.createPreference(categoryId);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      print("create user preference");
      update();
      responseModel = ResponseModel(true, "success");
    } else {
      responseModel = ResponseModel(false, response.body['message']);
    }
    update();
    return responseModel;
  }

  Future<ResponseModel> deletePreference(int categoryId) async {
    Response response = await preferenceRepo.deletePreference(categoryId);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      print("delete user preference");
      update();
      responseModel = ResponseModel(true, "success");
    } else {
      responseModel = ResponseModel(false, response.body['message']);
    }
    update();
    return responseModel;
  }
}
