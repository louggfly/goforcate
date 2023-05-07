import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/dimensions.dart';

class InputTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final IconData icon;
  bool isObscure;

  InputTextField(
      {Key? key,
      required this.textEditingController,
      required this.hintText,
      required this.icon,
      this.isObscure = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.bottomColor1,
        borderRadius: BorderRadius.circular(Dimension.gap20),
      ),
      child: TextField(
        obscureText: isObscure ? true : false,
        controller: textEditingController,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
              color: AppColors.fontColor5,
              fontWeight: FontWeight.w500,
              fontSize: Dimension.gap15),
          prefixIcon: Icon(
            icon,
            color: AppColors.fontColor5,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimension.gap20),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimension.gap20),
              borderSide: BorderSide(
                  width: Dimension.gap2, color: AppColors.mainColor2)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimension.gap20),
              borderSide: BorderSide(width: 1.5, color: Colors.white)),
        ),
      ),
    );
  }
}
