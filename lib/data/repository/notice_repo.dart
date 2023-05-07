import 'package:get/get.dart';
import 'package:goforcate_app/data/api/api_client.dart';

import '../../utils/app_constants.dart';

class NoticeRepo extends GetxService {
  final ApiClient apiClient;

  NoticeRepo({required this.apiClient});

  Future<Response> getNoticeList() async {
    return await apiClient.getData(Appconstants.NOTICE_LIST_URI);
  }
}
