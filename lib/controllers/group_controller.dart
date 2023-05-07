import 'package:get/get.dart';
import 'package:goforcate_app/models/response_model.dart';

import '../data/repository/group_repo.dart';
import '../models/group_body.dart';
import '../models/group_list.dart';
import '../models/group_model.dart';

class GroupController extends GetxController implements GetxService {
  final GroupRepo groupRepo;

  GroupController({required this.groupRepo});

  List<dynamic> _groupList = [];
  late GroupModel _groupModel;

  List<dynamic> get groupList => _groupList;

  GroupModel get groupModel => _groupModel;

  Future<ResponseModel> getGroupList() async {
    Response response = await groupRepo.getGroupList();
    late ResponseModel responseModel;
    print(response.statusCode);
    if (response.statusCode == 200) {
      print("got grouplist");
      _groupList = [];
      _groupList.addAll(GroupList.fromJson(response.body).groups);
      update();
      responseModel = ResponseModel(true, "成功获取店铺列表");
    } else {
      responseModel = ResponseModel(false, "无法获取店铺列表");
    }
    return responseModel;
  }

  Future<ResponseModel> createGroup(GroupBody groupBody) async {
    Response response = await groupRepo.createGroup(groupBody);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      print("Create Group");
      responseModel = ResponseModel(true, "Success");
    } else {
      responseModel = ResponseModel(false, response.body['message']);
    }
    update();
    return responseModel;
  }

  Future<ResponseModel> updateGroup(GroupBody groupBody, int groupId) async {
    Response response = await groupRepo.updateGroup(groupBody, groupId);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      print("Create Group");
      responseModel = ResponseModel(true, "Success");
    } else {
      responseModel = ResponseModel(false, response.body['message']);
    }
    update();
    return responseModel;
  }

  Future<ResponseModel> deleteGroup(int groupId) async {
    Response response = await groupRepo.deleteGroup(groupId);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      print("delete Group");
      responseModel = ResponseModel(true, "Success");
    } else {
      responseModel = ResponseModel(false, response.body['message']);
    }
    update();
    return responseModel;
  }

  List<dynamic> getGroupOnDate(String date) {
    List<dynamic> result = [];
    for (GroupModel group in _groupList) {
      if (group.reserve_at?.split("T")[0] == date) {
        result.add(group);
      }
    }
    return result;
  }

  Future<ResponseModel> getGroup(int groupId) async {
    late ResponseModel responseModel;
    for (GroupModel group in _groupList) {
      if (group.id == groupId) {
        _groupModel = group;
        print("Get Group: " + group.name!);
        responseModel = ResponseModel(true, "Success");
      }
    }
    responseModel = ResponseModel(false, "failed");
    return responseModel;
  }

  GroupModel getRecentGroup(){
    DateTime dateTime = DateTime.now();
    if (_groupList.isNotEmpty) {
      GroupModel recentGroup = _groupList[0];
      for (GroupModel group in _groupList){
        if(DateTime.parse(group.reserve_at!).isAfter(dateTime)){
          Duration duration1 = DateTime.parse(group.reserve_at!).difference(dateTime);
          Duration duration2 = DateTime.parse(recentGroup.reserve_at!).difference(dateTime);
          if(duration1.compareTo(duration2)>0){
            recentGroup = group;
          }
        }
      }
      return recentGroup;
    } else {
      return GroupModel(id: 0, name: '', shop_id: 1, leader_id: 0, reserve_at: '');
    }

  }
}
