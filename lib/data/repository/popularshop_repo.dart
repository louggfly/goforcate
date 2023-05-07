import 'package:get/get.dart';
import 'package:goforcate_app/data/api/api_client.dart';

import '../../utils/app_constants.dart';

class PopularShopRepo extends GetxService {
  final ApiClient apiClient;

  PopularShopRepo({required this.apiClient});

  Future<Response> getPopularShop() async {
    return await apiClient.getData(Appconstants.POPULAR_SHOP_URI);
  }
}
