import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goforcate_app/base/show_custom_snackbar.dart';
import 'package:goforcate_app/controllers/auth_controller.dart';
import 'package:goforcate_app/models/signup_body.dart';
import 'package:goforcate_app/routes/route_helper.dart';
import 'package:goforcate_app/utils/app_constants.dart';
import 'package:goforcate_app/utils/dimensions.dart';
import 'package:goforcate_app/widgets/small_text_line.dart';

import '../../utils/colors.dart';
import '../../widgets/big_text.dart';
import '../../widgets/text_field.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var phoneController = TextEditingController();
    var passwordController = TextEditingController();
    var usernameController = TextEditingController();
    void _registeration(AuthController authController) {
      String username = usernameController.text.trim();
      String phone = phoneController.text.trim();
      String password = passwordController.text.trim();

      if (username.isEmpty) {
        ShowErrorSnackBar("Enter your name", title: "Name");
      } else if (phone.isEmpty) {
        ShowErrorSnackBar("Enter your phone", title: "Phone");
      } else if (password.isEmpty) {
        ShowErrorSnackBar("Enter your password", title: "Password");
      } else if (!GetUtils.isPhoneNumber(phone)) {
        ShowErrorSnackBar("Enter a valid phone number", title: "Valid phone");
      } else if (password.length < 6) {
        ShowErrorSnackBar("Password can not be less than 6 characters",
            title: "Valid password");
      } else {
        SignUpBody signUpBody =
            SignUpBody(name: username, phone: phone, password: password);
        authController.registration(signUpBody).then((status) {
          if (status.isSuccess) {
            ShowSuccessSnackBar(username, title: "注册成功!");
            print(Appconstants.TOKEN);
            Get.toNamed(RouteHelper.getUserPreferencePage(0));
          } else {
            ShowErrorSnackBar(status.message, title: "注册失败!");
          }
        });
      }
    }

    return GetBuilder<AuthController>(builder: (authController) {
      return SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              width: Dimension.screenWidth,
              height: Dimension.screenHeight * 0.43,
              decoration: BoxDecoration(
                  //background
                  image: DecorationImage(
                fit: BoxFit.fitWidth,
                image: AssetImage("graphics/register.png"),
              )),
            ),
            Container(
                margin: EdgeInsets.only(top: Dimension.gap10),
                child: BigText(
                  text: 'CREATE YOUR ACCOUNT',
                  color: AppColors.fontColor5,
                  size: Dimension.gap15,
                )),
            //username
            Container(
              width: Dimension.screenWidth * 0.8,
              margin: EdgeInsets.only(top: Dimension.gap10),
              child: InputTextField(
                  textEditingController: usernameController,
                  hintText: "Enter Your Username",
                  icon: Icons.person),
            ),
            //phone
            Container(
              width: Dimension.screenWidth * 0.8,
              margin: EdgeInsets.only(top: Dimension.gap20),
              child: InputTextField(
                  textEditingController: phoneController,
                  hintText: "Enter Your Phone Number",
                  icon: Icons.phone),
            ),
            //password
            Container(
              width: Dimension.screenWidth * 0.8,
              margin: EdgeInsets.only(top: Dimension.gap20),
              child: InputTextField(
                textEditingController: passwordController,
                hintText: "Enter Your Password",
                icon: Icons.lock,
                isObscure: true,
              ),
            ),
            GestureDetector(
              onTap: () {
                _registeration(authController);
              },
              child: Container(
                  width: Dimension.gap30 * 4,
                  margin: EdgeInsets.only(
                    top: Dimension.gap30,
                  ),
                  padding: EdgeInsets.only(
                      top: Dimension.gap10,
                      bottom: Dimension.gap10,
                      left: Dimension.gap15,
                      right: Dimension.gap15),
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
                        "Register",
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
            Container(
              margin: EdgeInsets.only(top: Dimension.gap20),
              child: SmallTextLine(
                text: 'By creating account, you accept terms and conditions',
                size: Dimension.gap10,
              ),
            )
          ],
        ),
      );
    });
  }
}
