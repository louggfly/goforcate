import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';

import '../../controllers/user_controller.dart';
import '../../models/user_model.dart';
import '../../routes/route_helper.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/button_icon.dart';
import '../../widgets/comment_item.dart';
import '../../widgets/expandable_text.dart';
import '../../widgets/home_shoplist.dart';

class UserOtherPage extends StatefulWidget {
  final int userId;

  const UserOtherPage({Key? key, required this.userId}) : super(key: key);

  @override
  _UserOtherPageState createState() => _UserOtherPageState();
}

class _UserOtherPageState extends State<UserOtherPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late ScrollController _scrollController1;
  late ScrollController _scrollController2;
  late LinkedScrollControllerGroup _controllerGroup;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 1, vsync: this);
    _scrollController1 = ScrollController();
    _scrollController2 = ScrollController();
    _controllerGroup = LinkedScrollControllerGroup();
    _scrollController1 = _controllerGroup.addAndGet();
    _scrollController2 = _controllerGroup.addAndGet();
  }

  @override
  Widget build(BuildContext context) {
    bool _isAllLoading = false;
    late UserModel user;
    user = Get.find<UserController>().userList[widget.userId - 1];
    Get.find<UserController>().getUserFavourite(widget.userId).then((status) {
      if (status.isSuccess) {
        Get.find<UserController>().getUserComment(widget.userId).then((status) {
          if (status.isSuccess) {
            _isAllLoading = true;
          }
        });
      }
    });

    return Scaffold(body: GetBuilder<UserController>(
      builder: (userController) {
        return Column(
          children: [
            //top part
            Container(
              width: Dimension.screenHeight,
              height: Dimension.screenHeight * 0.25,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimension.gap15),
                  color: AppColors.mainColor3,
                  border: Border.all(color: Color(0xFF58584D), width: 1.5)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //user avatar
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
                      ],
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(top: Dimension.gap10),
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
                                image: NetworkImage(user.avatar!),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: Dimension.gap15,
                          ),
                          Text(
                            user.username!,
                            maxLines: 1,
                            style: TextStyle(
                                fontFamily: 'Roboto',
                                color: AppColors.fontColor1,
                                fontSize: Dimension.gap20, //fontBig或者size
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      )),
                  Container(
                    margin: EdgeInsets.only(
                        left: Dimension.gap30, top: Dimension.gap10),
                    child: ExpandableText(
                      text: user.introduction!,
                      size: 1,
                    ),
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
                          height: Dimension.screenHeight * 0.65,
                          child: TabBarView(
                            controller: _tabController,
                            children: [
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
                                                    RouteHelper.getShopComment(
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
                                              .round(),
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                              onTap: () {
                                                Get.toNamed(
                                                    RouteHelper.getShopComment(
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
