import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';

import '../../controllers/commentlist_controller.dart';
import '../../controllers/shop_controller.dart';
import '../../controllers/shoplist_controller.dart';
import '../../routes/route_helper.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/big_text.dart';
import '../../widgets/button_icon.dart';
import '../../widgets/comment_item.dart';
import '../../widgets/home_shoplist.dart';

class SearchInputPage extends StatefulWidget {
  final int index; //0-return search page,else return shop page
  const SearchInputPage({Key? key, required this.index}) : super(key: key);

  @override
  _SearchInputPageState createState() => _SearchInputPageState();
}

class _SearchInputPageState extends State<SearchInputPage>
    with TickerProviderStateMixin {
  late TextEditingController _searchController;
  bool _isAllLoading = true;
  late TabController _tabController;
  late ScrollController _scrollController1;
  late ScrollController _scrollController2;
  late LinkedScrollControllerGroup _controllerGroup;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _scrollController1 = ScrollController();
    _scrollController2 = ScrollController();
    _controllerGroup = LinkedScrollControllerGroup();
    _scrollController1 = _controllerGroup.addAndGet();
    _scrollController2 = _controllerGroup.addAndGet();
    _searchController = TextEditingController();
    _searchController.addListener(() {
      print("update search list");
      Get.find<ShopListController>()
          .getSearchShop(_searchController.text)
          .then((status) {
        if (status.isSuccess) {
          Get.find<CommentListController>()
              .getSearchComment(_searchController.text)
              .then((status) {});
        }
      });
      _onRefresh;
    });
  }

  Future<void> _onRefresh() async {
    print("refresh search list");
    Get.find<ShopListController>()
        .getSearchShop(_searchController.text)
        .then((status) {
      if (status.isSuccess) {
        Get.find<CommentListController>()
            .getSearchComment(_searchController.text)
            .then((status) {
          _isAllLoading = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            if (widget.index == 0) {
              Get.toNamed(RouteHelper.getInital(0));
            } else if (widget.index == 1) {
              Get.toNamed(RouteHelper.getInital(1));
            } else {
              Get.toNamed(RouteHelper.getInital(2));
            }
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
        backgroundColor: AppColors.mainColor2,
        title: BigText(
          text: "Search",
          size: Dimension.gap20 * 1.1,
          color: Colors.white,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: GetBuilder<ShopController>(builder: (shopController) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: Dimension.screenHeight * 0.05,
                margin: EdgeInsets.only(
                    top: Dimension.gap10,
                    bottom: Dimension.gap5,
                    left: Dimension.gap20,
                    right: Dimension.gap20),
                decoration: BoxDecoration(
                  color: AppColors.bottomColor1,
                  borderRadius: BorderRadius.circular(Dimension.gap20),
                ),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: "Search for restaurant",
                    hintStyle: TextStyle(
                        fontFamily: 'Roboto',
                        color: AppColors.fontColor2,
                        fontSize: Dimension.gap15 * 0.9, //fontBig或者size
                        fontWeight: FontWeight.w600),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Dimension.gap20),
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: AppColors.fontColor2,
                      size: Dimension.gap20 * 1.2,
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Dimension.gap20),
                        borderSide: BorderSide(
                            width: Dimension.gap2, color: Colors.white70)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Dimension.gap20),
                        borderSide: BorderSide(
                            width: 1.5, color: AppColors.bottomColor1)),
                  ),
                ),
              ),
              Stack(
                children: [
                  Positioned(
                    child: Container(
                      width: Dimension.screenWidth,
                      margin: EdgeInsets.only(
                          left: Dimension.gap20, right: Dimension.gap20),
                      child: TabBar(
                        unselectedLabelColor: AppColors.fontColor2,
                        labelColor: AppColors.fontColor1,
                        indicatorColor: AppColors.fontColor1,
                        controller: _tabController,
                        tabs: <Widget>[
                          Tab(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.emoji_food_beverage,
                                  size: Dimension.gap25,
                                ),
                                Text(
                                  "Restaurants",
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: Dimension.gap10 * 1.2,
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
                                  Icons.list_alt_rounded,
                                  size: Dimension.gap25,
                                ),
                                Text(
                                  "Comments",
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: Dimension.gap10 * 1.2,
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
                  Positioned(
                    child: RefreshIndicator(
                      onRefresh: _onRefresh,
                      child: _isAllLoading
                          ? Container(
                              margin: EdgeInsets.only(top: Dimension.gap30 * 2),
                              width: Dimension.screenWidth,
                              height: Dimension.screenHeight * 0.7,
                              child: TabBarView(
                                controller: _tabController,
                                children: <Widget>[
                                  Container(
                                      margin: EdgeInsets.only(
                                          left: Dimension.gap10,
                                          right: Dimension.gap10),
                                      child: GetBuilder<ShopListController>(
                                        builder: (shopListController) {
                                          return ListView.builder(
                                              physics:
                                                  AlwaysScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              itemCount: shopListController
                                                  .searchShopList.length,
                                              itemBuilder: (context, index) {
                                                return GestureDetector(
                                                  onTap: () {
                                                    Get.toNamed(
                                                        RouteHelper.getShopPage(
                                                            shopListController
                                                                .searchShopList[
                                                                    index]
                                                                .id!));
                                                  },
                                                  child: HomeShopList(
                                                      name: shopListController
                                                          .searchShopList[index]
                                                          .name!,
                                                      num_com:
                                                          shopListController
                                                              .searchShopList[
                                                                  index]
                                                              .comments!,
                                                      location:
                                                          shopListController
                                                              .searchShopList[
                                                                  index]
                                                              .address!,
                                                      grade: shopListController
                                                          .searchShopList[index]
                                                          .grade!,
                                                      size: 0.7,
                                                      image: shopListController
                                                          .searchShopList[index]
                                                          .coverPic!,
                                                      hot_com: "好吃！"),
                                                );
                                              });
                                        },
                                      )),
                                  Center(
                                    child: GetBuilder<CommentListController>(
                                      builder: (commentListController) {
                                        return Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              width:
                                                  Dimension.screenWidth * 0.47,
                                              child: ListView.builder(
                                                  physics:
                                                      AlwaysScrollableScrollPhysics(),
                                                  shrinkWrap: true,
                                                  controller:
                                                      _scrollController1,
                                                  itemCount: (commentListController
                                                              .searchCommentList
                                                              .length /
                                                          2)
                                                      .round(),
                                                  itemBuilder:
                                                      (context, index) {
                                                    return GestureDetector(
                                                      onTap: () {
                                                        Get.toNamed(RouteHelper.getShopComment(
                                                            commentListController
                                                                .searchCommentList[
                                                                    2 * index]
                                                                .commentId!,
                                                            commentListController
                                                                .searchCommentList[
                                                                    2 * index]
                                                                .shopId!));
                                                      },
                                                      child: CommentItem(
                                                          image: commentListController
                                                              .searchCommentList[
                                                                  2 * index]
                                                              .pictures[0]
                                                              .pictureLink!,
                                                          userId: commentListController
                                                              .searchCommentList[
                                                                  2 * index]
                                                              .userId!,
                                                          grade: commentListController
                                                              .searchCommentList[
                                                                  2 * index]
                                                              .grade!
                                                              .round(),
                                                          text: commentListController
                                                              .searchCommentList[
                                                                  2 * index]
                                                              .content!),
                                                    );
                                                  }),
                                            ),
                                            SizedBox(
                                              width:
                                                  Dimension.screenWidth * 0.02,
                                            ),
                                            Container(
                                              width:
                                                  Dimension.screenWidth * 0.47,
                                              child: ListView.builder(
                                                  physics:
                                                      AlwaysScrollableScrollPhysics(),
                                                  shrinkWrap: true,
                                                  controller:
                                                      _scrollController2,
                                                  itemCount: (commentListController
                                                              .searchCommentList
                                                              .length /
                                                          2)
                                                      .floor(),
                                                  itemBuilder:
                                                      (context, index) {
                                                    return GestureDetector(
                                                      onTap: () {
                                                        Get.toNamed(RouteHelper.getShopComment(
                                                            commentListController
                                                                .searchCommentList[
                                                                    2 * index +
                                                                        1]
                                                                .commentId!,
                                                            commentListController
                                                                .searchCommentList[
                                                                    2 * index +
                                                                        1]
                                                                .shopId!));
                                                      },
                                                      child: CommentItem(
                                                          image: commentListController
                                                              .searchCommentList[
                                                                  2 * index + 1]
                                                              .pictures[0]
                                                              .pictureLink!,
                                                          userId: commentListController
                                                              .searchCommentList[
                                                                  2 * index + 1]
                                                              .userId!,
                                                          grade: commentListController
                                                              .searchCommentList[
                                                                  2 * index + 1]
                                                              .grade!
                                                              .round(),
                                                          text: commentListController
                                                              .searchCommentList[
                                                                  2 * index + 1]
                                                              .content!),
                                                    );
                                                  }),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Center(
                              child: Container(
                                  margin: EdgeInsets.only(
                                      top: Dimension.screenHeight * 0.2)),
                            ),
                    ),
                  )
                ],
              ),
            ],
          );
        }),
      ),
    );
  }
}
