import 'package:flutter/material.dart';
import 'package:goforcate_app/widgets/user_avatar.dart';

import '../utils/colors.dart';
import '../utils/dimensions.dart';
import 'expandable_text.dart';

class CommentItem extends StatelessWidget {
  final String image;
  final int userId;
  final int grade;
  final String text;

  const CommentItem(
      {Key? key,
      required this.image,
      required this.userId,
      required this.grade,
      required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: Dimension.gap10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimension.gap10),
        border: Border.all(color: AppColors.fontColor1),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(
                top: Dimension.gap5,
                bottom: Dimension.gap5,
                right: Dimension.gap2,
                left: Dimension.gap2),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(Dimension.gap10),
            ),
            child: Image.network(
              image,
              height: Dimension.screenHeight * 0.3,
              fit: BoxFit.fitHeight,
            ),
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          top: Dimension.gap5,
                          bottom: Dimension.gap5,
                          left: Dimension.gap5,
                          right: Dimension.gap5),
                      child: UserAvatar(
                          userId: userId,
                          nameColor: AppColors.fontColor1,
                          avatarSize: Dimension.gap20,
                          nameSize: Dimension.gap10,
                          backGroundColor: Colors.white),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: Dimension.gap10,
                    ),
                    Wrap(
                      //评分星级
                      children: List.generate(
                          grade,
                          (index) => Icon(Icons.star,
                              color: AppColors.mainColor1,
                              size: Dimension.gap15)),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(
                      top: Dimension.gap5,
                      bottom: Dimension.gap5,
                      left: Dimension.gap5,
                      right: Dimension.gap5),
                  child: ExpandableText(
                    text: text,
                    size: 0.8,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
