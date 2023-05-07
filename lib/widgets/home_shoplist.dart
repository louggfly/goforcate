import 'package:flutter/material.dart';
import 'package:goforcate_app/widgets/small_text.dart';

import '../utils/colors.dart';
import '../utils/dimensions.dart';
import 'big_text.dart';
import 'icon_text.dart';

class HomeShopList extends StatelessWidget {
  final String name;
  final int num_com;
  final String location;
  final String image;
  final double grade;
  final String hot_com;
  final double size;

  const HomeShopList(
      {Key? key,
      required this.name,
      required this.num_com,
      required this.location,
      required this.grade,
      required this.size,
      required this.image,
      required this.hot_com})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimension.gap10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Color(0xffa7a1a1), blurRadius: 1.0, offset: Offset(1, 1))
          ]),
      padding: EdgeInsets.only(
          left: Dimension.gap2, top: Dimension.gap5, bottom: Dimension.gap5),
      child: Row(
        children: [
          //List image
          Container(
            height: Dimension.ListPicContainer,
            width: Dimension.ListPicContainer,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimension.gap10),
                color: Colors.purple,
                image: DecorationImage(
                    fit: BoxFit.cover, image: NetworkImage(image)),
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
              margin:
                  EdgeInsets.only(left: Dimension.gap5, bottom: Dimension.gap5),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Container(
                margin: EdgeInsets.only(
                    left: Dimension.gap5,
                    right: Dimension.gap5,
                    top: Dimension.gap5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: Dimension.gap30 * 6,
                      child: BigText(
                        text: name,
                        size: Dimension.fontBig * size * 0.9,
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
                              grade.ceil(),
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
                            size: Dimension.gap15 * 0.8),
                        SizedBox(
                          width: Dimension.gap10,
                        ),
                        SmallText(text: num_com.toString()),
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconText(
                            icon: Icons.location_on_outlined,
                            text: location,
                            iconColor: AppColors.fontColor2,
                            textColor: AppColors.fontColor2),
                      ],
                    ),
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
                            width: Dimension.gap30 * 5,
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
