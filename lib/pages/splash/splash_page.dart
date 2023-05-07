import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:goforcate_app/controllers/preference_controller.dart';
import 'package:goforcate_app/routes/route_helper.dart';
import 'package:goforcate_app/utils/app_constants.dart';
import 'package:goforcate_app/utils/colors.dart';

import '../../controllers/area_controller.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/commentlist_controller.dart';
import '../../controllers/notice_controller.dart';
import '../../controllers/shoplist_controller.dart';
import '../../controllers/user_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  _loadResource() async {
    Get.find<ShopListController>().getShopList();
    Get.find<CommentListController>().getCommentList();
    Get.find<UserController>().getUserList();
    Get.find<AreaController>().getAreaList();
    Get.find<NoticeController>().getNoticeList();
    Get.find<PreferenceController>().getCategoryList();
  }

  @override
  void initState() {
    super.initState();
    _loadResource();
    bool _userLoggedIN = Get.find<AuthController>().userLoggedIn();
    controller = new AnimationController(
        vsync: this, duration: const Duration(seconds: 2))
      ..forward();
    animation = new CurvedAnimation(parent: controller, curve: Curves.linear);
    if (_userLoggedIN) {
      print("User has logged in");
      print("token: " + Appconstants.TOKEN);
      Timer(Duration(seconds: 3), () => Get.toNamed(RouteHelper.getInital(0)));
    } else {
      print("User has not logged in");
      print("token: " + Appconstants.TOKEN);
      Timer(Duration(seconds: 3), () => Get.toNamed(RouteHelper.getLogin()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Center(
        child: CircularProgressIndicator(
          color: AppColors.mainColor1,
        ),
      ),
      decoration: BoxDecoration(
          //background
          image: DecorationImage(
        fit: BoxFit.cover,
        image: AssetImage("graphics/logopage.png"),
      )),
    ));
  }
}
