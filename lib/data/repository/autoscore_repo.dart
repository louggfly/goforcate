import 'package:get/get.dart';
import 'package:goforcate_app/data/api/api_client.dart';

import '../../utils/app_constants.dart';

class AutoScoreRepo extends GetxService {
  final ApiClient apiClient;

  AutoScoreRepo({required this.apiClient});

  Future<Response> getSentaScore(String input) async {
    return await apiClient
        .postData(Appconstants.SENTA_URI, {"input": input});
  }
}
