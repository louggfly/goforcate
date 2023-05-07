import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controllers/commentlist_controller.dart';
import '../../controllers/shop_controller.dart';
import '../../controllers/shoplist_controller.dart';
import '../../routes/route_helper.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/big_text.dart';
import '../../widgets/button_icon.dart';
import '../../widgets/icon_text.dart';
import '../../widgets/small_text.dart';

class GroupDestPage extends StatefulWidget {
  final int shopId;
  final int groupId;

  const GroupDestPage({Key? key, required this.shopId, required this.groupId})
      : super(key: key);

  @override
  _GroupDestPageState createState() => _GroupDestPageState();
}

class _GroupDestPageState extends State<GroupDestPage>
    with TickerProviderStateMixin {
  late TextEditingController _searchController;
  bool _isAllLoading = true;

  @override
  void initState() {
    super.initState();
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Get.toNamed(
                RouteHelper.getGroupEdit(widget.groupId, widget.shopId));
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
              Container(
                  height: Dimension.screenHeight*0.8,
                  margin: EdgeInsets.only(
                      left: Dimension.gap10, right: Dimension.gap10),
                  child: GetBuilder<ShopListController>(
                    builder: (shopListController) {
                      return ListView.builder(
                          physics: AlwaysScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: shopListController.searchShopList.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Get.toNamed(RouteHelper.getGroupEdit(
                                    widget.groupId,
                                    shopListController
                                        .searchShopList[index].id!));
                              },
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
                                child: Row(
                                  children: [
                                    //List image
                                    Container(
                                      height: Dimension.ListPicContainer,
                                      width: Dimension.ListPicContainer,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              Dimension.gap10),
                                          color: Colors.purple,
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  shopListController
                                                      .searchShopList[index]
                                                      .coverPic)),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Color(0xffa7a1a1),
                                                blurRadius: 0.0,
                                                offset: Offset(0, 2))
                                          ]),
                                    ),
                                    //List Text
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Container(
                                        height: Dimension.ListPicContainer,
                                        margin: EdgeInsets.only(
                                            left: Dimension.gap5,
                                            bottom: Dimension.gap5),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                        ),
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              left: Dimension.gap5,
                                              right: Dimension.gap5,
                                              top: Dimension.gap5),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: Dimension.gap30 * 6,
                                                child: BigText(
                                                  text: shopListController
                                                      .searchShopList[index]
                                                      .name,
                                                  size: Dimension.fontBig * 0.7,
                                                ),
                                              ),
                                              SizedBox(
                                                height: Dimension.gap5,
                                              ),
                                              Row(
                                                children: [
                                                  Wrap(
                                                    //评分星级
                                                    children: List.generate(
                                                        5,
                                                            (index) => Icon(
                                                            Icons.star,
                                                            color: AppColors
                                                                .mainColor1,
                                                            size: Dimension
                                                                .gap20)),
                                                  ),
                                                  SizedBox(
                                                    width: Dimension.gap2,
                                                  ),
                                                  SmallText(
                                                      text: shopListController
                                                          .searchShopList[index]
                                                          .grade
                                                          .toString(),
                                                      color:
                                                      AppColors.fontColor2,
                                                      size: Dimension.gap15 *
                                                          0.8),
                                                  SizedBox(
                                                    width: Dimension.gap10,
                                                  ),
                                                  SmallText(
                                                      text: shopListController
                                                          .searchShopList[index]
                                                          .comments
                                                          .toString()),
                                                  SizedBox(
                                                    width: Dimension.gap2,
                                                  ),
                                                  SmallText(text: "条评论"),
                                                ],
                                              ),
                                              SizedBox(
                                                height: Dimension.gap5,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  IconText(
                                                      icon: Icons
                                                          .location_on_outlined,
                                                      text: shopListController
                                                          .searchShopList[index]
                                                          .address,
                                                      iconColor:
                                                      AppColors.fontColor2,
                                                      textColor:
                                                      AppColors.fontColor2),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  IconText(
                                                      icon: Icons
                                                          .local_fire_department_rounded,
                                                      text: "Hot Comment",
                                                      iconColor: Colors.red,
                                                      textColor:
                                                      Colors.redAccent),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    width: Dimension.gap30,
                                                  ),
                                                  Container(
                                                      width:
                                                      Dimension.gap30 * 5,
                                                      child: Text(
                                                        "hot_com",
                                                        maxLines: 1,
                                                        style: TextStyle(
                                                            overflow:
                                                            TextOverflow
                                                                .ellipsis,
                                                            color: AppColors
                                                                .fontColor1,
                                                            fontSize: Dimension
                                                                .fontSmall *
                                                                0.7,
                                                            fontWeight:
                                                            FontWeight
                                                                .w400),
                                                      )),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
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
