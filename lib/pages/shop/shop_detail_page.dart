import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:goforcate_app/controllers/shop_controller.dart';
import 'package:goforcate_app/controllers/user_controller.dart';
import 'package:goforcate_app/models/shop_model.dart';
import 'package:goforcate_app/utils/colors.dart';
import 'package:goforcate_app/utils/dimensions.dart';
import 'package:goforcate_app/widgets/button_icon.dart';
import 'package:goforcate_app/widgets/button_icon_text.dart';
import 'package:goforcate_app/widgets/shop_comments.dart';
import 'package:goforcate_app/widgets/shop_information.dart';

import '../../routes/route_helper.dart';
import '../../widgets/big_text.dart';

class ShopDetailPage extends StatefulWidget {
  final int shopId;

  const ShopDetailPage({Key? key, required this.shopId}) : super(key: key);

  @override
  _ShopDetailPageState createState() => _ShopDetailPageState();
}

class _ShopDetailPageState extends State<ShopDetailPage> {
  bool _isFavorutie = false;
  bool _isAllLoading = false;

  @override
  void initState() {
    super.initState();
    Get.find<ShopController>().getShopInfo(widget.shopId).then((status) {
      if (status.isSuccess) {
        Get.find<ShopController>()
            .getShopCommentList(widget.shopId)
            .then((status) {
          if (status.isSuccess) {
            _isAllLoading = true;
          }
        });
      }
    });
    int userId = Get.find<UserController>().userModel.id!;
    Get.find<UserController>().getUserFavourite(userId);
    List<dynamic> userFavourite = Get.find<UserController>().userFavourite;
    for (ShopModel shopModel in userFavourite) {
      if (shopModel.id == widget.shopId) {
        _isFavorutie = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    void _favouriteShop() {
      Get.find<UserController>().createFavourite(widget.shopId);
      _isFavorutie = true;
    }

    void _deleteShop() {
      Get.find<UserController>().deleteFavourite(widget.shopId);
      _isFavorutie = false;
    }

    return Scaffold(
      body: GetBuilder<ShopController>(builder: (shopController) {
        return _isAllLoading
            ? Stack(
                children: [
                  //shop information
                  Stack(
                    children: [
                      //pictures
                      Positioned(
                        left: 0,
                        right: 0,
                        child: Container(
                          width: double.maxFinite,
                          height: Dimension.shopPicContainer,
                          decoration: BoxDecoration(
                              //background
                              image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage("graphics/logopage.png"),
                          )),
                          //shopimage
                          child: Image(
                            image: NetworkImage(
                                shopController.shopModel.coverPic!),
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                      //information
                      Positioned(
                        top: Dimension.shopPicContainer - 20,
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(Dimension.gap15),
                              topRight: Radius.circular(Dimension.gap15),
                            ),
                            color: Colors.white,
                          ),
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(
                                      left: Dimension.gap20,
                                      right: Dimension.gap20),
                                  child: ShopInformation(
                                      name: shopController.shopModel.name!,
                                      num_com:
                                          shopController.shopModel.comments!,
                                      distance: "99",
                                      location:
                                          shopController.shopModel.address!,
                                      grade: shopController.shopModel.grade!,
                                      size: 1,
                                      openTime:
                                          shopController.shopModel.opentime!,
                                      phone: shopController.shopModel.phone!),
                                ),
                                //comments
                                Container(
                                  height: Dimension.gap5,
                                  width: double.maxFinite,
                                  decoration:
                                      BoxDecoration(color: Colors.black12),
                                ),
                                SizedBox(
                                  height: Dimension.gap5,
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                      left: Dimension.gap10,
                                      right: Dimension.gap20),
                                  child: BigText(
                                    text: "用户评价",
                                    size: Dimension.fontMedium * 1.2,
                                  ),
                                ),
                                Container(
                                  height: Dimension.screenHeight * 0.35,
                                  child: ListView.builder(
                                      physics: AlwaysScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: shopController
                                          .shopCommentList.shopComments.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            Get.toNamed(
                                                RouteHelper.getShopComment(
                                                    shopController
                                                        .shopCommentList
                                                        .shopComments[index]
                                                        .commentId!,
                                                    widget.shopId));
                                          },
                                          child: ShopComments(
                                              shopComment: shopController
                                                  .shopCommentList
                                                  .shopComments[index]),
                                        );
                                      }),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  //introduction
                  //buttons
                  Container(
                    padding: EdgeInsets.only(
                        top: Dimension.gap30 * 1.2,
                        left: Dimension.gap20,
                        right: Dimension.gap20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(RouteHelper.getInital(0));
                          },
                          child: ButtonIcon(
                              icon: Icons.arrow_back_outlined,
                              iconColor: AppColors.mainColor2,
                              backGroundColor: Colors.white,
                              iconSize: Dimension.icon30),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              if (_isFavorutie) {
                                _deleteShop();
                              } else {
                                _favouriteShop();
                              }
                            });
                          },
                          child: !_isFavorutie
                              ? ButtonIcon(
                                  icon: Icons.favorite_border,
                                  iconColor: AppColors.mainColor2,
                                  backGroundColor: Colors.white,
                                  iconSize: Dimension.icon30)
                              : ButtonIcon(
                                  icon: Icons.favorite,
                                  iconColor: AppColors.mainColor1,
                                  backGroundColor: Colors.white,
                                  iconSize: Dimension.icon30),
                        )
                      ],
                    ),
                  ),
                ],
              )
            : Center(
                child: CircularProgressIndicator(),
              );
      }),
      bottomNavigationBar: Container(
        height: Dimension.screenHeight * 0.1,
        padding: EdgeInsets.only(
            top: Dimension.gap15,
            bottom: Dimension.gap15,
            left: Dimension.gap15,
            right: Dimension.gap15),
        decoration: BoxDecoration(
          color: Colors.white,
          border:
              Border.all(width: Dimension.gap2, color: AppColors.mainColor2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Get.toNamed(RouteHelper.getGroupCreate(widget.shopId));
              },
              child: ButtonIconText(
                  icon: Icons.local_dining_sharp,
                  iconColor: AppColors.fontColor1,
                  backGroundColor: AppColors.buttonColor1,
                  buttonSize: Dimension.gap30 * 2,
                  iconSize: Dimension.gap30,
                  text: "GoForCate",
                  textColor: AppColors.fontColor1,
                  textSize: Dimension.gap15),
            ),
            GestureDetector(
              onTap: () {
                Get.toNamed(RouteHelper.getReleaseComment(widget.shopId));
              },
              child: ButtonIconText(
                  icon: Icons.post_add,
                  iconColor: AppColors.fontColor1,
                  backGroundColor: AppColors.buttonColor1,
                  buttonSize: Dimension.gap30 * 2,
                  iconSize: Dimension.gap30,
                  text: "发布评价",
                  textColor: AppColors.fontColor1,
                  textSize: Dimension.gap15),
            ),
          ],
        ),
      ),
    );
  }
}
