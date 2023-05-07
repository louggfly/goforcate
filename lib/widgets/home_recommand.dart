import 'package:flutter/material.dart';
import 'package:goforcate_app/widgets/small_text.dart';

import '../utils/colors.dart';
import '../utils/dimensions.dart';
import 'big_text.dart';
import 'icon_text.dart';

class HomeRecommand extends StatelessWidget {
  final String name;
  final int num_com;
  final String location;
  final String image;
  final String hot_com;
  final double grade;
  final double size;

  const HomeRecommand({
    Key? key,
    required this.name,
    required this.num_com,
    required this.location,
    required this.grade,
    required this.size,
    required this.image,
    required this.hot_com,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        //添加stack将会使子容器都位于父容器左上角
        children: [
          //展示图片
          Container(
            height: Dimension.recommPicContainer,
            margin:
                EdgeInsets.only(left: Dimension.gap10, right: Dimension.gap10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimension.gap20),
                image: DecorationImage(
                    fit: BoxFit.cover, image: NetworkImage(image)),
                boxShadow: [
                  BoxShadow(
                      color: Color(0xFFe8e8e8),
                      blurRadius: 5.0,
                      offset: Offset(0, 5))
                ]),
          ),
          //餐馆信息
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimension.recommTextContainer,
              margin: EdgeInsets.only(
                  left: Dimension.gap30,
                  right: Dimension.gap30,
                  bottom: Dimension.gap30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimension.gap15),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Color(0xFFe8e8e8),
                        blurRadius: 5.0,
                        offset: Offset(0, 5))
                  ]),
              child: Container(
                margin: EdgeInsets.only(
                    left: Dimension.gap10,
                    right: Dimension.gap10,
                    top: Dimension.gap10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: Dimension.gap30 * 8,
                      child: BigText(
                        text: name,
                        size: Dimension.fontBig * size * 0.9,
                      ),
                    ),
                    SizedBox(
                      height: Dimension.gap5,
                    ),
                    //评分与评论
                    Row(
                      children: [
                        Wrap(
                          //评分星级
                          children: List.generate(
                              grade.round(),
                              (index) => Icon(Icons.star,
                                  color: AppColors.mainColor1,
                                  size: Dimension.gap20)),
                        ),
                        SizedBox(
                          width: Dimension.gap2,
                        ),
                        SmallText(
                            text: grade.toString(),
                            color: AppColors.fontColor2,
                            size: Dimension.gap15),
                        SizedBox(
                          width: Dimension.gap20,
                        ),
                        SmallText(text: num_com.toString()),
                        SizedBox(
                          width: Dimension.gap2,
                        ),
                        SmallText(text: "条评论"),
                      ],
                    ),
                    //店铺位置
                    SizedBox(
                      height: Dimension.gap5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconText(
                            icon: Icons.location_on_outlined,
                            text: location,
                            iconColor: AppColors.fontColor2,
                            textColor: AppColors.fontColor2),
                      ],
                    ),
                    //热门评论
                    Row(
                      children: [
                        IconText(
                            icon: Icons.local_fire_department_rounded,
                            text: "Hot Comment",
                            iconColor: Colors.red,
                            textColor: Colors.redAccent),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: Dimension.gap30,
                        ),
                        Container(
                            width: Dimension.gap30 * 6,
                            child: Text(
                              hot_com,
                              maxLines: 1,
                              style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  color: AppColors.fontColor1,
                                  fontSize: Dimension.fontSmall * size,
                                  fontWeight: FontWeight.w400),
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
    );
  }
}
