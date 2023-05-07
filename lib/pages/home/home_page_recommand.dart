import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goforcate_app/controllers/popularshop_controller.dart';
import 'package:goforcate_app/controllers/recommenedshop_controller.dart';
import 'package:goforcate_app/models/shop_model.dart';
import 'package:goforcate_app/utils/colors.dart';
import 'package:goforcate_app/utils/dimensions.dart';
import 'package:goforcate_app/widgets/big_text.dart';
import 'package:goforcate_app/widgets/home_recommand.dart';
import 'package:goforcate_app/widgets/home_shoplist.dart';

import '../../routes/route_helper.dart';

class HomePageRecommand extends StatefulWidget {
  const HomePageRecommand({Key? key}) : super(key: key);

  @override
  _HomePageRecommandState createState() => _HomePageRecommandState();
}

class _HomePageRecommandState extends State<HomePageRecommand> {
  PageController pageController =
      PageController(viewportFraction: 0.9); //控制推荐列表的两侧距离
  var _currentPageValue = 0.0;
  double _scaleFactor = 0.8;
  double _height = Dimension.recommContainer;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currentPageValue = pageController.page!;
      });
    });
  }

  Future<void> _onRefreshRecommended() async {
    print("Refresh recommended List");
    Get.find<RecommendedShopController>().getRecommendedShop();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GetBuilder<PopularShopController>(builder: (popularShops) {
          return popularShops.isLoaded
              ? Container(
                  height: Dimension.recommContainer,
                  child: PageView.builder(
                      controller: pageController,
                      itemCount: popularShops.popularShop.length,
                      itemBuilder: (context, position) {
                        return _buildPageItem(
                            position, popularShops.popularShop[position]);
                      }),
                )
              : CircularProgressIndicator(
                  color: AppColors.mainColor1,
                );
        }),
        //popular
        GetBuilder<PopularShopController>(builder: (popularsShops) {
          return Container(
            child: DotsIndicator(
              dotsCount: popularsShops.popularShop.isEmpty
                  ? 1
                  : popularsShops.popularShop.length,
              position: _currentPageValue,
              decorator: DotsDecorator(
                size: const Size.square(9.0),
                activeSize: const Size(18.0, 9.0),
                activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
              ),
            ),
          );
        }),

        //ranking list
        Container(
          margin: EdgeInsets.only(left: Dimension.gap10),
          child: Row(
            children: [
              BigText(
                text: "Recommended",
                size: Dimension.fontMedium * 1.3,
              ),
            ],
          ),
        ),
        //List
        RefreshIndicator(
            onRefresh: _onRefreshRecommended,
            child: GetBuilder<RecommendedShopController>(
                builder: (recommendedShops) {
              return recommendedShops.isLoaded
                  ? Container(
                      height: Dimension.screenHeight * 0.3,
                      child: ListView.builder(
                          physics: AlwaysScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: recommendedShops.recommendedShop.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.all(Dimension.gap5),
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Dimension.gap10),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Color(0xffa7a1a1),
                                      blurRadius: 1.0,
                                      offset: Offset(1, 1))
                                ],
                                border: Border.all(
                                    width: Dimension.gap2 * 0.8,
                                    color: AppColors.borderColor1),
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  Get.toNamed(RouteHelper.getShopPage(
                                      recommendedShops
                                          .recommendedShop[index].id!));
                                },
                                child: HomeShopList(
                                    name: recommendedShops
                                        .recommendedShop[index].name!,
                                    num_com: recommendedShops
                                        .recommendedShop[index].comments!,
                                    location: recommendedShops
                                        .recommendedShop[index].address!,
                                    grade: recommendedShops
                                        .recommendedShop[index].grade!,
                                    size: 0.7,
                                    image: recommendedShops
                                        .recommendedShop[index].coverPic!,
                                    hot_com: "好吃！"),
                              ),
                            );
                          }))
                  : CircularProgressIndicator(
                      color: AppColors.mainColor1,
                    );
            }))
      ],
    );
  }

  Widget _buildPageItem(int index, ShopModel popularShop) {
    Matrix4 matrix4 = new Matrix4.identity();
    if (index == _currentPageValue.floor()) {
      var currScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == 1 + _currentPageValue.floor()) {
      var currScale =
          _scaleFactor + (_currentPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1);
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currentPageValue.floor() - 1) {
      var currScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1);
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 1);
    }

    return Transform(
        transform: matrix4,
        //recommand container
        child: Stack(
          children: [
            GestureDetector(
              onTap: () {
                Get.toNamed(RouteHelper.getShopPage(popularShop.id!));
              },
              child: HomeRecommand(
                  name: popularShop.name!,
                  num_com: popularShop.comments!,
                  location: popularShop.address!,
                  grade: popularShop.grade!,
                  size: 0.8,
                  image: popularShop.coverPic!,
                  hot_com: ""),
            )
          ],
        ));
  }
}
