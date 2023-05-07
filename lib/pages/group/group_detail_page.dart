import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:goforcate_app/controllers/group_controller.dart';
import 'package:goforcate_app/models/group_model.dart';
import 'package:goforcate_app/widgets/user_avatar.dart';

import '../../base/show_custom_snackbar.dart';
import '../../controllers/shop_controller.dart';
import '../../models/shop_model.dart';
import '../../routes/route_helper.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/big_text.dart';
import '../../widgets/button_icon.dart';
import '../../widgets/home_shoplist.dart';

class GroupDetailPage extends StatefulWidget {
  final int groupId;

  const GroupDetailPage({Key? key, required this.groupId}) : super(key: key);

  @override
  _GroupDetailPageState createState() => _GroupDetailPageState();
}

class _GroupDetailPageState extends State<GroupDetailPage> {
  bool _isAllLoading = false;
  late GroupModel groupModel;
  late ShopModel shopModel;

  @override
  void initState() {
    super.initState();
    Get.find<GroupController>().getGroup(widget.groupId).then((status) {
      groupModel = Get.find<GroupController>().groupModel;
      Get.find<ShopController>()
          .getShopInfo(Get.find<GroupController>().groupModel.shop_id!)
          .then((status) {
        if (status.isSuccess) {
          setState(() {
            shopModel = Get.find<ShopController>().shopModel;
            _isAllLoading = true;
            print(_isAllLoading);
          });
        }
      });
    });
  }

  Future<void> deleteGroup(int groupId) async {
    Get.find<GroupController>().deleteGroup(groupId).then((status) {
      if (status.isSuccess) {
        ShowSuccessSnackBar("", title: "Successfully delete group!");
        Get.toNamed(RouteHelper.getInital(3));
      } else {
        ShowErrorSnackBar(status.message, title: "Failed to delete group!");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    void _showConfirmDialog(int groupId) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Delete Group'),
            content: Text('Are you sure you want to delete this group?'),
            actions: <Widget>[
              MaterialButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              MaterialButton(
                child: Text('Confirm'),
                onPressed: () {
                  deleteGroup(groupId);
                  Navigator.of(context).pop();
                  Get.toNamed(RouteHelper.getInital(3));
                },
              ),
            ],
          );
        },
      );
    }

    return _isAllLoading
        ? Scaffold(
            appBar: AppBar(
              leading: GestureDetector(
                onTap: () {
                  Get.toNamed(RouteHelper.getInital(3));
                },
                child: Container(
                  margin: EdgeInsets.all(Dimension.gap5),
                  child: ButtonIcon(
                      icon: Icons.close,
                      iconColor: AppColors.mainColor2,
                      backGroundColor: Colors.white,
                      iconSize: Dimension.icon30),
                ),
              ),
              backgroundColor: Colors.white,
              title: BigText(
                text: groupModel.name!,
                size: Dimension.gap20 * 1.1,
                color: AppColors.fontColor1,
              ),
              centerTitle: true,
              elevation: 0,
              actions: [
                GestureDetector(
                  onTap: () {
                    _showConfirmDialog(widget.groupId);
                  },
                  child: Container(
                    margin: EdgeInsets.all(Dimension.gap5),
                    child: ButtonIcon(
                        icon: CupertinoIcons.delete_solid,
                        iconColor: Colors.redAccent,
                        backGroundColor: Colors.white,
                        iconSize: Dimension.icon30),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteHelper.getGroupEdit(
                        groupModel.id!, groupModel.shop_id!));
                  },
                  child: Container(
                    margin: EdgeInsets.all(Dimension.gap5),
                    child: ButtonIcon(
                        icon: Icons.edit,
                        iconColor: AppColors.mainColor2,
                        backGroundColor: Colors.white,
                        iconSize: Dimension.icon30),
                  ),
                ),
              ],
            ),
            body: Container(
              margin: EdgeInsets.only(
                  left: Dimension.gap10, right: Dimension.gap10),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteHelper.getShopPage(shopModel.id!));
                    },
                    child: HomeShopList(
                        name: shopModel.name!,
                        num_com: shopModel.comments!,
                        location: shopModel.address!,
                        grade: shopModel.grade!,
                        size: 0.7,
                        image: shopModel.coverPic!,
                        hot_com: "好吃！"),
                  ),
                  Container(
                    width: Dimension.screenWidth,
                    margin: EdgeInsets.all(Dimension.gap10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimension.gap10),
                        color: Colors.white,
                        border: Border.all(
                            width: Dimension.gap2 * 0.8,
                            color: AppColors.fontColor1),
                        boxShadow: const [
                          BoxShadow(
                              color: Color(0xffa7a1a1),
                              blurRadius: 1.0,
                              offset: Offset(1, 1))
                        ]),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: Dimension.gap5),
                          child: BigText(
                            text: "APPOINTMENT TIME",
                            size: Dimension.gap15,
                            color: AppColors.fontColor5,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              top: Dimension.gap10, bottom: Dimension.gap10),
                          child: Text(
                            groupModel.reserve_at!.split("T")[0] +
                                " " +
                                groupModel.reserve_at!
                                    .split("T")[1]
                                    .substring(0, 5),
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                      ],
                    ),
                  ),
                  //select member
                  Container(
                    width: Dimension.screenWidth,
                    margin: EdgeInsets.all(Dimension.gap10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimension.gap10),
                        color: Colors.white,
                        border: Border.all(
                            width: Dimension.gap2 * 0.8,
                            color: AppColors.fontColor1),
                        boxShadow: const [
                          BoxShadow(
                              color: Color(0xffa7a1a1),
                              blurRadius: 1.0,
                              offset: Offset(1, 1))
                        ]),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: Dimension.gap5),
                          child: BigText(
                            text: "MEMBERS",
                            size: Dimension.gap15,
                            color: AppColors.fontColor5,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              top: Dimension.gap5,
                              left: Dimension.gap10,
                              right: Dimension.gap30,
                              bottom: Dimension.gap5),
                          child: Row(
                            children: [
                              Icon(
                                CupertinoIcons.flag_fill,
                                color: AppColors.mainColor2,
                              ),
                              SizedBox(
                                width: Dimension.gap10,
                              ),
                              UserAvatar(
                                  userId: groupModel.leader_id!,
                                  nameColor: Colors.black,
                                  avatarSize: Dimension.gap30,
                                  nameSize: Dimension.fontMedium,
                                  backGroundColor: Colors.white)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ))
        : Center(
            child: CircularProgressIndicator(),
          );
  }
}
