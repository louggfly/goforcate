import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:goforcate_app/controllers/auth_controller.dart';
import 'package:goforcate_app/utils/app_constants.dart';
import 'package:goforcate_app/utils/colors.dart';
import 'package:goforcate_app/utils/dimensions.dart';
import 'package:goforcate_app/widgets/big_text.dart';
import 'package:goforcate_app/widgets/button_icon.dart';
import 'package:goforcate_app/widgets/small_text.dart';

import '../../routes/route_helper.dart';

class UserSafetyPage extends StatelessWidget {
  const UserSafetyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Get.toNamed(RouteHelper.getUserSetting());
          },
          child: Container(
            margin: EdgeInsets.all(Dimension.gap5),
            child: ButtonIcon(
                icon: Icons.arrow_back_outlined,
                iconColor: Colors.white,
                backGroundColor: AppColors.mainColor4,
                iconSize: Dimension.gap30),
          ),
        ),
        backgroundColor: AppColors.mainColor3,
        title: BigText(
          text: "Account and safey",
          size: Dimension.gap20 * 1.1,
          color: AppColors.fontColor1,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              Get.toNamed(RouteHelper.getForgetPasswordPage());
            },
            child: Container(
          padding: EdgeInsets.only(
            top: Dimension.gap30,
            bottom: Dimension.gap20,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                padding: EdgeInsets.only(left: Dimension.gap30),
                child: Icon(
                  Icons.password,
                  color: AppColors.mainColor5,
                  size: Dimension.gap30 * 1.1,
                ),
              ),
              Container(
                width: Dimension.screenWidth * 0.6,
                padding: EdgeInsets.only(left: Dimension.gap20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(
                      text: "Change Password",
                      color: AppColors.fontColor1,
                      size: Dimension.gap15,
                    ),
                    SmallText(
                      text: "You can change your password here",
                      color: AppColors.fontColor5,
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: Dimension.gap30),
                child: Icon(
                  Icons.keyboard_arrow_right,
                  color: AppColors.fontColor5,
                  size: Dimension.gap30,
                ),
              )
            ],
          )
      ),
          )
        ],
      ),
    );
  }
}

