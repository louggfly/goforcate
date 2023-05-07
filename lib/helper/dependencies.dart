import 'package:get/get.dart';
import 'package:goforcate_app/controllers/commentlist_controller.dart';
import 'package:goforcate_app/controllers/popularshop_controller.dart';
import 'package:goforcate_app/controllers/recommenedshop_controller.dart';
import 'package:goforcate_app/controllers/shop_controller.dart';
import 'package:goforcate_app/controllers/shoplist_controller.dart';
import 'package:goforcate_app/data/repository/auth_repo.dart';
import 'package:goforcate_app/data/repository/commentlist_repo.dart';
import 'package:goforcate_app/data/repository/popularshop_repo.dart';
import 'package:goforcate_app/data/repository/recommendedshop_repo.dart';
import 'package:goforcate_app/data/repository/shoplist_repo.dart';
import 'package:goforcate_app/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/area_controller.dart';
import '../controllers/auth_controller.dart';
import '../controllers/autoscore_controller.dart';
import '../controllers/group_controller.dart';
import '../controllers/notice_controller.dart';
import '../controllers/preference_controller.dart';
import '../controllers/user_controller.dart';
import '../data/api/api_client.dart';
import '../data/repository/area_repo.dart';
import '../data/repository/autoscore_repo.dart';
import '../data/repository/group_repo.dart';
import '../data/repository/notice_repo.dart';
import '../data/repository/preference_repo.dart';
import '../data/repository/shop_repo.dart';
import '../data/repository/user_repo.dart';

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  if (!sharedPreferences.containsKey(Appconstants.TOKEN)) {
    sharedPreferences.setString(Appconstants.TOKEN, "");
  }
  Get.lazyPut(() => sharedPreferences);
  //api client
  Get.lazyPut(() => ApiClient(
      appBaseUrl: Appconstants.BSER_URL, sharedPreferences: sharedPreferences));
  //repos
  Get.lazyPut(() => ShopListRepo(apiClient: Get.find()));
  Get.lazyPut(() => ShopRepo(apiClient: Get.find()));
  Get.lazyPut(() => PopularShopRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedShopRepo(apiClient: Get.find()));
  Get.lazyPut(() => CommentListRepo(apiClient: Get.find()));
  Get.lazyPut(
      () => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => UserRepo(apiClient: Get.find()));
  Get.lazyPut(() => AreaRepo(apiClient: Get.find()));
  Get.lazyPut(() => GroupRepo(apiClient: Get.find()));
  Get.lazyPut(() => NoticeRepo(apiClient: Get.find()));
  Get.lazyPut(() => AutoScoreRepo(apiClient: Get.find()));
  Get.lazyPut(() => PreferenceRepo(apiClient: Get.find()));
  //controller
  Get.lazyPut(() => ShopListController(shopListRepo: Get.find()));
  Get.lazyPut(() => ShopController(shopRepo: Get.find()));
  Get.lazyPut(() => PopularShopController(popularShopRepo: Get.find()));
  Get.lazyPut(() => RecommendedShopController(recommendedShopRepo: Get.find()));
  Get.lazyPut(() => CommentListController(commentListRepo: Get.find()));
  Get.lazyPut(() => AuthController(authRepo: Get.find()));
  Get.lazyPut(() => UserController(userRepo: Get.find()));
  Get.lazyPut(() => AreaController(areaRepo: Get.find()));
  Get.lazyPut(() => GroupController(groupRepo: Get.find()));
  Get.lazyPut(() => NoticeController(noticeRepo: Get.find()));
  Get.lazyPut(() => AutoScoreController(autoScoreRepo: Get.find()));
  Get.lazyPut(() => PreferenceController(preferenceRepo: Get.find()));
}
