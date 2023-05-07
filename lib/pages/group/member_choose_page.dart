import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controllers/shop_controller.dart';
import '../../controllers/user_controller.dart';
import '../../routes/route_helper.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/big_text.dart';
import '../../widgets/button_icon.dart';

class MemberChoosePage extends StatefulWidget {
  const MemberChoosePage({Key? key}) : super(key: key);

  @override
  _MemberChoosePageState createState() => _MemberChoosePageState();
}

class _MemberChoosePageState extends State<MemberChoosePage>
    with TickerProviderStateMixin {
  late TextEditingController _searchController;
  bool _isAllLoading = true;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _searchController.addListener(() {
      print("update user list");
      Get.find<UserController>()
          .getSearchUser(_searchController.text)
          .then((status) {
        if (status.isSuccess) {}
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          GestureDetector(
            onTap: () {
              Get.toNamed(RouteHelper.getGroupCreate(0));
            },
            child: Container(
              margin: EdgeInsets.all(Dimension.gap5),
              child: ButtonIcon(
                  icon: CupertinoIcons.checkmark_alt_circle_fill,
                  iconColor: Colors.white,
                  backGroundColor: AppColors.mainColor2,
                  iconSize: Dimension.gap30 * 1.5),
            ),
          )
        ],
        leading: GestureDetector(
          onTap: () {
            Get.toNamed(RouteHelper.getGroupCreate(0));
          },
          child: Container(
            margin: EdgeInsets.all(Dimension.gap5),
            child: ButtonIcon(
                icon: CupertinoIcons.clear_circled_solid,
                iconColor: Colors.white,
                backGroundColor: AppColors.mainColor2,
                iconSize: Dimension.gap30 * 1.5),
          ),
        ),
        backgroundColor: AppColors.mainColor2,
        title: BigText(
          text: "Add Member",
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
                    hintText: "Search for user",
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
              Container(
                  margin: EdgeInsets.only(
                      left: Dimension.gap10, right: Dimension.gap10),
                  child: GetBuilder<UserController>(
                    builder: (userController) {
                      return ListView.builder(
                          physics: AlwaysScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: userController.searchUserList.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {},
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(Dimension.gap10),
                                    color: Colors.white,
                                    border: Border.all(
                                        width: Dimension.gap2 * 0.8,
                                        color: AppColors.borderColor1),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Color(0xffa7a1a1),
                                          blurRadius: 1.0,
                                          offset: Offset(1, 1))
                                    ]),
                                margin: EdgeInsets.only(
                                    top: Dimension.gap5,
                                    bottom: Dimension.gap5),
                                padding: EdgeInsets.only(
                                    left: Dimension.gap2,
                                    right: Dimension.gap2,
                                    top: Dimension.gap5,
                                    bottom: Dimension.gap5),
                                child: Container(
                                    padding: EdgeInsets.only(
                                        top: Dimension.gap2,
                                        bottom: Dimension.gap2,
                                        left: Dimension.gap5,
                                        right: Dimension.gap5),
                                    child: Row(
                                      children: [
                                        Container(
                                          height: Dimension.gap30,
                                          width: Dimension.gap30,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(999),
                                            color: Colors.purple,
                                            border: Border.all(
                                                width: Dimension.gap2 * 0.8,
                                                color: AppColors.borderColor1),
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(userController
                                                  .searchUserList[index]
                                                  .avatar),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: Dimension.gap5,
                                        ),
                                        Container(
                                          child: Text(
                                            userController.searchUserList[index]
                                                .username!,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontFamily: 'Roboto',
                                                color: AppColors.fontColor1,
                                                fontSize: Dimension.gap15,
                                                //fontBig或者size
                                                fontWeight: FontWeight.w600),
                                          ),
                                        )
                                      ],
                                    )),
                              ),
                            );
                          });
                    },
                  )),
            ],
          );
        }),
      ),
    );
  }
}
