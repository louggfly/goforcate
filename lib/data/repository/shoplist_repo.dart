import 'package:get/get.dart';
import 'package:goforcate_app/data/api/api_client.dart';

import '../../utils/app_constants.dart';

class ShopListRepo extends GetxService {
  final ApiClient apiClient;

  ShopListRepo({required this.apiClient});

  Future<Response> getShopList() async {
    return await apiClient.getData(Appconstants.SHOP_LIST_URI);
  }

  Future<Response> getSearchShop(String keyword) async {
    return await apiClient
        .postData(Appconstants.SEARCH_SHOP_URI, {"keyword": keyword});
  }
}
