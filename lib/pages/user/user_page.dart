import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:goforcate_app/widgets/big_text.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';

import '../../controllers/auth_controller.dart';
import '../../controllers/user_controller.dart';
import '../../routes/route_helper.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/button_icon.dart';
import '../../widgets/comment_item.dart';
import '../../widgets/home_shoplist.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> with TickerProviderStateMixin {
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
  }

  @override
  Widget build(BuildContext context) {
    bool _userLoggedIN = Get.find<AuthController>().userLoggedIn();
    bool _isAllLoading = false;
    if (_userLoggedIN) {
      Get.find<UserController>().getUserInfo().then((status) {
        if (status.isSuccess) {
          int userId = Get.find<UserController>().userModel.id!;
          Get.find<UserController>().getUserFavourite(userId).then((status) {
            if (status.isSuccess) {
              Get.find<UserController>().getUserComment(userId).then((status) {
                if (status.isSuccess) {
                  _isAllLoading = true;
                }
              });
            }
          });
        }
      });
    }

    void _showConfirmDialogOfFavourite(int shopId) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Delete Shop'),
            content: Text('Are you sure you want to delete this Shop?'),
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
                  Get.find<UserController>().deleteFavourite(shopId);
                  Navigator.of(context).pop();
                  Get.toNamed(RouteHelper.getInital(4));
                },
              ),
            ],
          );
        },
      );
    }

    return Scaffold(body: GetBuilder<UserController>(
      builder: (userController) {
        return Column(
          children: [
            //top part
            Container(
              width: Dimension.screenHeight,
              height: Dimension.screenHeight * 0.27,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimension.gap15),
                  color: AppColors.mainColor3,
                  border: Border.all(color: Color(0xFF58584D), width: 1.5)),
              child: Column(
                children: [
                  //setting and notification
                  Container(
                    margin: EdgeInsets.only(
                        top: Dimension.gap30, right: Dimension.gap20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(RouteHelper.getUserSetting());
                          },
                          child: Container(
                              padding: EdgeInsets.only(right: Dimension.gap10),
                              child: ButtonIcon(
                                  icon: Icons.settings_outlined,
                                  iconColor: Colors.black,
                                  backGroundColor: Colors.white,
                                  iconSize: Dimension.gap20 * 1.2)),
                        ),
                        GestureDetector(
                          onTap: (){
                            Get.toNamed(RouteHelper.getNoticePage());
                          },
                          child: Container(
                            child: ButtonIcon(
                                icon: Icons.notifications,
                                iconColor: Colors.black,
                                backGroundColor: Colors.white,
                                iconSize: Dimension.gap20 * 1.2),
                          ),
                        )
                      ],
                    ),
                  ),
                  //user avatar
                  Container(
                      padding: EdgeInsets.only(
                          top: Dimension.gap2,
                          bottom: Dimension.gap2,
                          left: Dimension.gap20,
                          right: Dimension.gap5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: Dimension.gap30 * 2,
                            width: Dimension.gap30 * 2,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(999),
                              color: Colors.purple,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    userController.userModel.avatar!),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: Dimension.gap15,
                          ),
                          Text(
                            userController.userModel.username!,
                            maxLines: 1,
                            style: TextStyle(
                                fontFamily: 'Roboto',
                                color: AppColors.fontColor1,
                                fontSize: Dimension.gap20, //fontBig或者size
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      )),
                  //usr navigation bar
                  Container(
                    width: Dimension.screenWidth * 0.9,
                    margin: EdgeInsets.only(top: Dimension.gap10),
                    padding: EdgeInsets.only(
                        right: Dimension.gap10,
                        left: Dimension.gap10,
                        top: Dimension.gap5,
                        bottom: Dimension.gap5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimension.gap10),
                        color: Colors.white,
                        border:
                            Border.all(color: Color(0xFF58584D), width: 1.3)),
                    child: BigText(text: userController.userModel.introduction!,size: Dimension.gap15,),
                  )
                ],
              ),
            ),
            //bottom part
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
                                Icons.favorite_border,
                                size: Dimension.gap25,
                              ),
                              Text(
                                "My Favourites",
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
                                "My Comments",
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
                  child: _isAllLoading
                      ? Container(
                          margin: EdgeInsets.only(top: Dimension.gap30 * 2),
                          width: Dimension.screenWidth,
                          height: Dimension.screenHeight * 0.53,
                          child: TabBarView(
                            controller: _tabController,
                            children: [
                              //favouritelist
                              Container(
                                margin: EdgeInsets.only(
                                    left: Dimension.gap10,
                                    right: Dimension.gap10),
                                child: Container(
                                    child: ListView.builder(
                                        physics:
                                            AlwaysScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount:
                                            userController.userFavourite.length,
                                        itemBuilder: (context, index) {
                                          return Dismissible(
                                              key: Key('item'),
                                              confirmDismiss:
                                                  (direction) async {
                                                _showConfirmDialogOfFavourite(
                                                    userController
                                                        .userFavourite[index]
                                                        .id!);
                                                return false; // 返回false表示不删除子组件
                                              },
                                              background: Container(
                                                color: AppColors.mainColor2,
                                                margin: EdgeInsets.only(
                                                    top: Dimension.gap5,
                                                    bottom: Dimension.gap5),
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Icon(Icons.delete),
                                                  ),
                                                ),
                                              ),
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                    top: Dimension.gap5),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          Dimension.gap10),
                                                  color: AppColors.mainColor2,
                                                  border: Border.all(
                                                      width:
                                                          Dimension.gap2 * 0.8,
                                                      color: Colors.white10),
                                                ),
                                                padding: EdgeInsets.only(
                                                    right: Dimension.gap5),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Get.toNamed(
                                                        RouteHelper.getShopPage(
                                                            userController
                                                                .userFavourite[
                                                                    index]
                                                                .id!));
                                                  },
                                                  child: HomeShopList(
                                                      name: userController
                                                          .userFavourite[index]
                                                          .name!,
                                                      num_com: userController
                                                          .userFavourite[index]
                                                          .comments!,
                                                      location: userController
                                                          .userFavourite[index]
                                                          .address!,
                                                      grade: userController
                                                          .userFavourite[index]
                                                          .grade!,
                                                      size: 0.7,
                                                      image: userController
                                                          .userFavourite[index]
                                                          .coverPic!,
                                                      hot_com: "好吃！"),
                                                ),
                                              ));
                                        })),
                              ),
                              //commentlist
                              Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: Dimension.screenWidth * 0.47,
                                      child: ListView.builder(
                                          physics:
                                              AlwaysScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          controller: _scrollController1,
                                          itemCount: (userController
                                                      .userCommentList
                                                      .shopComments
                                                      .length /
                                                  2)
                                              .round(),
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                              onTap: () {
                                                Get.toNamed(
                                                    RouteHelper.getUserComment(
                                                        userController
                                                            .userCommentList
                                                            .shopComments[
                                                                2 * index]
                                                            .commentId!,
                                                        userController
                                                            .userCommentList
                                                            .shopComments[
                                                                2 * index]
                                                            .shopId!));
                                              },
                                              child: CommentItem(
                                                  image: userController
                                                      .userCommentList
                                                      .shopComments[2 * index]
                                                      .pictures[0]
                                                      .pictureLink!,
                                                  userId: userController
                                                      .userCommentList
                                                      .shopComments[2 * index]
                                                      .userId!,
                                                  grade: userController
                                                      .userCommentList
                                                      .shopComments[2 * index]
                                                      .grade!
                                                      .round(),
                                                  text: userController
                                                      .userCommentList
                                                      .shopComments[2 * index]
                                                      .content!),
                                            );
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
                                          controller: _scrollController2,
                                          itemCount: (userController
                                                      .userCommentList
                                                      .shopComments
                                                      .length /
                                                  2)
                                              .floor(),
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                              onTap: () {
                                                Get.toNamed(
                                                    RouteHelper.getUserComment(
                                                        userController
                                                            .userCommentList
                                                            .shopComments[
                                                                2 * index + 1]
                                                            .commentId!,
                                                        userController
                                                            .userCommentList
                                                            .shopComments[
                                                                2 * index + 1]
                                                            .shopId!));
                                              },
                                              child: CommentItem(
                                                  image: userController
                                                      .userCommentList
                                                      .shopComments[
                                                          2 * index + 1]
                                                      .pictures[0]
                                                      .pictureLink!,
                                                  userId: userController
                                                      .userCommentList
                                                      .shopComments[
                                                          2 * index + 1]
                                                      .userId!,
                                                  grade: userController
                                                      .userCommentList
                                                      .shopComments[
                                                          2 * index + 1]
                                                      .grade!
                                                      .round(),
                                                  text: userController
                                                      .userCommentList
                                                      .shopComments[
                                                          2 * index + 1]
                                                      .content!),
                                            );
                                          }),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      : Center(
                          child: Container(
                            margin: EdgeInsets.only(
                                top: Dimension.screenHeight * 0.2),
                            child: CircularProgressIndicator(),
                          ),
                        ),
                ),
              ],
            )
            //choice
          ],
        );
      },
    ));
  }
}
