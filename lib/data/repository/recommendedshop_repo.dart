import 'package:get/get.dart';
import 'package:goforcate_app/data/api/api_client.dart';

import '../../utils/app_constants.dart';

class RecommendedShopRepo extends GetxService {
  final ApiClient apiClient;

  RecommendedShopRepo({required this.apiClient});

  Future<Response> getRecommendedShop() async {
    return await apiClient.getData(Appconstants.RECOMMENDED_SHOP_URI);
  }
}
