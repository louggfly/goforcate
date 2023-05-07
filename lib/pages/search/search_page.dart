import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goforcate_app/controllers/shoplist_controller.dart';
import 'package:goforcate_app/utils/dimensions.dart';
import 'package:goforcate_app/widgets/button_icon.dart';
import 'package:goforcate_app/widgets/comment_item.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';

import '../../controllers/area_controller.dart';
import '../../controllers/commentlist_controller.dart';
import '../../routes/route_helper.dart';
import '../../utils/colors.dart';
import '../../widgets/home_shoplist.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with TickerProviderStateMixin {
  late TabController _tabController;
  late ScrollController _scrollController;
  late ScrollController _scrollController1;
  late ScrollController _scrollController2;
  late LinkedScrollControllerGroup _controllerGroup;
  bool isLoading = false;
  late int shopNumber;
  late int commentNumber;

  @override
  void initState() {
    super.initState();
    shopNumber = 10;
    commentNumber = 10;
    _tabController = TabController(length: 2, vsync: this);
    _scrollController = ScrollController();
    _scrollController1 = ScrollController();
    _scrollController2 = ScrollController();
    _controllerGroup = LinkedScrollControllerGroup();
    _scrollController1 = _controllerGroup.addAndGet();
    _scrollController2 = _controllerGroup.addAndGet();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >
          _scrollController.position.maxScrollExtent - 20) {
        print('Arrive the end');
        shopNumber += 10;
        print(shopNumber.toString());
        Get.find<ShopListController>().getShopList();
        if (shopNumber > Get.find<ShopListController>().getShopListLength()) {
          shopNumber = Get.find<ShopListController>().getShopListLength();
        }
      }
    });
    _scrollController1.addListener(() {
      if (_scrollController1.position.pixels >
          _scrollController1.position.maxScrollExtent - 20) {
        print('Arrive the end');
        commentNumber += 5;
        print(commentNumber.toString());
        Get.find<CommentListController>().getCommentList();
        if (commentNumber >
            Get.find<CommentListController>().getCommentListLength()) {
          commentNumber =
              Get.find<CommentListController>().getCommentListLength();
        }
      }
    });
    _scrollController2.addListener(() {
      if (_scrollController2.position.pixels >
          _scrollController2.position.maxScrollExtent - 20) {
        print('Arrive the end');
        commentNumber += 5;
        print(commentNumber.toString());
        Get.find<CommentListController>().getCommentList();
        if (commentNumber >
            Get.find<CommentListController>().getCommentListLength()) {
          commentNumber =
              Get.find<CommentListController>().getCommentListLength();
        }
      }
    });
  }

  Future<void> _onRefreshRestaurant() async {
    print("Refresh shop List");
    Get.find<ShopListController>().getShopList();
  }

  Widget _getMoreWidget() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Loading more',
              style: TextStyle(fontSize: Dimension.gap15),
            ),
            SizedBox(
              width: Dimension.gap10,
            ),
            CircularProgressIndicator()
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool _isAllLoading = true;

    return Scaffold(body: GetBuilder<CommentListController>(
      builder: (commentListController) {
        return Column(
          children: [
            //navigation
            Container(
              height: Dimension.screenHeight * 0.10,
              padding: EdgeInsets.only(
                  top: Dimension.gap20 * 2,
                  left: Dimension.gap10,
                  right: Dimension.gap10),
              decoration: BoxDecoration(
                color: AppColors.mainColor2,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      //address
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(RouteHelper.getChooseArea(1));
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                              top: Dimension.gap5 * 0.6,
                              bottom: Dimension.gap5 * 0.6),
                          width: Dimension.screenWidth * 0.25,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(Dimension.gap20),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                Get.find<AreaController>().getUserArea(),
                                maxLines: 1,
                                style: TextStyle(
                                    fontFamily: 'Roboto',
                                    color: AppColors.fontColor1,
                                    fontSize: Dimension.gap15,
                                    //fontBig或者size
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                width: Dimension.gap5,
                              ),
                              Icon(
                                Icons.keyboard_arrow_down_outlined,
                                color: AppColors.fontColor1,
                                size: Dimension.gap20 * 1.2,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: Dimension.screenWidth * 0.05,
                      ),
                      //search
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(RouteHelper.getInputSearch(1));
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                              top: Dimension.gap5 * 0.6,
                              bottom: Dimension.gap5 * 0.6),
                          width: Dimension.screenWidth * 0.5,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(Dimension.gap20),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.search,
                                color: AppColors.fontColor2,
                                size: Dimension.gap20 * 1.2,
                              ),
                              Text(
                                "Search",
                                maxLines: 1,
                                style: TextStyle(
                                    fontFamily: 'Roboto',
                                    color: AppColors.fontColor2,
                                    fontSize: Dimension.gap15,
                                    //fontBig或者size
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: Dimension.screenWidth * 0.05,
                      ),
                      //notification
                      GestureDetector(
                        onTap: (){
                          Get.toNamed(RouteHelper.getNoticePage());
                        },
                        child: ButtonIcon(
                            icon: Icons.notifications,
                            iconColor: AppColors.mainColor2,
                            backGroundColor: Colors.white,
                            iconSize: Dimension.gap25),
                      )

                    ],
                  ),
                ],
              ),
            ),
            Stack(
              children: [
                Positioned(
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppColors.mainColor2,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(Dimension.gap10),
                            bottomRight: Radius.circular(Dimension.gap10))),
                    width: Dimension.screenWidth,
                    padding: EdgeInsets.only(
                        left: Dimension.gap20,
                        right: Dimension.gap20,
                        top: Dimension.gap10,
                        bottom: Dimension.gap10),
                    child: TabBar(
                      unselectedLabelColor: Colors.white,
                      labelColor: AppColors.fontColor1,
                      indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimension.gap10),
                          color: AppColors.mainColor1,
                          border: Border.all(color: AppColors.mainColor1)),
                      controller: _tabController,
                      tabs: <Widget>[
                        Tab(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.restaurant,
                                size: Dimension.gap30,
                              ),
                              Text(
                                "Restaurants",
                                maxLines: 1,
                                style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: Dimension.gap15,
                                    //fontBig或者size
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                        Tab(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.comment_outlined,
                                size: Dimension.gap30,
                              ),
                              Text(
                                "Comments",
                                maxLines: 1,
                                style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: Dimension.gap15,
                                    //fontBig或者size
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                _isAllLoading
                    ? Positioned(
                        child: Container(
                          margin: EdgeInsets.only(
                              top: Dimension.screenHeight * 0.09,
                              left: Dimension.gap5,
                              right: Dimension.gap5),
                          width: Dimension.screenWidth,
                          height: Dimension.screenHeight * 0.68,
                          child: TabBarView(
                            controller: _tabController,
                            children: <Widget>[
                              Center(
                                child: Container(
                                  child: RefreshIndicator(
                                    onRefresh: _onRefreshRestaurant,
                                    child: GetBuilder<ShopListController>(
                                        builder: (shopListController) {
                                      return Container(
                                          child: ListView.builder(
                                              physics:
                                                  AlwaysScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              controller: _scrollController,
                                              itemCount: shopNumber,
                                              itemBuilder: (context, index) {
                                                if (index == shopNumber - 1) {
                                                  return Column(
                                                    children: [
                                                      Container(
                                                          margin:
                                                              EdgeInsets.all(
                                                                  Dimension
                                                                      .gap5),
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        Dimension
                                                                            .gap10),
                                                            color: Colors.white,
                                                            boxShadow: [
                                                              BoxShadow(
                                                                  color: Color(
                                                                      0xffa7a1a1),
                                                                  blurRadius:
                                                                      1.0,
                                                                  offset:
                                                                      Offset(
                                                                          1, 1))
                                                            ],
                                                            border: Border.all(
                                                                width: Dimension
                                                                        .gap2 *
                                                                    0.8,
                                                                color: AppColors
                                                                    .borderColor1),
                                                          ),
                                                          child:
                                                              GestureDetector(
                                                            onTap: () {
                                                              Get.toNamed(RouteHelper.getShopPage(
                                                                  shopListController
                                                                      .shopList[
                                                                          index]
                                                                      .id!));
                                                            },
                                                            child: HomeShopList(
                                                                name: shopListController
                                                                    .shopList[
                                                                        index]
                                                                    .name!,
                                                                num_com: shopListController
                                                                    .shopList[
                                                                        index]
                                                                    .comments!,
                                                                location: shopListController
                                                                    .shopList[
                                                                        index]
                                                                    .address!,
                                                                grade: shopListController
                                                                    .shopList[
                                                                        index]
                                                                    .grade!,
                                                                size: 0.7,
                                                                image: shopListController
                                                                    .shopList[
                                                                        index]
                                                                    .coverPic!,
                                                                hot_com: "好吃！"),
                                                          )),
                                                      Divider(),
                                                      _getMoreWidget(),
                                                    ],
                                                  );
                                                } else {
                                                  return Container(
                                                      margin: EdgeInsets.all(
                                                          Dimension.gap5),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    Dimension
                                                                        .gap10),
                                                        color: Colors.white,
                                                        boxShadow: [
                                                          BoxShadow(
                                                              color: Color(
                                                                  0xffa7a1a1),
                                                              blurRadius: 1.0,
                                                              offset:
                                                                  Offset(1, 1))
                                                        ],
                                                        border: Border.all(
                                                            width:
                                                                Dimension.gap2 *
                                                                    0.8,
                                                            color: AppColors
                                                                .borderColor1),
                                                      ),
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          Get.toNamed(RouteHelper
                                                              .getShopPage(
                                                                  shopListController
                                                                      .shopList[
                                                                          index]
                                                                      .id!));
                                                        },
                                                        child: HomeShopList(
                                                            name:
                                                                shopListController
                                                                    .shopList[
                                                                        index]
                                                                    .name!,
                                                            num_com:
                                                                shopListController
                                                                    .shopList[
                                                                        index]
                                                                    .comments!,
                                                            location:
                                                                shopListController
                                                                    .shopList[
                                                                        index]
                                                                    .address!,
                                                            grade:
                                                                shopListController
                                                                    .shopList[
                                                                        index]
                                                                    .grade!,
                                                            size: 0.7,
                                                            image:
                                                                shopListController
                                                                    .shopList[
                                                                        index]
                                                                    .coverPic!,
                                                            hot_com: "好吃！"),
                                                      ));
                                                }
                                              }));
                                    }),
                                  ),
                                ),
                              ),
                              Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: Dimension.screenWidth * 0.455,
                                      child: ListView.builder(
                                          physics:
                                              AlwaysScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount:
                                              (commentNumber / 2).round(),
                                          controller: _scrollController1,
                                          itemBuilder: (context, index) {
                                            if (index == commentNumber - 1) {
                                              return Column(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      Get.toNamed(RouteHelper
                                                          .getShopComment(
                                                              commentListController
                                                                  .commentList[
                                                                      2 * index]
                                                                  .commentId,
                                                              commentListController
                                                                  .commentList[
                                                                      2 * index]
                                                                  .shopId));
                                                    },
                                                    child: CommentItem(
                                                        image:
                                                            commentListController
                                                                .commentList[2 *
                                                                    index]
                                                                .pictures[0]
                                                                .pictureLink!,
                                                        userId:
                                                            commentListController
                                                                .commentList[
                                                                    2 * index]
                                                                .userId!,
                                                        grade:
                                                            commentListController
                                                                .commentList[
                                                                    2 * index]
                                                                .grade!
                                                                .round(),
                                                        text:
                                                            commentListController
                                                                .commentList[
                                                                    2 * index]
                                                                .content!),
                                                  ),
                                                  Divider(),
                                                  _getMoreWidget(),
                                                ],
                                              );
                                            } else {
                                              return GestureDetector(
                                                onTap: () {
                                                  Get.toNamed(RouteHelper
                                                      .getShopComment(
                                                          commentListController
                                                              .commentList[
                                                                  2 * index]
                                                              .commentId,
                                                          commentListController
                                                              .commentList[
                                                                  2 * index]
                                                              .shopId));
                                                },
                                                child: CommentItem(
                                                    image: commentListController
                                                        .commentList[2 * index]
                                                        .pictures[0]
                                                        .pictureLink!,
                                                    userId:
                                                        commentListController
                                                            .commentList[
                                                                2 * index]
                                                            .userId!,
                                                    grade: commentListController
                                                        .commentList[2 * index]
                                                        .grade!
                                                        .round(),
                                                    text: commentListController
                                                        .commentList[2 * index]
                                                        .content!),
                                              );
                                            }
                                          }),
                                    ),
                                    SizedBox(
                                      width: Dimension.screenWidth * 0.02,
                                    ),
                                    Container(
                                      width: Dimension.screenWidth * 0.47,
                                      child: ListView.builder(
                                          physics:
                                              AlwaysScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount:
                                              (commentNumber / 2).round(),
                                          controller: _scrollController2,
                                          itemBuilder: (context, index) {
                                            if (index == commentNumber - 1) {
                                              return Column(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      Get.toNamed(RouteHelper
                                                          .getShopComment(
                                                              commentListController
                                                                  .commentList[
                                                                      2 * index +
                                                                          1]
                                                                  .commentId,
                                                              commentListController
                                                                  .commentList[
                                                                      2 * index +
                                                                          1]
                                                                  .shopId));
                                                    },
                                                    child: CommentItem(
                                                        image:
                                                            commentListController
                                                                .commentList[2 *
                                                                        index +
                                                                    1]
                                                                .pictures[0]
                                                                .pictureLink!,
                                                        userId:
                                                            commentListController
                                                                .commentList[
                                                                    2 * index +
                                                                        1]
                                                                .userId!,
                                                        grade:
                                                            commentListController
                                                                .commentList[
                                                                    2 * index +
                                                                        1]
                                                                .grade!
                                                                .round(),
                                                        text:
                                                            commentListController
                                                                .commentList[2 *
                                                                        index +
                                                                    1]
                                                                .content!),
                                                  ),
                                                  Divider(),
                                                  _getMoreWidget(),
                                                ],
                                              );
                                            } else {
                                              return GestureDetector(
                                                onTap: () {
                                                  Get.toNamed(RouteHelper
                                                      .getShopComment(
                                                          commentListController
                                                              .commentList[
                                                                  2 * index + 1]
                                                              .commentId,
                                                          commentListController
                                                              .commentList[
                                                                  2 * index + 1]
                                                              .shopId));
                                                },
                                                child: CommentItem(
                                                    image: commentListController
                                                        .commentList[
                                                            2 * index + 1]
                                                        .pictures[0]
                                                        .pictureLink!,
                                                    userId:
                                                        commentListController
                                                            .commentList[
                                                                2 * index + 1]
                                                            .userId!,
                                                    grade: commentListController
                                                        .commentList[
                                                            2 * index + 1]
                                                        .grade!
                                                        .round(),
                                                    text: commentListController
                                                        .commentList[
                                                            2 * index + 1]
                                                        .content!),
                                              );
                                            }
                                          }),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Center(
                        child: Container(
                          margin: EdgeInsets.only(
                              top: Dimension.screenHeight * 0.2),
                          child: CircularProgressIndicator(),
                        ),
                      )
              ],
            )
          ],
        );
      },
    ));
  }
}
