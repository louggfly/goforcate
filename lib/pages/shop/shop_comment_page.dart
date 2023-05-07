import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:goforcate_app/controllers/shop_controller.dart';
import 'package:goforcate_app/routes/route_helper.dart';
import 'package:goforcate_app/widgets/button_icon.dart';
import 'package:goforcate_app/widgets/home_shoplist.dart';
import 'package:goforcate_app/widgets/user_avatar.dart';

import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/small_text.dart';

class ShopPageComment extends StatelessWidget {
  int commentId;
  int shopId;

  ShopPageComment({Key? key, required this.commentId, required this.shopId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _isAllLoading = false;
    Get.find<ShopController>().getShopInfo(shopId).then((status) {
      if (status.isSuccess) {
        Get.find<ShopController>().getShopComment(commentId).then((status) {
          if (status.isSuccess) {
            _isAllLoading = true;
          }
        });
      }
    });

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
                              Get.toNamed(RouteHelper.getShopPage(shopId));
                            },
                            child: ButtonIcon(
                                icon: Icons.close,
                                iconColor: AppColors.mainColor2,
                                backGroundColor: Colors.white,
                                iconSize: Dimension.icon30),
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
