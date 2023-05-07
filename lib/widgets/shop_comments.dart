import 'package:flutter/material.dart';
import 'package:goforcate_app/widgets/user_avatar.dart';

import '../models/comment_model.dart';
import '../utils/colors.dart';
import '../utils/dimensions.dart';
import 'expandable_text.dart';

class ShopComments extends StatelessWidget {
  final ShopComment shopComment;

  const ShopComments({Key? key, required this.shopComment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          left: Dimension.gap10, top: Dimension.gap5, bottom: Dimension.gap5),
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                child: UserAvatar(
                    userId: shopComment.userId!,
                    nameColor: AppColors.fontColor1,
                    avatarSize: Dimension.gap30,
                    nameSize: Dimension.gap10 * 1.2,
                    backGroundColor: Colors.white),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                  child: SingleChildScrollView(
                padding: EdgeInsets.only(
                    left: Dimension.gap20,
                    top: Dimension.gap5,
                    bottom: Dimension.gap5,
                    right: Dimension.gap20),
                child: ExpandableText(
                  text: shopComment.content!,
                  size: 1,
                ),
              )),
            ],
          ),
          Container(
            width: Dimension.screenWidth,
            height: Dimension.gap30 * 4,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: shopComment.picturecount,
                itemBuilder: (context, index) {
                  return Container(
                    width: Dimension.gap30 * 4,
                    height: Dimension.gap30 * 4,
                    padding: EdgeInsets.all(Dimension.gap5),
                    child: Image(
                      image: NetworkImage(
                          shopComment.pictures[index].pictureLink!),
                      fit: BoxFit.fill,
                    ),
                  );
                }),
          ),
          SizedBox(
            height: Dimension.gap5,
          ),
          Container(
            height: Dimension.gap2,
            width: double.maxFinite,
            decoration: BoxDecoration(color: Colors.black12),
          ),
          SizedBox(
            height: Dimension.gap2,
          ),
        ],
      ),
    );
  }
}
