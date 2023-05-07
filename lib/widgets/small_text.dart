import 'package:flutter/material.dart';
import 'package:goforcate_app/utils/dimensions.dart';

class SmallText extends StatelessWidget {
  final Color? color;
  final String text;
  double size;
  double height;

  SmallText(
      {Key? key,
      this.color = const Color(0xFF8B8B8B), //const后无法使用appcolor
      required this.text,
      this.size = 0,
      this.height = 1.2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          fontFamily: 'Roboto',
          color: color,
          fontSize: size == 0 ? Dimension.fontSmall : size,
          height: height,
          fontWeight: FontWeight.w500),
    );
  }
}
