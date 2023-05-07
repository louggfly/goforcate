import 'package:get/get.dart';
import 'package:goforcate_app/data/api/api_client.dart';

import '../../utils/app_constants.dart';

class AreaRepo extends GetxService {
  final ApiClient apiClient;

  AreaRepo({required this.apiClient});

  Future<Response> getAreaList() async {
    return await apiClient.getData(Appconstants.AREA_LIST_URI);
  }

  Future<Response> getSearchArea(String keyword) async {
    return await apiClient
        .postData(Appconstants.AREA_SEARCH_URI, {"keyword": keyword});
  }
}
