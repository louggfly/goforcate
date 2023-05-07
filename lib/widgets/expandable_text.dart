import 'package:flutter/material.dart';
import 'package:goforcate_app/utils/colors.dart';
import 'package:goforcate_app/utils/dimensions.dart';
import 'package:goforcate_app/widgets/small_text.dart';
import 'package:goforcate_app/widgets/small_text_line.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  final double size;

  const ExpandableText({Key? key, required this.text, required this.size})
      : super(key: key);

  @override
  _ExpandableTextState createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  late String firstHalf;
  late String secondHalf;

  bool hiddenText = true;
  double textHeight = Dimension.screenHeight / 10;

  @override
  void initState() {
    super.initState();
    if (widget.text.length > textHeight) {
      firstHalf = widget.text.substring(0, textHeight.toInt());
      secondHalf =
          widget.text.substring(textHeight.toInt() + 1, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty
          ? SmallText(
              text: firstHalf,
              size: Dimension.gap15 * 0.9 * widget.size,
              color: AppColors.fontColor3,
            )
          : Column(
              children: [
                SmallTextLine(
                  text: hiddenText
                      ? (firstHalf + "...")
                      : (firstHalf + secondHalf),
                  size: Dimension.fontMedium * 0.9 * widget.size,
                  color: AppColors.fontColor3,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      hiddenText = !hiddenText;
                    });
                  },
                  child: Row(
                    children: [
                      SmallTextLine(
                        text: "Show More",
                        color: AppColors.fontColor3,
                        size: Dimension.fontMedium * 0.9 * widget.size,
                      ),
                      Icon(hiddenText
                          ? Icons.keyboard_arrow_down_sharp
                          : Icons.keyboard_arrow_up),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
