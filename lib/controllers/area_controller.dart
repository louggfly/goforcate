import 'package:get/get.dart';
import 'package:goforcate_app/controllers/user_controller.dart';

import '../data/repository/area_repo.dart';
import '../models/area_list.dart';
import '../models/response_model.dart';

class AreaController extends GetxController {
  final AreaRepo areaRepo;

  AreaController({required this.areaRepo});

  List<dynamic> _areaList = [];
  List<dynamic> _searchAreaList = [];

  List<dynamic> get areaList => _areaList;

  List<dynamic> get searchAreaList => _searchAreaList;

  Future<ResponseModel> getAreaList() async {
    Response response = await areaRepo.getAreaList();
    late ResponseModel responseModel;
    print(response.statusCode);
    if (response.statusCode == 200) {
      print("got arealist");
      _areaList = [];
      _areaList.addAll(AreaList.fromJson(response.body).areas);
      update();
      responseModel = ResponseModel(true, "成功获取地区列表");
    } else {
      responseModel = ResponseModel(false, "无法获取地区列表");
    }
    return responseModel;
  }

  Future<ResponseModel> getSearchArea(String keyword) async {
    Response response = await areaRepo.getSearchArea(keyword);
    late ResponseModel responseModel;
    print(response.statusCode);
    if (response.statusCode == 200) {
      print("got search area");
      _searchAreaList = [];
      _searchAreaList.addAll(AreaList.fromJson(response.body).areas);
      update();
      responseModel = ResponseModel(true, "成功搜索地区列表");
    } else {
      responseModel = ResponseModel(false, "无法搜索地区列表");
    }
    return responseModel;
  }

  int getAreaListLength() {
    return areaList.length;
  }

  String getUserArea() {
    int? userAreaId = Get.find<UserController>().userModel.areaId;
    return _areaList.firstWhere((element) => element.id == userAreaId).name;
  }
}
