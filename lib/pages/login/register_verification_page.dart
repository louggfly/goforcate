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

class RegisterVerPage extends StatefulWidget {
  const RegisterVerPage({Key? key}) : super(key: key);

  @override
  _RegisterVerPageState createState() => _RegisterVerPageState();
}

class _RegisterVerPageState extends State<RegisterVerPage> {
  bool _checkboxSelected = false;

  @override
  Widget build(BuildContext context) {
    var phoneController = TextEditingController();
    var pinController = TextEditingController();
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              width: Dimension.screenWidth,
              height: Dimension.screenHeight * 0.58,
              child: Container(
                margin: EdgeInsets.only(
                    bottom: Dimension.screenHeight * 0.45,
                    left: Dimension.screenWidth * 0.1,
                    right: Dimension.screenWidth * 0.1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteHelper.getLogin());
                      },
                      child: Text(
                        "Login",
                        maxLines: 1,
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            color: AppColors.fontColor6,
                            fontSize: Dimension.gap15 * 1.1,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteHelper.getLogin());
                      },
                      child: Text(
                        "Register",
                        maxLines: 1,
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            color: AppColors.fontColor6,
                            fontSize: Dimension.gap15 * 1.1,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteHelper.getLogin());
                      },
                      child: Text(
                        "Quick Login",
                        maxLines: 1,
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            color: AppColors.fontColor6,
                            fontSize: Dimension.gap15 * 1.1,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
              ),
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
                  text: 'Phone Verification',
                  color: AppColors.fontColor5,
                  size: Dimension.gap20 * 0.9,
                )),
            Container(
                margin: EdgeInsets.only(top: Dimension.gap10),
                child: BigText(
                  text: 'Verification has been send to',
                  color: AppColors.fontColor5,
                  size: Dimension.gap15,
                )),
            //phone
            Container(
              width: Dimension.screenWidth * 0.9,
              margin: EdgeInsets.only(top: Dimension.gap10),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.bottomColor1,
                  borderRadius: BorderRadius.circular(Dimension.gap20),
                ),
                child: TextField(
                  controller: phoneController,
                  decoration: InputDecoration(
                    hintText: "12312312311",
                    hintStyle: TextStyle(
                        color: AppColors.fontColor1,
                        fontWeight: FontWeight.w500),
                    prefixIcon: Icon(
                      Icons.phone,
                      color: AppColors.fontColor1,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Dimension.gap20),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Dimension.gap20),
                        borderSide: BorderSide(
                            width: Dimension.gap2,
                            color: AppColors.mainColor2)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Dimension.gap20),
                        borderSide:
                            BorderSide(width: 1.5, color: Colors.white)),
                  ),
                ),
              ),
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
                    Get.toNamed(RouteHelper.getUserProfileEdit());
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
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Get.back(),
                              text: "Remember me",
                              style: TextStyle(
                                color: AppColors.mainColor2,
                                fontSize: Dimension.gap15,
                              )))
                    ],
                  ),
                ],
              ),
            ),
            //login button
            GestureDetector(
              onTap: () {
                Get.toNamed(RouteHelper.getUserProfileEdit());
              },
              child: Container(
                  width: Dimension.gap30 * 4,
                  margin: EdgeInsets.only(
                    top: Dimension.gap10,
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
                            fontSize: Dimension.gap20, //fontBig或者size
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
