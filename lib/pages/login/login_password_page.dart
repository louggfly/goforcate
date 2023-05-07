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

class LoginPasswordPage extends StatefulWidget {
  const LoginPasswordPage({Key? key}) : super(key: key);

  @override
  _LoginPasswordPageState createState() => _LoginPasswordPageState();
}

class _LoginPasswordPageState extends State<LoginPasswordPage> {
  @override
  Widget build(BuildContext context) {
    var phoneController = TextEditingController();
    var passwordController = TextEditingController();
    bool _checkboxSelected = false;

    void _login(AuthController authController) {
      String phone = phoneController.text.trim();
      String password = passwordController.text.trim();
      if (phone.isEmpty) {
        ShowErrorSnackBar("Enter your phone", title: "Phone");
      } else if (password.isEmpty) {
        ShowErrorSnackBar("Enter your password", title: "Password");
      } else if (!GetUtils.isPhoneNumber(phone)) {
        ShowErrorSnackBar("Enter a valid phone number", title: "Valid phone");
      } else {
        authController.login(phone, password).then((status) {
          if (status.isSuccess) {
            ShowSuccessSnackBar(phone, title: "登录成功!");
            Get.toNamed(RouteHelper.getInital(0));
          } else {
            ShowErrorSnackBar(status.message, title: "登录失败!");
          }
        });
      }
    }

    return GetBuilder<AuthController>(
      builder: (_authController) {
        return SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: Dimension.screenWidth,
                height: Dimension.screenHeight * 0.54,
                decoration: BoxDecoration(
                    //background
                    image: DecorationImage(
                  fit: BoxFit.fitWidth,
                  image: AssetImage("graphics/login.png"),
                )),
              ),
              Container(
                  margin: EdgeInsets.only(top: Dimension.gap10),
                  child: BigText(
                    text: 'LOGIN TO YOUR ACCOUNT',
                    color: AppColors.fontColor5,
                    size: Dimension.gap20 * 0.7,
                  )),
              //phone
              Container(
                width: Dimension.screenWidth * 0.8,
                margin: EdgeInsets.only(top: Dimension.gap10),
                child: InputTextField(
                    textEditingController: phoneController,
                    hintText: "Phone Number",
                    icon: Icons.phone),
              ),
              //password
              Container(
                width: Dimension.screenWidth * 0.8,
                margin: EdgeInsets.only(top: Dimension.gap20),
                child: InputTextField(
                  textEditingController: passwordController,
                  hintText: "Password",
                  icon: Icons.lock,
                  isObscure: true,
                ),
              ),
              //remember
              Container(
                width: Dimension.screenWidth * 0.8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: _checkboxSelected,
                          activeColor: AppColors.mainColor1,
                          checkColor: AppColors.mainColor2,
                          tristate: true,
                          onChanged: (value) {
                            print(value);
                            setState(() {
                              _checkboxSelected = value!;
                            });
                          },
                        ),
                        RichText(
                            text: TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => Get.back(),
                                text: "Remember me",
                                style: TextStyle(
                                  color: AppColors.mainColor2,
                                  fontSize: Dimension.gap15,
                                )))
                      ],
                    ),
                    RichText(
                        text: TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Get.toNamed(RouteHelper.getForgetPasswordPage()),
                            text: "Forget Password?",
                            style: TextStyle(
                              color: AppColors.buttonColor1,
                              fontSize: Dimension.gap15,
                            )))
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  _login(_authController);
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
                          "LOGIN",
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
        );
      },
    );
  }
}
