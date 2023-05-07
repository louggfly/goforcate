import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:goforcate_app/controllers/auth_controller.dart';
import 'package:goforcate_app/controllers/user_controller.dart';

import '../../routes/route_helper.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/big_text.dart';
import '../../widgets/button_icon.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  String returnGender(int genderId) {
    if (genderId == 1) {
      return "Male";
    } else if (genderId == 2) {
      return "Female";
    }
    return "Unknown";
  }

  @override
  Widget build(BuildContext context) {
    bool _userLoggedIN = Get.find<AuthController>().userLoggedIn();
    if (_userLoggedIN) {
      Get.find<UserController>().getUserInfo();
      print("User has logged");
    }
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
          text: "User Profile",
          size: Dimension.gap20,
          color: AppColors.fontColor1,
        ),
        centerTitle: true,
      ),
      body: GetBuilder<UserController>(builder: (userController) {
        return _userLoggedIN
            ? (userController.isLoading1
                ? Column(
                    children: [
                      //user avatar
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(RouteHelper.getUserAvatarEdit());
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                              right: Dimension.gap30,
                              left: Dimension.gap30,
                              top: Dimension.gap20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Column(
                                  children: [
                                    BigText(
                                      text: "User Avatar",
                                      size: Dimension.gap15,
                                      color: AppColors.fontColor5,
                                    ),
                                    Container(
                                        padding: EdgeInsets.only(
                                            top: Dimension.gap5,
                                            bottom: Dimension.gap2),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(999),
                                        ),
                                        child: Row(
                                          children: [
                                            Container(
                                              height: Dimension.gap30 * 3,
                                              width: Dimension.gap30 * 3,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(999),
                                                color: Colors.purple,
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                      userController
                                                          .userModel.avatar!),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )),
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
                      //user name
                      Container(
                        margin: EdgeInsets.only(
                            right: Dimension.gap30,
                            left: Dimension.gap30,
                            top: Dimension.gap10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  BigText(
                                    text: "Name",
                                    size: Dimension.gap15,
                                    color: AppColors.fontColor5,
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                        top: Dimension.gap5,
                                        bottom: Dimension.gap2),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(999),
                                    ),
                                    child: BigText(
                                      text: userController.userModel.username!,
                                      size: Dimension.gap20 * 0.8,
                                      color: AppColors.fontColor1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      //user gender
                      Container(
                        margin: EdgeInsets.only(
                            right: Dimension.gap30,
                            left: Dimension.gap30,
                            top: Dimension.gap10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  BigText(
                                    text: "Gender",
                                    size: Dimension.gap15,
                                    color: AppColors.fontColor5,
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                        top: Dimension.gap5,
                                        bottom: Dimension.gap2),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(999),
                                    ),
                                    child: BigText(
                                      text: returnGender(
                                          userController.userModel.gender!),
                                      size: Dimension.gap20 * 0.8,
                                      color: AppColors.fontColor1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      //user phone
                      Container(
                        margin: EdgeInsets.only(
                            right: Dimension.gap30,
                            left: Dimension.gap30,
                            top: Dimension.gap10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  BigText(
                                    text: "Phone",
                                    size: Dimension.gap15,
                                    color: AppColors.fontColor5,
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                        top: Dimension.gap5,
                                        bottom: Dimension.gap2),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(999),
                                    ),
                                    child: BigText(
                                      text: userController.userModel.mobile!,
                                      size: Dimension.gap20 * 0.8,
                                      color: AppColors.fontColor1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      //user introduction
                      Container(
                        margin: EdgeInsets.only(
                            right: Dimension.gap30,
                            left: Dimension.gap30,
                            top: Dimension.gap10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  BigText(
                                    text: "Personal introduction",
                                    size: Dimension.gap15,
                                    color: AppColors.fontColor5,
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                        top: Dimension.gap5,
                                        bottom: Dimension.gap2),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(999),
                                    ),
                                    child: BigText(
                                      text: userController
                                          .userModel.introduction!,
                                      size: Dimension.gap20 * 0.8,
                                      color: AppColors.fontColor1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      //edit button
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(RouteHelper.getUserProfileEdit());
                        },
                        child: Container(
                            width: Dimension.gap30 * 4,
                            margin: EdgeInsets.only(
                              top: Dimension.gap30 * 5,
                            ),
                            padding: EdgeInsets.only(
                                top: Dimension.gap5,
                                bottom: Dimension.gap5,
                                left: Dimension.gap15,
                                right: Dimension.gap15),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(999),
                                color: AppColors.mainColor1,
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
                                  Icons.edit_note,
                                  color: AppColors.fontColor1,
                                  size: Dimension.gap30,
                                ),
                                SizedBox(
                                  width: Dimension.gap5,
                                ),
                                Text(
                                  "Edit",
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontFamily: 'Roboto',
                                      color: AppColors.fontColor1,
                                      fontSize: Dimension.gap20, //fontBig或者size
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            )),
                      ),
                    ],
                  )
                : CircularProgressIndicator())
            : Container(
                child: Center(
                  child: Text("You must login"),
                ),
              );
      }),
    );
  }
}
