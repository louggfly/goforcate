import 'package:flutter/material.dart';

import '../utils/dimensions.dart';

class ButtonIcon extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color backGroundColor;
  final double iconSize;

  const ButtonIcon(
      {Key? key,
      required this.icon,
      required this.iconColor,
      required this.backGroundColor,
      required this.iconSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: Dimension.gap5,
          bottom: Dimension.gap5,
          left: Dimension.gap5,
          right: Dimension.gap5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        color: backGroundColor,
      ),
      child: Icon(
        icon,
        color: iconColor,
        size: iconSize,
      ),
    );
  }
}
