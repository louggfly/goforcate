import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:goforcate_app/widgets/button_icon_text.dart';

import '../../routes/route_helper.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/button_icon.dart';

class ReleaseSuccessPage extends StatelessWidget {
  final int commentId;
  final int shopId;

  const ReleaseSuccessPage(
      {Key? key, required this.commentId, required this.shopId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor2,
        title: const Text("Release Success"),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Get.toNamed(RouteHelper.getInital(0));
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
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              child: const Image(
                image: AssetImage("graphics/releaseSuccess.png"),
                fit: BoxFit.fitHeight,
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.toNamed(RouteHelper.getInital(0));
              },
              child: Container(
                  width: Dimension.screenWidth * 0.7,
                  child: ButtonIconText(
                      icon: CupertinoIcons.home,
                      iconColor: Colors.white,
                      backGroundColor: AppColors.mainColor2,
                      buttonSize: Dimension.gap30,
                      iconSize: Dimension.gap30,
                      text: "Back to home",
                      textColor: Colors.white,
                      textSize: Dimension.gap15)),
            ),
            SizedBox(
              height: Dimension.screenHeight * 0.05,
            ),
            GestureDetector(
              onTap: () {
                Get.toNamed(RouteHelper.getUserComment(commentId, shopId));
              },
              child: Container(
                  width: Dimension.screenWidth * 0.7,
                  child: ButtonIconText(
                      icon: CupertinoIcons.text_badge_checkmark,
                      iconColor: Colors.white,
                      backGroundColor: AppColors.mainColor1,
                      buttonSize: Dimension.gap30,
                      iconSize: Dimension.gap30,
                      text: "Check Comment",
                      textColor: Colors.white,
                      textSize: Dimension.gap15)),
            )
          ],
        ),
      ),
    );
  }
}
