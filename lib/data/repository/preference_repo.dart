import 'package:get/get.dart';
import 'package:goforcate_app/data/api/api_client.dart';

import '../../utils/app_constants.dart';

class PreferenceRepo extends GetxService {
  final ApiClient apiClient;

  PreferenceRepo({required this.apiClient});

  Future<Response> getCategoryList() async {
    return await apiClient.getData(Appconstants.CATEGORY_LIST_URI);
  }

  Future<Response> getUserPreference() async {
    return await apiClient.getData(Appconstants.USER_PREFERENCE_URI);
  }

  Future<Response> createPreference(int categoryId) async {
    return await apiClient
        .postData(Appconstants.USER_PREFERENCE_CREATE_URI, {"categoryId": categoryId});
  }

  Future<Response> deletePreference(int categoryId) async {
    return await apiClient
        .postData(Appconstants.USER_PREFERENCE_DELETE_URI, {"categoryId": categoryId});
  }

}
