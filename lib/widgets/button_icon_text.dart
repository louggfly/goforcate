import 'package:flutter/material.dart';

import '../utils/dimensions.dart';

class ButtonIconText extends StatelessWidget {
  final IconData icon;
  final String text;
  final double buttonSize;
  final Color iconColor;
  final Color textColor;
  final Color backGroundColor;
  final double iconSize;
  final double textSize;

  const ButtonIconText(
      {Key? key,
      required this.icon,
      required this.iconColor,
      required this.backGroundColor,
      required this.buttonSize,
      required this.iconSize,
      required this.text,
      required this.textColor,
      required this.textSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(
            top: Dimension.gap10,
            bottom: Dimension.gap10,
            left: Dimension.gap15,
            right: Dimension.gap15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(buttonSize),
          color: backGroundColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: iconColor,
              size: iconSize,
            ),
            SizedBox(
              width: Dimension.gap10,
            ),
            Text(
              text,
              maxLines: 1,
              style: TextStyle(
                  fontFamily: 'Roboto',
                  color: textColor,
                  fontSize: textSize, //fontBig或者size
                  fontWeight: FontWeight.w600),
            ),
          ],
        ));
  }
}
