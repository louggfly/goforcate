import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:goforcate_app/controllers/shop_controller.dart';
import 'package:goforcate_app/routes/route_helper.dart';
import 'package:goforcate_app/widgets/button_icon.dart';
import 'package:goforcate_app/widgets/home_shoplist.dart';
import 'package:goforcate_app/widgets/user_avatar.dart';

import '../../controllers/user_controller.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/small_text.dart';

class UserCommentPage extends StatefulWidget {
  final int commentId;
  final int shopId;

  const UserCommentPage(
      {Key? key, required this.commentId, required this.shopId})
      : super(key: key);

  @override
  _UserCommentPageState createState() => _UserCommentPageState();
}

class _UserCommentPageState extends State<UserCommentPage> {
  @override
  Widget build(BuildContext context) {
    bool _isAllLoading = false;
    Get.find<ShopController>().getShopInfo(widget.shopId).then((status) {
      if (status.isSuccess) {
        Get.find<ShopController>()
            .getShopComment(widget.commentId)
            .then((status) {
          if (status.isSuccess) {
            _isAllLoading = true;
          }
        });
      }
    });

    void _showConfirmDialog(int commentId) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Delete Comment'),
            content: Text('Are you sure you want to delete this Comment?'),
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
                  Get.find<UserController>().deleteUserComment(commentId);
                  Navigator.of(context).pop();
                  Get.toNamed(RouteHelper.getInital(4));
                },
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      body: GetBuilder<ShopController>(
        builder: (shopController) {
          return _isAllLoading
              ? CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      automaticallyImplyLeading: false,
                      toolbarHeight: Dimension.gap20 * 9,
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(RouteHelper.getInital(4));
                            },
                            child: ButtonIcon(
                                icon: Icons.close,
                                iconColor: AppColors.mainColor2,
                                backGroundColor: Colors.white,
                                iconSize: Dimension.icon30),
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  _showConfirmDialog(widget.commentId);
                                },
                                child: ButtonIcon(
                                    icon: Icons.delete_forever_rounded,
                                    iconColor: AppColors.fontColor1,
                                    backGroundColor: Colors.white,
                                    iconSize: Dimension.icon30),
                              ),
                              SizedBox(
                                width: Dimension.gap10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(RouteHelper.getUserCommentEdit(
                                      widget.commentId, widget.shopId));
                                },
                                child: ButtonIcon(
                                    icon: Icons.edit,
                                    iconColor: AppColors.mainColor2,
                                    backGroundColor: Colors.white,
                                    iconSize: Dimension.icon30),
                              ),
                            ],
                          )
                        ],
                      ),
                      bottom: PreferredSize(
                        preferredSize: Size.fromHeight(20),
                        child: HomeShopList(
                            name: shopController.shopModel.name!,
                            num_com: shopController.shopModel.comments!,
                            location: shopController.shopModel.address!,
                            grade: shopController.shopModel.grade!,
                            size: 0.7,
                            image: shopController.shopModel.coverPic!,
                            hot_com: ""),
                      ),
                      pinned: true,
                      expandedHeight: 300,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Image.network(
                          shopController.shopModel.coverPic!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(
                                      top: Dimension.gap15,
                                      bottom: Dimension.gap5,
                                      left: Dimension.gap10,
                                      right: Dimension.gap5),
                                  child: UserAvatar(
                                      userId:
                                          shopController.shopComment.userId!,
                                      nameColor: AppColors.fontColor1,
                                      avatarSize: Dimension.gap30,
                                      nameSize: Dimension.gap15,
                                      backGroundColor: Colors.white),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: Dimension.gap10,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: Dimension.gap15,
                                ),
                                SmallText(
                                    text: "评分：",
                                    color: AppColors.fontColor1,
                                    size: Dimension.gap15),
                                Wrap(
                                  //评分星级
                                  children: List.generate(
                                      shopController.shopComment.grade!.round(),
                                      (index) => Icon(Icons.star,
                                          color: AppColors.mainColor1,
                                          size: Dimension.gap20 * 1.2)),
                                ),
                                SizedBox(
                                  width: Dimension.gap5,
                                ),
                                SmallText(
                                    text: shopController.shopComment.grade!
                                        .toString(),
                                    color: AppColors.fontColor2,
                                    size: Dimension.gap15),
                              ],
                            ),
                            Container(
                              child: Text(shopController.shopComment.content!),
                              margin: EdgeInsets.only(
                                  left: Dimension.gap15,
                                  right: Dimension.gap15,
                                  bottom: Dimension.gap10,
                                  top: Dimension.gap10),
                            ),
                            SizedBox(
                              height: Dimension.gap10,
                            ),
                            Container(
                              width: Dimension.screenWidth - Dimension.gap20,
                              child: ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount:
                                      shopController.shopComment.picturecount,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin: EdgeInsets.only(
                                          left: Dimension.gap15,
                                          right: Dimension.gap15,
                                          bottom: Dimension.gap10,
                                          top: Dimension.gap10),
                                      child: Column(
                                        children: [
                                          Image.network(shopController
                                              .shopComment
                                              .pictures[index]
                                              .pictureLink!),
                                          SizedBox(
                                            height: Dimension.gap5,
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                )
              : Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}
