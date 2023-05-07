import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goforcate_app/controllers/user_controller.dart';
import 'package:goforcate_app/utils/dimensions.dart';
import 'package:goforcate_app/widgets/big_text.dart';
import 'package:goforcate_app/widgets/button_icon.dart';

import '../../base/show_custom_snackbar.dart';
import '../../controllers/area_controller.dart';
import '../../routes/route_helper.dart';
import '../../utils/colors.dart';

class AreaPage extends StatefulWidget {
  int index;

  AreaPage({Key? key, required this.index}) : super(key: key);

  @override
  _AreaPageState createState() => _AreaPageState();
}

class _AreaPageState extends State<AreaPage> with TickerProviderStateMixin {
  late TextEditingController _searchController;
  bool _isAllLoading = true;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _searchController.addListener(() {
      print("update search list");
      Get.find<AreaController>()
          .getSearchArea(_searchController.text)
          .then((status) {
        if (status.isSuccess) {}
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Future<void> saveUserArea(int areaId) async {
      Get.find<UserController>().updateUserArea(areaId).then((status) {
        if (status.isSuccess) {
          ShowSuccessSnackBar("Update user area success");
          if (widget.index == 0) {
            Get.toNamed(RouteHelper.getInital(0));
          } else if (widget.index == 1) {
            Get.toNamed(RouteHelper.getInital(0));
          } else if (widget.index == 2) {
            Get.toNamed(RouteHelper.getInital(0));
          }
        } else {
          ShowErrorSnackBar("Update user area failed");
        }
      });
    }

    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              if (widget.index == 0) {
                Get.toNamed(RouteHelper.getInital(0));
              } else if (widget.index == 1) {
                Get.toNamed(RouteHelper.getInital(1));
              } else if (widget.index == 2) {
                Get.toNamed(RouteHelper.getInital(2));
              }
            },
            child: Container(
              margin: EdgeInsets.all(Dimension.gap5),
              child: ButtonIcon(
                  icon: Icons.close,
                  iconColor: AppColors.mainColor2,
                  backGroundColor: Colors.white,
                  iconSize: Dimension.icon30),
            ),
          ),
          backgroundColor: Colors.white,
          title: BigText(
            text: Get.find<AreaController>().getUserArea(),
            size: Dimension.gap20 * 1.1,
            color: AppColors.fontColor1,
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: GetBuilder<AreaController>(builder: (areaController) {
          return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //search
                Container(
                  height: Dimension.screenHeight * 0.05,
                  margin: EdgeInsets.only(
                      top: Dimension.gap10,
                      bottom: Dimension.gap5,
                      left: Dimension.gap20,
                      right: Dimension.gap20),
                  decoration: BoxDecoration(
                    color: AppColors.bottomColor1,
                    borderRadius: BorderRadius.circular(Dimension.gap20),
                  ),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: "Search for area",
                      hintStyle: TextStyle(
                          fontFamily: 'Roboto',
                          color: AppColors.fontColor2,
                          fontSize: Dimension.gap15 * 0.9, //fontBig或者size
                          fontWeight: FontWeight.w600),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Dimension.gap20),
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: AppColors.fontColor2,
                        size: Dimension.gap20 * 1.2,
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(Dimension.gap20),
                          borderSide: BorderSide(
                              width: Dimension.gap2, color: Colors.white70)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(Dimension.gap20),
                          borderSide: BorderSide(
                              width: 1.5, color: AppColors.bottomColor1)),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: Dimension.gap10),
                  height: Dimension.screenHeight * 0.78,
                  color: Colors.white,
                  child: ListView.builder(
                      physics: AlwaysScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: areaController.searchAreaList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            saveUserArea(
                                areaController.searchAreaList[index].id);
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Dimension.gap10),
                                color: Colors.white,
                              ),
                              margin: EdgeInsets.only(
                                  bottom: Dimension.gap5,
                                  left: Dimension.gap10,
                                  right: Dimension.gap10),
                              padding: EdgeInsets.only(
                                  left: Dimension.gap2,
                                  right: Dimension.gap2,
                                  top: Dimension.gap5,
                                  bottom: Dimension.gap5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(areaController
                                      .searchAreaList[index].name),
                                  Divider()
                                ],
                              )),
                        );
                      }),
                ),
              ],
            ),
          );
        }));
  }
}
