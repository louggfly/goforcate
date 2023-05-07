import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:goforcate_app/base/show_custom_snackbar.dart';
import 'package:goforcate_app/models/user_body.dart';
import 'package:goforcate_app/widgets/edit_text_field.dart';

import '../../controllers/auth_controller.dart';
import '../../controllers/user_controller.dart';
import '../../routes/route_helper.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/big_text.dart';
import '../../widgets/button_icon.dart';

class UserProfileEditPage extends StatefulWidget {
  const UserProfileEditPage({Key? key}) : super(key: key);

  @override
  _UserProfileEditPageState createState() => _UserProfileEditPageState();
}

class _UserProfileEditPageState extends State<UserProfileEditPage> {
  int gender = Get.find<UserController>().userModel.gender!;
  String username = Get.find<UserController>().userModel.username!;
  String introduction = Get.find<UserController>().userModel.introduction!;

  @override
  Widget build(BuildContext context) {
    bool _userLoggedIN = Get.find<AuthController>().userLoggedIn();
    var nameController = TextEditingController(text: username);
    var introductionController = TextEditingController(text: introduction);

    Future<void> saveUserInfo() async {
      if (nameController.text.isEmpty) {
        ShowErrorSnackBar("Username cannot be empty");
      } else {
        UserBody userBody = UserBody(
            username: nameController.text.trim(),
            gender: gender,
            introduction: introductionController.text.trim());
        Get.find<UserController>().updateUserInfo(userBody).then((status) {
          if (status.isSuccess) {
            ShowSuccessSnackBar("Update user info success");
            Get.toNamed(RouteHelper.userProfile);
          } else {
            ShowErrorSnackBar("Update user info failed");
          }
        });
      }
    }

    List<DropdownMenuItem<int>> genderItems = [
      DropdownMenuItem(
        value: 0,
        child: BigText(
          text: 'Unknown',
          size: Dimension.gap20 * 0.8,
          color: AppColors.fontColor1,
        ),
      ),
      DropdownMenuItem(
        value: 1,
        child: BigText(
          text: 'Male',
          size: Dimension.gap20 * 0.8,
          color: AppColors.fontColor1,
        ),
      ),
      DropdownMenuItem(
        value: 2,
        child: BigText(
          text: 'Female',
          size: Dimension.gap20 * 0.8,
          color: AppColors.fontColor1,
        ),
      ),
    ];

    if (_userLoggedIN) {
      Get.find<UserController>().getUserInfo();
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
          text: "User Profile Edit",
          size: Dimension.gap20,
          color: AppColors.fontColor1,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: GetBuilder<UserController>(builder: (userController) {
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
                                                      BorderRadius.circular(
                                                          999),
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
                                  padding:
                                      EdgeInsets.only(left: Dimension.gap30),
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
                                        borderRadius:
                                            BorderRadius.circular(999),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: Dimension.screenWidth,
                          margin: EdgeInsets.only(
                              left: Dimension.gap20,
                              right: Dimension.screenWidth * 0.4),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Dimension.gap10),
                              color: Colors.white,
                              border: Border.all(
                                  width: Dimension.gap2 * 0.8,
                                  color: AppColors.mainColor2),
                              boxShadow: const [
                                BoxShadow(
                                    color: Color(0xffa7a1a1),
                                    blurRadius: 1.0,
                                    offset: Offset(1, 1))
                              ]),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              EditTextField(
                                textEditingController: nameController,
                                hintText: userController.userModel.username!,
                                length: 10,
                              )
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
                                          borderRadius:
                                              BorderRadius.circular(999),
                                        ),
                                        child: DropdownButton(
                                          value: gender,
                                          items: genderItems,
                                          onChanged: (int? newValue) {
                                            setState(() {
                                              gender = newValue ??= 0;
                                              print(gender);
                                            });
                                          },
                                        )),
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
                                        borderRadius:
                                            BorderRadius.circular(999),
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
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: Dimension.screenWidth,
                          height: Dimension.screenHeight * 0.2,
                          margin: EdgeInsets.only(
                              top: Dimension.gap10,
                              left: Dimension.gap20,
                              right: Dimension.gap20),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Dimension.gap10),
                              color: Colors.white,
                              border: Border.all(
                                  width: Dimension.gap2 * 0.8,
                                  color: AppColors.mainColor2),
                              boxShadow: const [
                                BoxShadow(
                                    color: Color(0xffa7a1a1),
                                    blurRadius: 1.0,
                                    offset: Offset(1, 1))
                              ]),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              EditTextField(
                                textEditingController: introductionController,
                                hintText:
                                    userController.userModel.introduction!,
                                length: 50,
                              )
                            ],
                          ),
                        ),
                        //save button
                        MaterialButton(
                          onPressed: saveUserInfo,
                          child: Container(
                              width: Dimension.gap30 * 4,
                              margin: EdgeInsets.only(
                                top: Dimension.gap30,
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
                                    Icons.save_outlined,
                                    color: AppColors.fontColor1,
                                    size: Dimension.gap30,
                                  ),
                                  SizedBox(
                                    width: Dimension.gap5,
                                  ),
                                  Text(
                                    "Save",
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontFamily: 'Roboto',
                                        color: AppColors.fontColor1,
                                        fontSize:
                                            Dimension.gap20, //fontBig或者size
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              )),
                        )
                      ],
                    )
                  : CircularProgressIndicator())
              : Container(
                  child: Center(
                    child: Text("You must login"),
                  ),
                );
        }),
      ),
    );
  }
}
