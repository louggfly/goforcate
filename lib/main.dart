import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:goforcate_app/controllers/commentlist_controller.dart';
import 'package:goforcate_app/routes/route_helper.dart';

import 'controllers/popularshop_controller.dart';
import 'controllers/recommenedshop_controller.dart';
import 'controllers/shoplist_controller.dart';
import 'helper/dependencies.dart' as dep;

Future<void> main() async {
  SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, //全局设置透明
      statusBarIconBrightness: Brightness.dark);
  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.find<ShopListController>().getShopList();
    Get.find<PopularShopController>().getPopularShop();
    Get.find<RecommendedShopController>().getRecommendedShop();
    Get.find<CommentListController>().getCommentList();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GoForCate',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      initialRoute: RouteHelper.getSplashPage(),
      getPages: RouteHelper.routes,
    );
  }
}
