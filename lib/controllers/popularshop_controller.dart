import 'package:get/get.dart';
import 'package:goforcate_app/models/popular_shop.dart';

import '../data/repository/popularshop_repo.dart';

class PopularShopController extends GetxController {
  final PopularShopRepo popularShopRepo;

  PopularShopController({required this.popularShopRepo});

  List<dynamic> _popularShop = [];

  List<dynamic> get popularShop => _popularShop;

  bool _isLoaded = false;

  bool get isLoaded => _isLoaded;

  Future<void> getPopularShop() async {
    Response response = await popularShopRepo.getPopularShop();
    print(response.statusCode);
    if (response.statusCode == 200) {
      print("got popular");
      _popularShop = [];
      _popularShop.addAll(PopularShop.fromJson(response.body).popularShop);
      _isLoaded = true;
      update();
    } else {}
  }
}
