import 'package:flutter/material.dart';
import 'package:goforcate_app/utils/dimensions.dart';
import 'package:goforcate_app/widgets/small_text.dart';

class IconTextMore extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color iconColor;
  final Color textColor;

  const IconTextMore(
      {Key? key,
      required this.icon,
      required this.text,
      required this.iconColor,
      required this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: iconColor,
          size: Dimension.gap20,
        ),
        SizedBox(
          width: Dimension.gap5,
        ),
        Container(
          width: Dimension.screenWidth * 0.6,
          child: SmallText(
            text: text,
            color: textColor,
            size: Dimension.fontSmall * 1,
          ),
        ),
      ],
    );
  }
}
