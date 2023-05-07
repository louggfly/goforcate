import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goforcate_app/controllers/area_controller.dart';
import 'package:goforcate_app/controllers/group_controller.dart';
import 'package:goforcate_app/controllers/shoplist_controller.dart';
import 'package:goforcate_app/controllers/user_controller.dart';
import 'package:goforcate_app/models/group_model.dart';
import 'package:goforcate_app/models/shop_model.dart';
import 'package:goforcate_app/utils/dimensions.dart';
import 'package:goforcate_app/widgets/big_text.dart';
import 'package:goforcate_app/widgets/button_icon.dart';
import 'package:goforcate_app/widgets/icon_text.dart';
import 'package:goforcate_app/widgets/user_avatar.dart';

import '../../controllers/shop_controller.dart';
import '../../routes/route_helper.dart';
import '../../utils/colors.dart';
import '../../widgets/button_icon_text.dart';
import '../../widgets/small_text.dart';

class GoForCatePage extends StatefulWidget {
  const GoForCatePage({Key? key}) : super(key: key);

  @override
  _GoForCatePageState createState() => _GoForCatePageState();
}

class _GoForCatePageState extends State<GoForCatePage>
    with TickerProviderStateMixin {
  late TabController _tabController = TabController(length: 2, vsync: this);

  @override
  Widget build(BuildContext context) {
    GroupModel recentGroup = Get.find<GroupController>().getRecentGroup();
    print(recentGroup.id);
    print(recentGroup.shop_id);
    ShopModel shopModel = Get.find<ShopListController>().getShop(recentGroup.shop_id!);

    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(bottom: Dimension.gap10),
            width: double.maxFinite,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("graphics/topbackground.png"),
              ),
            ),
            child: Column(
              children: [
                //first line
                Row(
                  children: [
                    //district
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteHelper.getChooseArea(2));
                      },
                      child: Container(
                          margin: EdgeInsets.only(
                              top: Dimension.gap30,
                              bottom: Dimension.gap2,
                              left: Dimension.gap15,
                              right: Dimension.gap5),
                          padding: EdgeInsets.only(
                              left: Dimension.gap10, right: Dimension.gap5),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimension.gap15),
                            color: Colors.white,
                            border: Border.all(
                                width: Dimension.gap2 * 0.8,
                                color: AppColors.borderColor1),
                          ),
                          child: Row(
                            children: [
                              SmallText(
                                text: Get.find<AreaController>().getUserArea(),
                                size: Dimension.fontSmall * 1.1,
                                color: Colors.black,
                              ),
                              Icon(
                                Icons.keyboard_arrow_down_outlined,
                                color: Colors.black,
                                size: Dimension.gap30,
                              ),
                            ],
                          )),
                    ),
                    //search
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteHelper.getInputSearch(2));
                      },
                      child: Container(
                          width: Dimension.screenWidth * 0.5,
                          margin: EdgeInsets.only(
                              top: Dimension.gap30,
                              bottom: Dimension.gap2,
                              left: Dimension.gap15,
                              right: Dimension.gap5),
                          padding: EdgeInsets.only(
                              left: Dimension.gap30 * 1.6,
                              right: Dimension.gap30 * 1.6),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimension.gap15),
                            color: Colors.white,
                            border: Border.all(
                                width: Dimension.gap2 * 0.8,
                                color: AppColors.borderColor1),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.search,
                                color: Colors.black26,
                                size: Dimension.gap30,
                              ),
                              SmallText(
                                text: 'Search',
                                size: Dimension.fontSmall * 1.1,
                                color: Colors.black26,
                              ),
                            ],
                          )),
                    ),
                    //message
                    GestureDetector(
                      onTap: (){
                        Get.toNamed(RouteHelper.getNoticePage());
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            top: Dimension.gap30,
                            bottom: Dimension.gap2,
                            left: Dimension.gap15,
                            right: Dimension.gap5),
                        child: ButtonIcon(
                            icon: CupertinoIcons.bell_fill,
                            iconColor: AppColors.mainColor2,
                            backGroundColor: Colors.white,
                            iconSize: Dimension.gap20),
                      ),
                    ),
                  ],
                ),
                //second line
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          top: Dimension.gap5,
                          bottom: Dimension.gap2,
                          left: Dimension.gap15,
                          right: Dimension.gap5),
                      child: UserAvatar(
                          userId: Get.find<UserController>().userModel.id!,
                          nameColor: Colors.black,
                          avatarSize: Dimension.gap30,
                          nameSize: Dimension.fontMedium,
                          backGroundColor: Colors.white),
                    ),
                    SizedBox(
                      width: Dimension.gap10,
                    ),
                    BigText(
                      text: "Welcome you!",
                      size: Dimension.fontMedium * 1.2,
                      color: Colors.white,
                    )
                  ],
                ),
                //schdule
                recentGroup.id!=0?Stack(
                  children: [
                    Positioned(
                      child: Container(
                        margin: EdgeInsets.only(
                            top: Dimension.gap5,
                            bottom: Dimension.gap2,
                            left: Dimension.gap15,
                            right: Dimension.gap30 * 2),
                        padding: EdgeInsets.only(
                            top: Dimension.gap2,
                            bottom: Dimension.gap2,
                            left: Dimension.gap5,
                            right: Dimension.gap5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimension.gap10),
                          color: Colors.white,
                          border: Border.all(
                              width: Dimension.gap2 * 0.8,
                              color: AppColors.borderColor1),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.access_time_outlined,
                                  size: Dimension.gap30,
                                ),
                                SizedBox(
                                  width: Dimension.gap10,
                                ),
                                BigText(
                                  text: "${recentGroup.reserve_at!.split("T")[0]} ${recentGroup.reserve_at!.split("T")[1].substring(0,
                                      5)}",
                                  size: Dimension.fontBig *
                                      0.8,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  width: Dimension.gap30 * 3,
                                  height: Dimension.gap30 * 3,
                                  margin: EdgeInsets.only(
                                      top: Dimension.gap2,
                                      bottom: Dimension.gap2,
                                      left: Dimension.gap5,
                                      right: Dimension.gap10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          Dimension.gap10),
                                      color: Colors.purple,
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              shopModel.coverPic!))),
                                ),
                                Container(
                                  width: Dimension.screenWidth * 0.45,
                                  height: Dimension.gap30 * 3,
                                  margin: EdgeInsets.only(
                                    top: Dimension.gap2,
                                    bottom: Dimension.gap2,
                                  ),
                                  child: Column(
                                    children: [
                                      BigText(
                                        text: shopModel.name!,
                                        size: Dimension.gap15 * 1.1,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          IconText(
                                              icon: Icons.location_on_outlined,
                                              text: shopModel.address!,
                                              iconColor: AppColors.fontColor2,
                                              textColor: AppColors.fontColor2),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                        top: Dimension.screenHeight * 0.11,
                        left: Dimension.screenWidth * 0.3,
                        child: GestureDetector(
                          onTap: (){
                            Get.toNamed(RouteHelper.getGroupDetail(recentGroup.id!));
                          },
                          child: Container(
                              margin: EdgeInsets.only(
                                  left: Dimension.gap30 * 4,
                                  top: Dimension.gap5,
                                  bottom: Dimension.gap5),
                              padding: EdgeInsets.only(
                                  top: Dimension.gap5,
                                  bottom: Dimension.gap5,
                                  left: Dimension.gap5,
                                  right: Dimension.gap5),
                              decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.circular(Dimension.gap15),
                                  color: AppColors.buttonColor1,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Color(0xffa7a1a1),
                                        blurRadius: 0.0,
                                        offset: Offset(0, 2))
                                  ]),
                              child: Row(
                                children: [
                                  Text(
                                    "Start now",
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontFamily: 'Roboto',
                                        color: Colors.white,
                                        fontSize: Dimension.fontMedium,
                                        //fontBig或者size
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    width: Dimension.gap2,
                                  ),
                                  Icon(
                                    CupertinoIcons.arrow_right,
                                    color: Colors.white,
                                    size: Dimension.gap20 * 1.2,
                                  ),
                                ],
                              )),
                        )
                    )
                  ],
                ):
                Column(
                  children: [
                    Container(
                      height: Dimension.screenHeight*0.15,
                      width: Dimension.screenWidth*0.6,
                      margin: EdgeInsets.only(
                          top: Dimension.gap5,
                          bottom: Dimension.gap2,
                          left: Dimension.gap15,
                          right: Dimension.gap30 * 2),
                      padding: EdgeInsets.only(
                          top: Dimension.gap2,
                          bottom: Dimension.gap2,
                          left: Dimension.gap5,
                          right: Dimension.gap5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimension.gap10),
                        color: Colors.white,
                        border: Border.all(
                            width: Dimension.gap2 * 0.8,
                            color: AppColors.borderColor1),
                      ),
                      child: const Image(
                        image: AssetImage("graphics/noshop.png"),
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(
            child: Stack(
              children: [
                Positioned(
                  child: Center(
                    child: Container(
                      margin: EdgeInsets.only(top: Dimension.gap10),
                      height: Dimension.gap10,
                      width: Dimension.screenWidth * 0.3,
                      child: TabBar(
                        unselectedLabelColor: AppColors.bottomColor1,
                        labelColor: AppColors.mainColor2,
                        indicatorSize: TabBarIndicatorSize.label,
                        indicatorWeight: 0.0,
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(999),
                          color: AppColors.mainColor2,
                        ),
                        controller: _tabController,
                        tabs: <Widget>[
                          Tab(
                            child: Container(
                              width: Dimension.gap30,
                              height: Dimension.gap10,
                              decoration: BoxDecoration(
                                color: const Color(0x40E8E8E8),
                                borderRadius: BorderRadius.circular(999),
                              ),
                            ),
                          ),
                          Tab(
                            child: Container(
                              width: Dimension.gap30,
                              height: Dimension.gap10,
                              decoration: BoxDecoration(
                                color: const Color(0x40E8E8E8),
                                borderRadius: BorderRadius.circular(999),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  child: Container(
                    margin: EdgeInsets.only(top: Dimension.screenHeight * 0.09),
                    width: Dimension.screenWidth,
                    height: Dimension.screenHeight * 0.45,
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        Center(
                          child: Column(
                            children: [
                              Container(
                                width: Dimension.screenWidth * 0.8,
                                child: const Image(
                                  image: AssetImage("graphics/goforcate.png"),
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                              SizedBox(
                                height: Dimension.screenHeight * 0.05,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(RouteHelper.getGroupCreate(0));
                                },
                                child: Container(
                                    width: Dimension.screenWidth * 0.6,
                                    child: ButtonIconText(
                                        icon: Icons.restaurant_menu_sharp,
                                        iconColor: Colors.white,
                                        backGroundColor: AppColors.mainColor1,
                                        buttonSize: Dimension.gap30,
                                        iconSize: Dimension.gap30,
                                        text: "GOFORACATE",
                                        textColor: Colors.white,
                                        textSize: Dimension.gap15)),
                              )
                            ],
                          ),
                        ),
                        Center(
                          child: Column(
                            children: [
                              Container(
                                width: Dimension.screenWidth * 0.8,
                                child: const Image(
                                  image: AssetImage("graphics/comment1.png"),
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                              SizedBox(
                                height: Dimension.screenHeight * 0.05,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(RouteHelper.getReleaseComment(0));
                                },
                                child: Container(
                                    width: Dimension.screenWidth * 0.7,
                                    child: ButtonIconText(
                                        icon: Icons.insert_comment,
                                        iconColor: Colors.white,
                                        backGroundColor: AppColors.mainColor1,
                                        buttonSize: Dimension.gap30,
                                        iconSize: Dimension.gap30,
                                        text: "RELEASE COMMENT",
                                        textColor: Colors.white,
                                        textSize: Dimension.gap15)),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
