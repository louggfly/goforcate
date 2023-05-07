import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goforcate_app/controllers/user_controller.dart';
import 'package:goforcate_app/models/user_model.dart';
import 'package:goforcate_app/utils/colors.dart';

import '../routes/route_helper.dart';
import '../utils/dimensions.dart';

class UserAvatar extends StatelessWidget {
  final int userId;
  final Color nameColor;
  final Color backGroundColor;
  final double avatarSize;
  final double nameSize;

  const UserAvatar(
      {Key? key,
      required this.userId,
      required this.nameColor,
      required this.avatarSize,
      required this.nameSize,
      required this.backGroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    late UserModel user;
    user = Get.find<UserController>().userList[userId - 1];
    return Container(
        padding: EdgeInsets.only(
            top: Dimension.gap2,
            bottom: Dimension.gap2,
            left: Dimension.gap5,
            right: Dimension.gap5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(999),
          color: backGroundColor,
          border: Border.all(
              width: Dimension.gap2 * 0.8, color: AppColors.borderColor1),
        ),
        child: GestureDetector(
          onTap: () {
            Get.toNamed(RouteHelper.getOtherUser(userId));
          },
          child: Row(
            children: [
              Container(
                height: avatarSize,
                width: avatarSize,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(999),
                  color: Colors.purple,
                  border: Border.all(
                      width: Dimension.gap2 * 0.8,
                      color: AppColors.borderColor1),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(user.avatar!),
                  ),
                ),
              ),
              SizedBox(
                width: Dimension.gap5,
              ),
              Container(
                child: Text(
                  user.username!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: nameColor,
                      fontSize: nameSize, //fontBig或者size
                      fontWeight: FontWeight.w600),
                ),
              )
            ],
          ),
        ));
  }
}
