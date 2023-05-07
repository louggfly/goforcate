import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/dimensions.dart';

class EditTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final int length;

  EditTextField({
    Key? key,
    required this.textEditingController,
    required this.hintText,
    required this.length,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimension.gap20),
      ),
      child: TextField(
        style: TextStyle(fontSize: Dimension.gap15),
        maxLines: null,
        maxLength: length,
        controller: textEditingController,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(Dimension.gap10),
          counterText: "",
          hintText: hintText,
          hintStyle: TextStyle(
              color: AppColors.fontColor5, fontWeight: FontWeight.w500),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimension.gap20),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimension.gap20),
              borderSide:
                  BorderSide(width: Dimension.gap2, color: Colors.white)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimension.gap20),
              borderSide: BorderSide(width: 1.5, color: Colors.white)),
        ),
      ),
    );
  }
}
