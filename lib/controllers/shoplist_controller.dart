import 'package:get/get.dart';
import 'package:goforcate_app/data/repository/shoplist_repo.dart';

import '../models/response_model.dart';
import '../models/shop_list.dart';
import '../models/shop_model.dart';

class ShopListController extends GetxController {
  final ShopListRepo shopListRepo;

  ShopListController({required this.shopListRepo});

  List<dynamic> _shopList = [];
  List<dynamic> _searchShopList = [];

  List<dynamic> get shopList => _shopList;

  List<dynamic> get searchShopList => _searchShopList;

  Future<ResponseModel> getShopList() async {
    Response response = await shopListRepo.getShopList();
    late ResponseModel responseModel;
    print(response.statusCode);
    if (response.statusCode == 200) {
      print("got shoplist");
      _shopList = [];
      _shopList.addAll(ShopList.fromJson(response.body).shops);
      update();
      responseModel = ResponseModel(true, "成功获取店铺列表");
    } else {
      responseModel = ResponseModel(false, "无法获取店铺列表");
    }
    return responseModel;
  }

  Future<ResponseModel> getSearchShop(String keyword) async {
    Response response = await shopListRepo.getSearchShop(keyword);
    late ResponseModel responseModel;
    print(response.statusCode);
    if (response.statusCode == 200) {
      print("got search shop");
      _searchShopList = [];
      _searchShopList.addAll(ShopList.fromJson(response.body).shops);
      update();
      responseModel = ResponseModel(true, "成功搜索店铺列表");
    } else {
      responseModel = ResponseModel(false, "无法搜索店铺列表");
    }
    return responseModel;
  }

  ShopModel getShop(int shopId){
    late ShopModel shopModel;
    for (ShopModel shop in _shopList) {
      if (shop.id == shopId) {
        shopModel = shop;
        print("Get shop: " + shop.name!);
      }
    }
    return shopModel;
  }

  int getShopListLength() {
    return shopList.length;
  }
}
