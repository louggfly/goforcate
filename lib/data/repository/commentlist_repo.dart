import 'package:get/get.dart';
import 'package:goforcate_app/data/api/api_client.dart';

import '../../utils/app_constants.dart';

class CommentListRepo extends GetxService {
  final ApiClient apiClient;

  CommentListRepo({required this.apiClient});

  Future<Response> getCommentList() async {
    return await apiClient.getData(Appconstants.COMMENT_LIST_URI);
  }

  Future<Response> getSearchComment(String keyword) async {
    return await apiClient
        .postData(Appconstants.COMMENT_SEARCH_URI, {"keyword": keyword});
  }
}
