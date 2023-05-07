import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:goforcate_app/utils/dimensions.dart';

import '../../base/show_custom_snackbar.dart';
import '../../controllers/auth_controller.dart';
import '../../routes/route_helper.dart';
import '../../utils/colors.dart';
import '../../widgets/big_text.dart';
import '../../widgets/text_field.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgetPasswordPageState createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  @override
  Widget build(BuildContext context) {
    var phoneController = TextEditingController();
    var passwordController = TextEditingController();
    var repasswordController = TextEditingController();
    bool _checkboxSelected = false;

    void _newpassword(AuthController authController) {
      String phone = phoneController.text.trim();
      String password = passwordController.text.trim();
      String repassword = repasswordController.text.trim();
      if (phone.isEmpty) {
        ShowErrorSnackBar("Enter your phone", title: "Phone");
      } else if (password.isEmpty) {
        ShowErrorSnackBar("Enter your password", title: "Password");
      } else if (repassword.isEmpty) {
        ShowErrorSnackBar("Enter your repassword", title: "RePassword");
      } else {
        authController.newpassword(phone,password).then((status) {
          if (status.isSuccess) {
            ShowSuccessSnackBar("", title: "密码修改成功!");
            Get.toNamed(RouteHelper.getLogin());
          } else {
            ShowErrorSnackBar(status.message, title: "密码修改失败!");
          }
        });
      }
    }

    return Scaffold(
      body: GetBuilder<AuthController>(
        builder: (_authController) {
          return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: Dimension.screenWidth,
                  height: Dimension.screenHeight * 0.53,
                  decoration: BoxDecoration(
                    //background
                      image: DecorationImage(
                        fit: BoxFit.fitWidth,
                        image: AssetImage("graphics/verification.png"),
                      )),
                ),
                Container(
                    margin: EdgeInsets.only(top: Dimension.gap10),
                    child: BigText(
                      text: 'SET YOU NEW PASSWORD',
                      color: AppColors.fontColor5,
                      size: Dimension.gap20 * 0.7,
                    )),
                //phone
                Container(
                  width: Dimension.screenWidth * 0.8,
                  margin: EdgeInsets.only(top: Dimension.gap10),
                  child: InputTextField(
                      textEditingController: phoneController,
                      hintText: "Enter Your Phone",
                      icon: Icons.phone),
                ),
                //password
                Container(
                  width: Dimension.screenWidth * 0.8,
                  margin: EdgeInsets.only(top: Dimension.gap10),
                  child: InputTextField(
                      textEditingController: passwordController,
                      hintText: "Password",
                      icon: Icons.password),
                ),
                //repassword
                Container(
                  width: Dimension.screenWidth * 0.8,
                  margin: EdgeInsets.only(top: Dimension.gap20),
                  child: InputTextField(
                    textEditingController: repasswordController,
                    hintText: "Password again",
                    icon: Icons.password,
                    isObscure: true,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: Dimension.gap20*2, right: Dimension.gap20*2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                            width: Dimension.gap30 * 4,
                            margin: EdgeInsets.only(
                              top: Dimension.gap20,
                            ),
                            padding: EdgeInsets.only(
                                top: Dimension.gap10,
                                bottom: Dimension.gap10,
                                left: Dimension.gap10,
                                right: Dimension.gap10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(999),
                              color: AppColors.mainColor2,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: Dimension.gap5,
                                ),
                                Text(
                                  "Back",
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontFamily: 'Roboto',
                                      color: Colors.white,
                                      fontSize: Dimension.gap15, //fontBig或者size
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            )),
                      ),
                      GestureDetector(
                        onTap: () {
                          _newpassword(_authController);
                          Get.toNamed(RouteHelper.getLogin());
                        },
                        child: Container(
                            width: Dimension.gap30 * 4,
                            margin: EdgeInsets.only(
                              top: Dimension.gap20,
                            ),
                            padding: EdgeInsets.only(
                                top: Dimension.gap10,
                                bottom: Dimension.gap10,
                                left: Dimension.gap10,
                                right: Dimension.gap10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(999),
                              color: AppColors.mainColor1,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: Dimension.gap5,
                                ),
                                Text(
                                  "Save",
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontFamily: 'Roboto',
                                      color: AppColors.fontColor1,
                                      fontSize: Dimension.gap15, //fontBig或者size
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            )),
                      ),
                    ],
                  ),
                )

              ],
            ),
          );
        },
      ),
    );
  }
}

