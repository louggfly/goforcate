import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:goforcate_app/utils/colors.dart';
import 'package:goforcate_app/widgets/big_text.dart';
import 'package:goforcate_app/widgets/text_field.dart';

import '../../routes/route_helper.dart';
import '../../utils/dimensions.dart';

class LoginQuickPage extends StatefulWidget {
  const LoginQuickPage({Key? key}) : super(key: key);

  @override
  _LoginQuickPageState createState() => _LoginQuickPageState();
}

class _LoginQuickPageState extends State<LoginQuickPage> {
  bool _checkboxSelected = false;

  @override
  Widget build(BuildContext context) {
    var phoneController = TextEditingController();
    var pinController = TextEditingController();
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
              image: AssetImage("graphics/quicklogin.png"),
            )),
          ),
          Container(
              margin: EdgeInsets.only(top: Dimension.gap10),
              child: BigText(
                text: 'LOGIN TO YOUR ACCOUNT',
                color: AppColors.fontColor5,
                size: Dimension.gap15,
              )),
          //phone
          Container(
            width: Dimension.screenWidth * 0.9,
            margin: EdgeInsets.only(top: Dimension.gap10),
            child: InputTextField(
                textEditingController: phoneController,
                hintText: "Phone Number",
                icon: Icons.phone),
          ),
          //pin
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: Dimension.screenWidth * 0.6,
                margin: EdgeInsets.only(top: Dimension.gap20),
                child: InputTextField(
                    textEditingController: pinController,
                    hintText: "Enter Your Pin",
                    icon: Icons.lock),
              ),
              GestureDetector(
                onTap: () {
                },
                child: Container(
                    width: Dimension.screenWidth * 0.3 - Dimension.gap10,
                    margin: EdgeInsets.only(
                        top: Dimension.gap20, left: Dimension.gap10),
                    padding: EdgeInsets.only(
                      top: Dimension.gap15,
                      bottom: Dimension.gap15,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimension.gap20),
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
                          "RESEND",
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
            ],
          ),
          //remember
          Container(
            width: Dimension.screenWidth * 0.9,
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
          //login button
          GestureDetector(
            onTap: () {
            },
            child: Container(
                width: Dimension.gap30 * 4,
                margin: EdgeInsets.only(
                  top: Dimension.gap20,
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
  }
}
