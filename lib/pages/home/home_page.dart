import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goforcate_app/controllers/group_controller.dart';
import 'package:goforcate_app/controllers/recommenedshop_controller.dart';
import 'package:goforcate_app/utils/colors.dart';
import 'package:goforcate_app/widgets/big_text.dart';

import '../../controllers/area_controller.dart';
import '../../controllers/preference_controller.dart';
import '../../controllers/user_controller.dart';
import '../../routes/route_helper.dart';
import '../../utils/dimensions.dart';
import '../../widgets/small_text.dart';
import 'home_page_recommand.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isAllLoading = false;

  @override
  void initState() {
    super.initState();
    Get.find<UserController>().getUserInfo().then((status) {
      if (status.isSuccess) {
        setState(() {
          _isAllLoading = true;
        });
      }
    });
    Get.find<GroupController>().getGroupList();
    Get.find<RecommendedShopController>().getRecommendedShop();
    Get.find<PreferenceController>().getUserPreference();
    Get.find<UserController>().getUserList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          //header
          Container(
            margin: EdgeInsets.only(
                top: Dimension.gap15 * 3, bottom: Dimension.gap10),
            padding:
                EdgeInsets.only(left: Dimension.gap20, right: Dimension.gap20),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteHelper.getChooseArea(0));
                    },
                    child: Column(
                      children: [
                        _isAllLoading
                            ? GetBuilder<AreaController>(
                                builder: (areaController) {
                                return BigText(
                                    text: areaController.getUserArea());
                              })
                            : CircularProgressIndicator(),
                        Row(
                          children: [
                            SmallText(text: 'city'),
                            Icon(Icons.keyboard_arrow_down)
                          ],
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteHelper.getInputSearch(0));
                      },
                      child: Container(
                        //右上角搜索按钮
                        width: Dimension.gap15 * 3,
                        height: Dimension.gap15 * 3,
                        child: Icon(Icons.search, color: Colors.white),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimension.gap15),
                          color: AppColors.mainColor2,
                        ),
                      )),
                ],
              ),
            ),
          ),
          //body
          Expanded(
              child: SingleChildScrollView(
            child: HomePageRecommand(),
          )),
        ],
      ),
    );
  }
}
