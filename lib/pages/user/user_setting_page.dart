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

class UserSettingPage extends StatelessWidget {
  const UserSettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Get.toNamed(RouteHelper.getInital(4));
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
          text: "Setting",
          size: Dimension.gap20 * 1.1,
          color: AppColors.fontColor1,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              Get.toNamed(RouteHelper.getUserProfile());
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
                      Icons.people_alt_sharp,
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
                          text: "User Profile",
                          color: AppColors.fontColor1,
                          size: Dimension.gap15,
                        ),
                        SmallText(
                          text: "You can change your information here",
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
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              Get.toNamed(RouteHelper.getUserSafetyPage());
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
                      Icons.security,
                      color: AppColors.mainColor5,
                      size: Dimension.gap30 * 1.1,
                    ),
                  ),
                  Container(
                    width: Dimension.screenWidth * 0.6,
                    padding: EdgeInsets.only(
                        left: Dimension.gap20, right: Dimension.gap30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BigText(
                          text: "Account and Safety",
                          color: AppColors.fontColor1,
                          size: Dimension.gap15,
                        ),
                        SmallText(
                          text: "Manage your account",
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
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.toNamed(RouteHelper.getUserPreferencePage(1));
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
                      CupertinoIcons.square_favorites_alt_fill,
                      color: AppColors.mainColor5,
                      size: Dimension.gap30 * 1.1,
                    ),
                  ),
                  Container(
                    width: Dimension.screenWidth * 0.6,
                    padding: EdgeInsets.only(
                        left: Dimension.gap20, right: Dimension.gap30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BigText(
                          text: "User Preference",
                          color: AppColors.fontColor1,
                          size: Dimension.gap15,
                        ),
                        SmallText(
                          text: "Manage your preference",
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
              ),
            ),
          ),


          GestureDetector(
            onTap: () {
              if (Get.find<AuthController>().userLoggedIn()) {
                Get.find<AuthController>().logout();
                print("Token: " + Appconstants.TOKEN);
                Get.offNamed(RouteHelper.getLogin());
              } else {
                Get.toNamed(RouteHelper.getLogin());
              }
              ;
            },
            child: Container(
                width: Dimension.gap30 * 5,
                margin: EdgeInsets.only(
                  top: Dimension.gap30 * 5,
                ),
                padding: EdgeInsets.only(
                    top: Dimension.gap10,
                    bottom: Dimension.gap10,
                    left: Dimension.gap15,
                    right: Dimension.gap15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(999),
                    color: AppColors.mainColor4,
                    boxShadow: [
                      BoxShadow(
                          color: Color(0xffa7a1a1),
                          blurRadius: 0.0,
                          offset: Offset(0, 2))
                    ]),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.power_settings_new,
                      color: AppColors.mainColor3,
                      size: Dimension.gap25,
                    ),
                    SizedBox(
                      width: Dimension.gap5,
                    ),
                    Text(
                      "Log out",
                      maxLines: 1,
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          color: AppColors.mainColor3,
                          fontSize: Dimension.gap15, //fontBig或者size
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                )),
          )
        ],
      ),
    );
  }
}
