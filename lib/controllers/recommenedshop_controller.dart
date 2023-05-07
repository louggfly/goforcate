import 'package:get/get.dart';

import '../data/repository/recommendedshop_repo.dart';
import '../models/recommended_shop.dart';

class RecommendedShopController extends GetxController {
  final RecommendedShopRepo recommendedShopRepo;

  RecommendedShopController({required this.recommendedShopRepo});

  List<dynamic> _recommendedShop = [];

  List<dynamic> get recommendedShop => _recommendedShop;

  bool _isLoaded = false;

  bool get isLoaded => _isLoaded;

  Future<void> getRecommendedShop() async {
    Response response = await recommendedShopRepo.getRecommendedShop();
    print(response.statusCode);
    if (response.statusCode == 200) {
      print("got recommended");
      _recommendedShop = [];
      _recommendedShop
          .addAll(RecommendedShop.fromJson(response.body).recommendedShop);
      _isLoaded = true;
      update();
    } else {}
  }
}
