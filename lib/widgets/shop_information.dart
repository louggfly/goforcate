import 'package:flutter/material.dart';
import 'package:goforcate_app/widgets/small_text.dart';
import 'package:goforcate_app/widgets/small_text_line.dart';

import '../utils/colors.dart';
import '../utils/dimensions.dart';
import 'big_text.dart';
import 'icon_text_more.dart';

class ShopInformation extends StatelessWidget {
  final String name;
  final int num_com;
  final String distance;
  final String location;
  final String phone;
  final String openTime;
  final double grade;
  final double size;

  const ShopInformation(
      {Key? key,
      required this.name,
      required this.num_com,
      required this.distance,
      required this.location,
      required this.grade,
      required this.size,
      required this.phone,
      required this.openTime})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: Dimension.gap10,
          ),
          BigText(text: name, size: Dimension.gap20 * size * 0.9),
          SizedBox(
            height: Dimension.gap5,
          ),
          Row(
            children: [
              Wrap(
                //评分星级
                children: List.generate(
                    5,
                    (index) => Icon(Icons.star,
                        color: AppColors.mainColor1,
                        size: Dimension.gap20 * size)),
              ),
              SizedBox(
                width: Dimension.gap2 * size,
              ),
              SmallTextLine(
                  text: grade.toString(),
                  color: AppColors.fontColor2,
                  size: Dimension.gap15 * size * 0.9),
              SizedBox(
                width: Dimension.gap20 * size,
              ),
              SmallTextLine(
                text: num_com.toString(),
                size: Dimension.fontSmall * size,
              ),
              SizedBox(
                width: Dimension.gap2 * size,
              ),
              SmallText(text: "条评论"),
            ],
          ),
          //地址
          SizedBox(
            height: Dimension.gap5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconTextMore(
                  icon: Icons.location_on_outlined,
                  text: location,
                  iconColor: AppColors.fontColor2,
                  textColor: AppColors.fontColor2),
              SmallTextLine(
                text: distance + " m",
                size: Dimension.fontSmall * size,
              ),
            ],
          ),
          //营业时间
          SizedBox(
            height: Dimension.gap5,
          ),
          Row(
            children: [
              IconTextMore(
                  icon: Icons.av_timer,
                  text: "营业时间： " + openTime,
                  iconColor: AppColors.fontColor2,
                  textColor: AppColors.fontColor2),
            ],
          ),
          //联系方式
          SizedBox(
            height: Dimension.gap5,
          ),
          Row(
            children: [
              IconTextMore(
                  icon: Icons.phone,
                  text: "联系方式： " + phone,
                  iconColor: AppColors.fontColor2,
                  textColor: AppColors.fontColor2),
            ],
          ),
          SizedBox(
            height: Dimension.gap5,
          ),
        ],
      ),
    );
  }
}
