import 'package:get/get.dart';

import '../../models/group_body.dart';
import '../../utils/app_constants.dart';
import '../api/api_client.dart';

class GroupRepo extends GetxService {
  final ApiClient apiClient;

  GroupRepo({
    required this.apiClient,
  });

  Future<Response> getGroupList() async {
    return await apiClient.getData(Appconstants.GROUP_LIST_URI);
  }

  Future<Response> createGroup(GroupBody groupBody) async {
    return await apiClient.postData(
        Appconstants.GROUP_CREATE_URI, groupBody.toJson());
  }

  Future<Response> updateGroup(GroupBody groupBody, int groupId) async {
    Map<String, dynamic> body = groupBody.toJson();
    body['groupId'] = groupId;
    return await apiClient.postData(Appconstants.GROUP_UPDATE_URI, body);
  }

  Future<Response> deleteGroup(int groupId) async {
    return await apiClient
        .postData(Appconstants.GROUP_DELETE_URI, {'groupId': groupId});
  }
}
