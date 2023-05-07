import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:goforcate_app/widgets/expandable_text.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';

import '../../controllers/commentlist_controller.dart';
import '../../controllers/notice_controller.dart';
import '../../controllers/shop_controller.dart';
import '../../controllers/shoplist_controller.dart';
import '../../routes/route_helper.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/big_text.dart';
import '../../widgets/button_icon.dart';
import '../../widgets/comment_item.dart';
import '../../widgets/home_shoplist.dart';

class NoticePage extends StatefulWidget {
  const NoticePage({Key? key}) : super(key: key);

  @override
  _NoticePageState createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage> {
  List<dynamic> noticeList = Get.find<NoticeController>().noticeList;
  @override
  Widget build(BuildContext context) {
    Get.find<NoticeController>().getNoticeList();
    noticeList = Get.find<NoticeController>().noticeList;
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
              Get.toNamed(RouteHelper.getInital(2));
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
          text: "Notice",
          size: Dimension.gap20 * 1.1,
          color: Colors.white,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: ListView.builder(
            physics:
            AlwaysScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: noticeList.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.all(Dimension.gap10),
                padding:  EdgeInsets.all(Dimension.gap10),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BigText(text: noticeList[index].title),
                        BigText(
                          text: noticeList[index].time.split("T")[0] +
                              " " +
                              noticeList[index].time.split("T")[1].substring(0,
                                  5),
                          size: Dimension.fontBig *
                              0.6,
                        ),
                      ],
                    ),
                    ExpandableText(text: noticeList[index].content, size: 1)
                  ],
                ),
              );
            }),
      ),
    );
  }
}
