import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:goforcate_app/controllers/group_controller.dart';
import 'package:goforcate_app/controllers/shoplist_controller.dart';
import 'package:goforcate_app/widgets/user_avatar.dart';
import 'package:intl/intl.dart';

import '../../base/show_custom_snackbar.dart';
import '../../models/shop_model.dart';
import '../../routes/route_helper.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/big_text.dart';

class GroupPage extends StatefulWidget {
  const GroupPage({Key? key}) : super(key: key);

  @override
  _GroupPageState createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> with TickerProviderStateMixin {
  late TabController _tabController;
  DateTime? _selectedDate;
  DateTime? _firstDateOfTheWeek;
  List<dynamic> _groupListOfWeek = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 7, vsync: this);
    _selectedDate = DateTime.now();
    _firstDateOfTheWeek = findFirstDateOfTheWeek(DateTime.now());
  }

  DateTime findFirstDateOfTheWeek(DateTime dateTime) {
    _groupListOfWeek = [];
    DateTime firstDay = dateTime.subtract(Duration(days: dateTime.weekday - 1));
    Get.find<GroupController>().getGroupList();
    for (int i = 0; i <= 6; i++) {
      _groupListOfWeek.add(Get.find<GroupController>().getGroupOnDate(firstDay.add(Duration(days: i)).toString().split(" ")[0]));
    }
    return firstDay;
  }

  Future<void> deleteGroup(int groupId) async {
    Get.find<GroupController>().deleteGroup(groupId).then((status) {
      if (status.isSuccess) {
        ShowSuccessSnackBar("", title: "Successfully delete group!");
        Get.toNamed(RouteHelper.getInital(3));
      } else {
        ShowErrorSnackBar(status.message, title: "Failed to delete group!");
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    void _showConfirmDialog(int groupId) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Delete Group'),
            content: Text('Are you sure you want to delete this group?'),
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
                  deleteGroup(groupId);
                  Navigator.of(context).pop();
                  Get.toNamed(RouteHelper.getInital(3));
                },
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: Container(
          color: AppColors.mainColor2,
        ),
        backgroundColor: AppColors.mainColor2,
        title: BigText(
          text: "Schedule",
          size: Dimension.gap20 * 1.1,
          color: Colors.white,
        ),
        centerTitle: true,
        actions: [
          Container(
            margin: EdgeInsets.only(right: Dimension.gap10),
            child: IconButton(
              onPressed: () async {
                var result = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2025),
                  cancelText: 'Cancel',
                  confirmText: 'Confirm',
                );
                setState(() {
                  _selectedDate = result;
                  _firstDateOfTheWeek = findFirstDateOfTheWeek(result!);
                });
              },
              icon: Icon(Icons.date_range_outlined, size: Dimension.gap25),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Positioned(
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.mainColor2, borderRadius: BorderRadius.only(bottomLeft: Radius.circular(Dimension.gap10), bottomRight: Radius.circular(Dimension.gap10))),
                  width: Dimension.screenWidth,
                  padding: EdgeInsets.only(left: Dimension.gap20, right: Dimension.gap20, bottom: Dimension.gap10),
                  child: TabBar(
                    isScrollable: true,
                    unselectedLabelColor: Colors.white,
                    labelColor: AppColors.fontColor1,
                    indicator: BoxDecoration(borderRadius: BorderRadius.circular(Dimension.gap10), color: AppColors.mainColor1, border: Border.all(color: AppColors.mainColor1)),
                    controller: _tabController,
                    tabs: [
                      Tab(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              DateFormat('MM-dd').format(_firstDateOfTheWeek!),
                              maxLines: 1,
                              style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: Dimension.gap10, //fontBig或者size
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "Mon",
                              maxLines: 1,
                              style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: Dimension.gap10, //fontBig或者size
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      Tab(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              DateFormat('MM-dd').format(_firstDateOfTheWeek!.add(Duration(days: 1))),
                              maxLines: 1,
                              style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: Dimension.gap10, //fontBig或者size
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "Tue",
                              maxLines: 1,
                              style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: Dimension.gap10, //fontBig或者size
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      Tab(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              DateFormat('MM-dd').format(_firstDateOfTheWeek!.add(Duration(days: 2))),
                              maxLines: 1,
                              style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: Dimension.gap10, //fontBig或者size
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "Wed",
                              maxLines: 1,
                              style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: Dimension.gap10, //fontBig或者size
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      Tab(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              DateFormat('MM-dd').format(_firstDateOfTheWeek!.add(Duration(days: 3))),
                              maxLines: 1,
                              style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: Dimension.gap10, //fontBig或者size
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "Thu",
                              maxLines: 1,
                              style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: Dimension.gap10, //fontBig或者size
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      Tab(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              DateFormat('MM-dd').format(_firstDateOfTheWeek!.add(Duration(days: 4))),
                              maxLines: 1,
                              style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: Dimension.gap10, //fontBig或者size
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "Fri",
                              maxLines: 1,
                              style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: Dimension.gap10, //fontBig或者size
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      Tab(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              DateFormat('MM-dd').format(_firstDateOfTheWeek!.add(Duration(days: 5))),
                              maxLines: 1,
                              style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: Dimension.gap10, //fontBig或者size
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "Sat",
                              maxLines: 1,
                              style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: Dimension.gap10, //fontBig或者size
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      Tab(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              DateFormat('MM-dd').format(_firstDateOfTheWeek!.add(Duration(days: 6))),
                              maxLines: 1,
                              style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: Dimension.gap10, //fontBig或者size
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "Sun",
                              maxLines: 1,
                              style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: Dimension.gap10, //fontBig或者size
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
                child: Container(
                  margin: EdgeInsets.only(top: Dimension.screenHeight * 0.09),
                  width: Dimension.screenWidth,
                  height: Dimension.screenHeight * 0.67,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      Container(
                          margin: EdgeInsets.only(left: Dimension.gap5, right: Dimension.gap5),
                          child: _groupListOfWeek[0].length != 0
                              ? Container(
                                  child: ListView.builder(
                                      physics: AlwaysScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: _groupListOfWeek[0].length,
                                      itemBuilder: (context, index) {
                                        final item = _groupListOfWeek[0][index];
                                        ShopModel shopModel = Get.find<ShopListController>().shopList[item.shop_id - 1]; //bug?
                                        return GestureDetector(
                                          onTap: () {
                                            Get.toNamed(RouteHelper.getGroupDetail(item.id));
                                          },
                                          child: Container(
                                            child: Stack(
                                              children: [
                                                Positioned(
                                                  child: Container(
                                                    margin: EdgeInsets.only(top: Dimension.gap5, bottom: Dimension.gap2, left: Dimension.gap10, right: Dimension.gap10),
                                                    padding: EdgeInsets.only(top: Dimension.gap2, bottom: Dimension.gap2, left: Dimension.gap5, right: Dimension.gap5),
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(Dimension.gap10),
                                                      color: Colors.white,
                                                      border: Border.all(width: Dimension.gap2 * 0.8, color: AppColors.borderColor1),
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        //shopname
                                                        Container(
                                                          margin: EdgeInsets.only(top: Dimension.gap2, bottom: Dimension.gap2, left: Dimension.gap5),
                                                          child: BigText(
                                                            text: shopModel.name!,
                                                            size: Dimension.gap15 * 1,
                                                          ),
                                                        ),
                                                        Row(
                                                          children: [
                                                            Container(
                                                              width: Dimension.gap30 * 3,
                                                              height: Dimension.gap30 * 3,
                                                              margin: EdgeInsets.only(top: Dimension.gap2, bottom: Dimension.gap2, left: Dimension.gap5, right: Dimension.gap10),
                                                              decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(Dimension.gap10),
                                                                  color: Colors.purple,
                                                                  image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(shopModel.coverPic!))),
                                                            ),
                                                            Container(
                                                              height: Dimension.gap30 * 3,
                                                              margin: EdgeInsets.only(
                                                                top: Dimension.gap2,
                                                                bottom: Dimension.gap2,
                                                              ),
                                                              child: Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      Icon(
                                                                        Icons.flag_outlined,
                                                                        size: Dimension.gap25,
                                                                      ),
                                                                      Container(
                                                                        margin: EdgeInsets.only(top: Dimension.gap2, bottom: Dimension.gap2, left: Dimension.gap5),
                                                                        child: BigText(
                                                                          text: item.name,
                                                                          size: Dimension.gap15,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      Icon(
                                                                        Icons.access_time_outlined,
                                                                        size: Dimension.gap20,
                                                                      ),
                                                                      SizedBox(
                                                                        width: 5,
                                                                      ),
                                                                      BigText(
                                                                        text: item.reserve_at.split("T")[0] + " " + item.reserve_at.split("T")[1].substring(0, 5),
                                                                        size: Dimension.fontBig * 0.6,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  SizedBox(
                                                                    height: Dimension.gap2,
                                                                  ),
                                                                  Container(
                                                                    width: Dimension.screenWidth * 0.45,
                                                                    padding: EdgeInsets.all(3),
                                                                    decoration: BoxDecoration(
                                                                      color: AppColors.bottomColor1,
                                                                      borderRadius: BorderRadius.circular(999),
                                                                    ),
                                                                    child: SingleChildScrollView(
                                                                      scrollDirection: Axis.horizontal,
                                                                      child: Wrap(
                                                                          children: List.generate(
                                                                              1,
                                                                              (index) => Container(
                                                                                    width: Dimension.screenWidth * 0.25,
                                                                                    child: UserAvatar(
                                                                                        userId: item.leader_id,
                                                                                        nameColor: AppColors.fontColor1,
                                                                                        avatarSize: Dimension.gap20,
                                                                                        nameSize: Dimension.gap10,
                                                                                        backGroundColor: Colors.white),
                                                                                  ))),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: Dimension.gap20,
                                                            ),
                                                            Column(
                                                              children: [
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    _showConfirmDialog(item.id);
                                                                  },
                                                                  child: Container(
                                                                    padding: EdgeInsets.all(3),
                                                                    decoration: BoxDecoration(color: Colors.redAccent, borderRadius: BorderRadius.circular(Dimension.gap5)),
                                                                    child: Icon(
                                                                      CupertinoIcons.delete_solid,
                                                                      color: Colors.black,
                                                                      size: Dimension.gap20,
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: Dimension.gap15,
                                                                ),
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    Get.toNamed(RouteHelper.getGroupEdit(item.id, item.shop_id));
                                                                  },
                                                                  child: Container(
                                                                    padding: EdgeInsets.all(3),
                                                                    decoration: BoxDecoration(color: AppColors.mainColor2, borderRadius: BorderRadius.circular(Dimension.gap5)),
                                                                    child: Icon(
                                                                      Icons.edit,
                                                                      color: Colors.white,
                                                                      size: Dimension.gap20,
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }))
                              : Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(top: Dimension.gap30 * 2),
                                      width: Dimension.screenWidth * 0.4,
                                      child: const Image(
                                        image: AssetImage("graphics/noschedule.png"),
                                        fit: BoxFit.fitWidth,
                                      ),
                                    ),
                                    SizedBox(
                                      height: Dimension.gap20,
                                    ),
                                    BigText(
                                      text: "No Schdule",
                                      color: AppColors.mainColor2,
                                    ),
                                  ],
                                )),
                      Container(
                          margin: EdgeInsets.only(left: Dimension.gap10, right: Dimension.gap10),
                          child: _groupListOfWeek[1].length != 0
                              ? Container(
                                  child: ListView.builder(
                                      physics: AlwaysScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: _groupListOfWeek[1].length,
                                      itemBuilder: (context, index) {
                                        final item = _groupListOfWeek[1][index];
                                        ShopModel shopModel = Get.find<ShopListController>().shopList[item.shop_id - 1]; //bug?
                                        return GestureDetector(
                                          onTap: () {
                                            Get.toNamed(RouteHelper.getGroupDetail(item.id));
                                          },
                                          child: Container(
                                            child: Stack(
                                              children: [
                                                Positioned(
                                                  child: Container(
                                                    margin: EdgeInsets.only(top: Dimension.gap5, bottom: Dimension.gap2, left: Dimension.gap10, right: Dimension.gap10),
                                                    padding: EdgeInsets.only(top: Dimension.gap2, bottom: Dimension.gap2, left: Dimension.gap5, right: Dimension.gap5),
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(Dimension.gap10),
                                                      color: Colors.white,
                                                      border: Border.all(width: Dimension.gap2 * 0.8, color: AppColors.borderColor1),
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        //shopname
                                                        Container(
                                                          margin: EdgeInsets.only(top: Dimension.gap2, bottom: Dimension.gap2, left: Dimension.gap5),
                                                          child: BigText(
                                                            text: shopModel.name!,
                                                            size: Dimension.gap15 * 1,
                                                          ),
                                                        ),
                                                        Row(
                                                          children: [
                                                            Container(
                                                              width: Dimension.gap30 * 3,
                                                              height: Dimension.gap30 * 3,
                                                              margin: EdgeInsets.only(top: Dimension.gap2, bottom: Dimension.gap2, left: Dimension.gap5, right: Dimension.gap10),
                                                              decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(Dimension.gap10),
                                                                  color: Colors.purple,
                                                                  image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(shopModel.coverPic!))),
                                                            ),
                                                            Container(
                                                              height: Dimension.gap30 * 3,
                                                              margin: EdgeInsets.only(
                                                                top: Dimension.gap2,
                                                                bottom: Dimension.gap2,
                                                              ),
                                                              child: Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      Icon(
                                                                        Icons.flag_outlined,
                                                                        size: Dimension.gap25,
                                                                      ),
                                                                      Container(
                                                                        margin: EdgeInsets.only(top: Dimension.gap2, bottom: Dimension.gap2, left: Dimension.gap5),
                                                                        child: BigText(
                                                                          text: item.name,
                                                                          size: Dimension.gap15,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      Icon(
                                                                        Icons.access_time_outlined,
                                                                        size: Dimension.gap20,
                                                                      ),
                                                                      SizedBox(
                                                                        width: 5,
                                                                      ),
                                                                      BigText(
                                                                        text: item.reserve_at.split("T")[0] + " " + item.reserve_at.split("T")[1].substring(0, 5),
                                                                        size: Dimension.fontBig * 0.6,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  SizedBox(
                                                                    height: Dimension.gap2,
                                                                  ),
                                                                  Container(
                                                                    width: Dimension.screenWidth * 0.45,
                                                                    padding: EdgeInsets.all(3),
                                                                    decoration: BoxDecoration(
                                                                      color: AppColors.bottomColor1,
                                                                      borderRadius: BorderRadius.circular(999),
                                                                    ),
                                                                    child: SingleChildScrollView(
                                                                      scrollDirection: Axis.horizontal,
                                                                      child: Wrap(
                                                                          children: List.generate(
                                                                              1,
                                                                              (index) => Container(
                                                                                    width: Dimension.screenWidth * 0.25,
                                                                                    child: UserAvatar(
                                                                                        userId: item.leader_id,
                                                                                        nameColor: AppColors.fontColor1,
                                                                                        avatarSize: Dimension.gap20,
                                                                                        nameSize: Dimension.gap10,
                                                                                        backGroundColor: Colors.white),
                                                                                  ))),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: Dimension.gap20,
                                                            ),
                                                            Column(
                                                              children: [
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    _showConfirmDialog(item.id);
                                                                  },
                                                                  child: Container(
                                                                    padding: EdgeInsets.all(3),
                                                                    decoration: BoxDecoration(color: Colors.redAccent, borderRadius: BorderRadius.circular(Dimension.gap5)),
                                                                    child: Icon(
                                                                      CupertinoIcons.delete_solid,
                                                                      color: Colors.black,
                                                                      size: Dimension.gap20,
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: Dimension.gap15,
                                                                ),
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    Get.toNamed(RouteHelper.getGroupEdit(item.id, item.shop_id));
                                                                  },
                                                                  child: Container(
                                                                    padding: EdgeInsets.all(3),
                                                                    decoration: BoxDecoration(color: AppColors.mainColor2, borderRadius: BorderRadius.circular(Dimension.gap5)),
                                                                    child: Icon(
                                                                      Icons.edit,
                                                                      color: Colors.white,
                                                                      size: Dimension.gap20,
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }))
                              : Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(top: Dimension.gap30 * 2),
                                      width: Dimension.screenWidth * 0.4,
                                      child: const Image(
                                        image: AssetImage("graphics/noschedule.png"),
                                        fit: BoxFit.fitWidth,
                                      ),
                                    ),
                                    SizedBox(
                                      height: Dimension.gap20,
                                    ),
                                    BigText(
                                      text: "No Schdule",
                                      color: AppColors.mainColor2,
                                    ),
                                  ],
                                )),
                      Container(
                          margin: EdgeInsets.only(left: Dimension.gap10, right: Dimension.gap10),
                          child: _groupListOfWeek[2].length != 0
                              ? Container(
                                  child: ListView.builder(
                                      physics: AlwaysScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: _groupListOfWeek[2].length,
                                      itemBuilder: (context, index) {
                                        final item = _groupListOfWeek[2][index];
                                        ShopModel shopModel = Get.find<ShopListController>().shopList[item.shop_id - 1]; //bug?
                                        return GestureDetector(
                                          onTap: () {
                                            Get.toNamed(RouteHelper.getGroupDetail(item.id));
                                          },
                                          child: Container(
                                            child: Stack(
                                              children: [
                                                Positioned(
                                                  child: Container(
                                                    margin: EdgeInsets.only(top: Dimension.gap5, bottom: Dimension.gap2, left: Dimension.gap10, right: Dimension.gap10),
                                                    padding: EdgeInsets.only(top: Dimension.gap2, bottom: Dimension.gap2, left: Dimension.gap5, right: Dimension.gap5),
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(Dimension.gap10),
                                                      color: Colors.white,
                                                      border: Border.all(width: Dimension.gap2 * 0.8, color: AppColors.borderColor1),
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        //shopname
                                                        Container(
                                                          margin: EdgeInsets.only(top: Dimension.gap2, bottom: Dimension.gap2, left: Dimension.gap5),
                                                          child: BigText(
                                                            text: shopModel.name!,
                                                            size: Dimension.gap15 * 1,
                                                          ),
                                                        ),
                                                        Row(
                                                          children: [
                                                            Container(
                                                              width: Dimension.gap30 * 3,
                                                              height: Dimension.gap30 * 3,
                                                              margin: EdgeInsets.only(top: Dimension.gap2, bottom: Dimension.gap2, left: Dimension.gap5, right: Dimension.gap10),
                                                              decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(Dimension.gap10),
                                                                  color: Colors.purple,
                                                                  image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(shopModel.coverPic!))),
                                                            ),
                                                            Container(
                                                              height: Dimension.gap30 * 3,
                                                              margin: EdgeInsets.only(
                                                                top: Dimension.gap2,
                                                                bottom: Dimension.gap2,
                                                              ),
                                                              child: Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      Icon(
                                                                        Icons.flag_outlined,
                                                                        size: Dimension.gap25,
                                                                      ),
                                                                      Container(
                                                                        margin: EdgeInsets.only(top: Dimension.gap2, bottom: Dimension.gap2, left: Dimension.gap5),
                                                                        child: BigText(
                                                                          text: item.name,
                                                                          size: Dimension.gap15,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      Icon(
                                                                        Icons.access_time_outlined,
                                                                        size: Dimension.gap20,
                                                                      ),
                                                                      SizedBox(
                                                                        width: 5,
                                                                      ),
                                                                      BigText(
                                                                        text: item.reserve_at.split("T")[0] + " " + item.reserve_at.split("T")[1].substring(0, 5),
                                                                        size: Dimension.fontBig * 0.6,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  SizedBox(
                                                                    height: Dimension.gap2,
                                                                  ),
                                                                  Container(
                                                                    width: Dimension.screenWidth * 0.45,
                                                                    padding: EdgeInsets.all(3),
                                                                    decoration: BoxDecoration(
                                                                      color: AppColors.bottomColor1,
                                                                      borderRadius: BorderRadius.circular(999),
                                                                    ),
                                                                    child: SingleChildScrollView(
                                                                      scrollDirection: Axis.horizontal,
                                                                      child: Wrap(
                                                                          children: List.generate(
                                                                              1,
                                                                              (index) => Container(
                                                                                    width: Dimension.screenWidth * 0.25,
                                                                                    child: UserAvatar(
                                                                                        userId: item.leader_id,
                                                                                        nameColor: AppColors.fontColor1,
                                                                                        avatarSize: Dimension.gap20,
                                                                                        nameSize: Dimension.gap10,
                                                                                        backGroundColor: Colors.white),
                                                                                  ))),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: Dimension.gap20,
                                                            ),
                                                            Column(
                                                              children: [
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    _showConfirmDialog(item.id);
                                                                  },
                                                                  child: Container(
                                                                    padding: EdgeInsets.all(3),
                                                                    decoration: BoxDecoration(color: Colors.redAccent, borderRadius: BorderRadius.circular(Dimension.gap5)),
                                                                    child: Icon(
                                                                      CupertinoIcons.delete_solid,
                                                                      color: Colors.black,
                                                                      size: Dimension.gap20,
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: Dimension.gap15,
                                                                ),
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    Get.toNamed(RouteHelper.getGroupEdit(item.id, item.shop_id));
                                                                  },
                                                                  child: Container(
                                                                    padding: EdgeInsets.all(3),
                                                                    decoration: BoxDecoration(color: AppColors.mainColor2, borderRadius: BorderRadius.circular(Dimension.gap5)),
                                                                    child: Icon(
                                                                      Icons.edit,
                                                                      color: Colors.white,
                                                                      size: Dimension.gap20,
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }))
                              : Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(top: Dimension.gap30 * 2),
                                      width: Dimension.screenWidth * 0.4,
                                      child: const Image(
                                        image: AssetImage("graphics/noschedule.png"),
                                        fit: BoxFit.fitWidth,
                                      ),
                                    ),
                                    SizedBox(
                                      height: Dimension.gap20,
                                    ),
                                    BigText(
                                      text: "No Schdule",
                                      color: AppColors.mainColor2,
                                    ),
                                  ],
                                )),
                      Container(
                          margin: EdgeInsets.only(left: Dimension.gap10, right: Dimension.gap10),
                          child: _groupListOfWeek[3].length != 0
                              ? Container(
                                  child: ListView.builder(
                                      physics: AlwaysScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: _groupListOfWeek[3].length,
                                      itemBuilder: (context, index) {
                                        final item = _groupListOfWeek[3][index];
                                        ShopModel shopModel = Get.find<ShopListController>().shopList[item.shop_id - 1]; //bug?
                                        return GestureDetector(
                                          onTap: () {
                                            Get.toNamed(RouteHelper.getGroupDetail(item.id));
                                          },
                                          child: Container(
                                            child: Stack(
                                              children: [
                                                Positioned(
                                                  child: Container(
                                                    margin: EdgeInsets.only(top: Dimension.gap5, bottom: Dimension.gap2, left: Dimension.gap10, right: Dimension.gap10),
                                                    padding: EdgeInsets.only(top: Dimension.gap2, bottom: Dimension.gap2, left: Dimension.gap5, right: Dimension.gap5),
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(Dimension.gap10),
                                                      color: Colors.white,
                                                      border: Border.all(width: Dimension.gap2 * 0.8, color: AppColors.borderColor1),
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        //shopname
                                                        Container(
                                                          margin: EdgeInsets.only(top: Dimension.gap2, bottom: Dimension.gap2, left: Dimension.gap5),
                                                          child: BigText(
                                                            text: shopModel.name!,
                                                            size: Dimension.gap15 * 1,
                                                          ),
                                                        ),
                                                        Row(
                                                          children: [
                                                            Container(
                                                              width: Dimension.gap30 * 3,
                                                              height: Dimension.gap30 * 3,
                                                              margin: EdgeInsets.only(top: Dimension.gap2, bottom: Dimension.gap2, left: Dimension.gap5, right: Dimension.gap10),
                                                              decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(Dimension.gap10),
                                                                  color: Colors.purple,
                                                                  image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(shopModel.coverPic!))),
                                                            ),
                                                            Container(
                                                              height: Dimension.gap30 * 3,
                                                              margin: EdgeInsets.only(
                                                                top: Dimension.gap2,
                                                                bottom: Dimension.gap2,
                                                              ),
                                                              child: Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      Icon(
                                                                        Icons.flag_outlined,
                                                                        size: Dimension.gap25,
                                                                      ),
                                                                      Container(
                                                                        margin: EdgeInsets.only(top: Dimension.gap2, bottom: Dimension.gap2, left: Dimension.gap5),
                                                                        child: BigText(
                                                                          text: item.name,
                                                                          size: Dimension.gap15,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      Icon(
                                                                        Icons.access_time_outlined,
                                                                        size: Dimension.gap20,
                                                                      ),
                                                                      SizedBox(
                                                                        width: 5,
                                                                      ),
                                                                      BigText(
                                                                        text: item.reserve_at.split("T")[0] + " " + item.reserve_at.split("T")[1].substring(0, 5),
                                                                        size: Dimension.fontBig * 0.6,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  SizedBox(
                                                                    height: Dimension.gap2,
                                                                  ),
                                                                  Container(
                                                                    width: Dimension.screenWidth * 0.45,
                                                                    padding: EdgeInsets.all(3),
                                                                    decoration: BoxDecoration(
                                                                      color: AppColors.bottomColor1,
                                                                      borderRadius: BorderRadius.circular(999),
                                                                    ),
                                                                    child: SingleChildScrollView(
                                                                      scrollDirection: Axis.horizontal,
                                                                      child: Wrap(
                                                                          children: List.generate(
                                                                              1,
                                                                              (index) => Container(
                                                                                    width: Dimension.screenWidth * 0.25,
                                                                                    child: UserAvatar(
                                                                                        userId: item.leader_id,
                                                                                        nameColor: AppColors.fontColor1,
                                                                                        avatarSize: Dimension.gap20,
                                                                                        nameSize: Dimension.gap10,
                                                                                        backGroundColor: Colors.white),
                                                                                  ))),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: Dimension.gap20,
                                                            ),
                                                            Column(
                                                              children: [
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    _showConfirmDialog(item.id);
                                                                  },
                                                                  child: Container(
                                                                    padding: EdgeInsets.all(3),
                                                                    decoration: BoxDecoration(color: Colors.redAccent, borderRadius: BorderRadius.circular(Dimension.gap5)),
                                                                    child: Icon(
                                                                      CupertinoIcons.delete_solid,
                                                                      color: Colors.black,
                                                                      size: Dimension.gap20,
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: Dimension.gap15,
                                                                ),
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    Get.toNamed(RouteHelper.getGroupEdit(item.id, item.shop_id));
                                                                  },
                                                                  child: Container(
                                                                    padding: EdgeInsets.all(3),
                                                                    decoration: BoxDecoration(color: AppColors.mainColor2, borderRadius: BorderRadius.circular(Dimension.gap5)),
                                                                    child: Icon(
                                                                      Icons.edit,
                                                                      color: Colors.white,
                                                                      size: Dimension.gap20,
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }))
                              : Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(top: Dimension.gap30 * 2),
                                      width: Dimension.screenWidth * 0.4,
                                      child: const Image(
                                        image: AssetImage("graphics/noschedule.png"),
                                        fit: BoxFit.fitWidth,
                                      ),
                                    ),
                                    SizedBox(
                                      height: Dimension.gap20,
                                    ),
                                    BigText(
                                      text: "No Schdule",
                                      color: AppColors.mainColor2,
                                    ),
                                  ],
                                )),
                      Container(
                          margin: EdgeInsets.only(left: Dimension.gap10, right: Dimension.gap10),
                          child: _groupListOfWeek[4].length != 0
                              ? Container(
                                  child: ListView.builder(
                                      physics: AlwaysScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: _groupListOfWeek[4].length,
                                      itemBuilder: (context, index) {
                                        final item = _groupListOfWeek[4][index];
                                        ShopModel shopModel = Get.find<ShopListController>().shopList[item.shop_id - 1]; //bug?
                                        return GestureDetector(
                                          onTap: () {
                                            Get.toNamed(RouteHelper.getGroupDetail(item.id));
                                          },
                                          child: Container(
                                            child: Stack(
                                              children: [
                                                Positioned(
                                                  child: Container(
                                                    margin: EdgeInsets.only(top: Dimension.gap5, bottom: Dimension.gap2, left: Dimension.gap10, right: Dimension.gap10),
                                                    padding: EdgeInsets.only(top: Dimension.gap2, bottom: Dimension.gap2, left: Dimension.gap5, right: Dimension.gap5),
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(Dimension.gap10),
                                                      color: Colors.white,
                                                      border: Border.all(width: Dimension.gap2 * 0.8, color: AppColors.borderColor1),
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        //shopname
                                                        Container(
                                                          margin: EdgeInsets.only(top: Dimension.gap2, bottom: Dimension.gap2, left: Dimension.gap5),
                                                          child: BigText(
                                                            text: shopModel.name!,
                                                            size: Dimension.gap15 * 1,
                                                          ),
                                                        ),
                                                        Row(
                                                          children: [
                                                            Container(
                                                              width: Dimension.gap30 * 3,
                                                              height: Dimension.gap30 * 3,
                                                              margin: EdgeInsets.only(top: Dimension.gap2, bottom: Dimension.gap2, left: Dimension.gap5, right: Dimension.gap10),
                                                              decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(Dimension.gap10),
                                                                  color: Colors.purple,
                                                                  image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(shopModel.coverPic!))),
                                                            ),
                                                            Container(
                                                              height: Dimension.gap30 * 3,
                                                              margin: EdgeInsets.only(
                                                                top: Dimension.gap2,
                                                                bottom: Dimension.gap2,
                                                              ),
                                                              child: Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      Icon(
                                                                        Icons.flag_outlined,
                                                                        size: Dimension.gap25,
                                                                      ),
                                                                      Container(
                                                                        margin: EdgeInsets.only(top: Dimension.gap2, bottom: Dimension.gap2, left: Dimension.gap5),
                                                                        child: BigText(
                                                                          text: item.name,
                                                                          size: Dimension.gap15,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      Icon(
                                                                        Icons.access_time_outlined,
                                                                        size: Dimension.gap20,
                                                                      ),
                                                                      SizedBox(
                                                                        width: 5,
                                                                      ),
                                                                      BigText(
                                                                        text: item.reserve_at.split("T")[0] + " " + item.reserve_at.split("T")[1].substring(0, 5),
                                                                        size: Dimension.fontBig * 0.6,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  SizedBox(
                                                                    height: Dimension.gap2,
                                                                  ),
                                                                  Container(
                                                                    width: Dimension.screenWidth * 0.45,
                                                                    padding: EdgeInsets.all(3),
                                                                    decoration: BoxDecoration(
                                                                      color: AppColors.bottomColor1,
                                                                      borderRadius: BorderRadius.circular(999),
                                                                    ),
                                                                    child: SingleChildScrollView(
                                                                      scrollDirection: Axis.horizontal,
                                                                      child: Wrap(
                                                                          children: List.generate(
                                                                              1,
                                                                              (index) => Container(
                                                                                    width: Dimension.screenWidth * 0.25,
                                                                                    child: UserAvatar(
                                                                                        userId: item.leader_id,
                                                                                        nameColor: AppColors.fontColor1,
                                                                                        avatarSize: Dimension.gap20,
                                                                                        nameSize: Dimension.gap10,
                                                                                        backGroundColor: Colors.white),
                                                                                  ))),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: Dimension.gap20,
                                                            ),
                                                            Column(
                                                              children: [
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    _showConfirmDialog(item.id);
                                                                  },
                                                                  child: Container(
                                                                    padding: EdgeInsets.all(3),
                                                                    decoration: BoxDecoration(color: Colors.redAccent, borderRadius: BorderRadius.circular(Dimension.gap5)),
                                                                    child: Icon(
                                                                      CupertinoIcons.delete_solid,
                                                                      color: Colors.black,
                                                                      size: Dimension.gap20,
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: Dimension.gap15,
                                                                ),
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    Get.toNamed(RouteHelper.getGroupEdit(item.id, item.shop_id));
                                                                  },
                                                                  child: Container(
                                                                    padding: EdgeInsets.all(3),
                                                                    decoration: BoxDecoration(color: AppColors.mainColor2, borderRadius: BorderRadius.circular(Dimension.gap5)),
                                                                    child: Icon(
                                                                      Icons.edit,
                                                                      color: Colors.white,
                                                                      size: Dimension.gap20,
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }))
                              : Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(top: Dimension.gap30 * 2),
                                      width: Dimension.screenWidth * 0.4,
                                      child: const Image(
                                        image: AssetImage("graphics/noschedule.png"),
                                        fit: BoxFit.fitWidth,
                                      ),
                                    ),
                                    SizedBox(
                                      height: Dimension.gap20,
                                    ),
                                    BigText(
                                      text: "No Schdule",
                                      color: AppColors.mainColor2,
                                    ),
                                  ],
                                )),
                      Container(
                          margin: EdgeInsets.only(left: Dimension.gap10, right: Dimension.gap10),
                          child: _groupListOfWeek[5].length != 0
                              ? Container(
                                  child: ListView.builder(
                                      physics: AlwaysScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: _groupListOfWeek[5].length,
                                      itemBuilder: (context, index) {
                                        final item = _groupListOfWeek[5][index];
                                        ShopModel shopModel = Get.find<ShopListController>().shopList[item.shop_id - 1]; //bug?
                                        return GestureDetector(
                                          onTap: () {
                                            Get.toNamed(RouteHelper.getGroupDetail(item.id));
                                          },
                                          child: Container(
                                            child: Stack(
                                              children: [
                                                Positioned(
                                                  child: Container(
                                                    margin: EdgeInsets.only(top: Dimension.gap5, bottom: Dimension.gap2, left: Dimension.gap10, right: Dimension.gap10),
                                                    padding: EdgeInsets.only(top: Dimension.gap2, bottom: Dimension.gap2, left: Dimension.gap5, right: Dimension.gap5),
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(Dimension.gap10),
                                                      color: Colors.white,
                                                      border: Border.all(width: Dimension.gap2 * 0.8, color: AppColors.borderColor1),
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        //shopname
                                                        Container(
                                                          margin: EdgeInsets.only(top: Dimension.gap2, bottom: Dimension.gap2, left: Dimension.gap5),
                                                          child: BigText(
                                                            text: shopModel.name!,
                                                            size: Dimension.gap15 * 1,
                                                          ),
                                                        ),
                                                        Row(
                                                          children: [
                                                            Container(
                                                              width: Dimension.gap30 * 3,
                                                              height: Dimension.gap30 * 3,
                                                              margin: EdgeInsets.only(top: Dimension.gap2, bottom: Dimension.gap2, left: Dimension.gap5, right: Dimension.gap10),
                                                              decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(Dimension.gap10),
                                                                  color: Colors.purple,
                                                                  image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(shopModel.coverPic!))),
                                                            ),
                                                            Container(
                                                              height: Dimension.gap30 * 3,
                                                              margin: EdgeInsets.only(
                                                                top: Dimension.gap2,
                                                                bottom: Dimension.gap2,
                                                              ),
                                                              child: Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      Icon(
                                                                        Icons.flag_outlined,
                                                                        size: Dimension.gap25,
                                                                      ),
                                                                      Container(
                                                                        margin: EdgeInsets.only(top: Dimension.gap2, bottom: Dimension.gap2, left: Dimension.gap5),
                                                                        child: BigText(
                                                                          text: item.name,
                                                                          size: Dimension.gap15,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      Icon(
                                                                        Icons.access_time_outlined,
                                                                        size: Dimension.gap20,
                                                                      ),
                                                                      SizedBox(
                                                                        width: 5,
                                                                      ),
                                                                      BigText(
                                                                        text: item.reserve_at.split("T")[0] + " " + item.reserve_at.split("T")[1].substring(0, 5),
                                                                        size: Dimension.fontBig * 0.6,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  SizedBox(
                                                                    height: Dimension.gap2,
                                                                  ),
                                                                  Container(
                                                                    width: Dimension.screenWidth * 0.45,
                                                                    padding: EdgeInsets.all(3),
                                                                    decoration: BoxDecoration(
                                                                      color: AppColors.bottomColor1,
                                                                      borderRadius: BorderRadius.circular(999),
                                                                    ),
                                                                    child: SingleChildScrollView(
                                                                      scrollDirection: Axis.horizontal,
                                                                      child: Wrap(
                                                                          children: List.generate(
                                                                              1,
                                                                              (index) => Container(
                                                                                    width: Dimension.screenWidth * 0.25,
                                                                                    child: UserAvatar(
                                                                                        userId: item.leader_id,
                                                                                        nameColor: AppColors.fontColor1,
                                                                                        avatarSize: Dimension.gap20,
                                                                                        nameSize: Dimension.gap10,
                                                                                        backGroundColor: Colors.white),
                                                                                  ))),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: Dimension.gap20,
                                                            ),
                                                            Column(
                                                              children: [
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    _showConfirmDialog(item.id);
                                                                  },
                                                                  child: Container(
                                                                    padding: EdgeInsets.all(3),
                                                                    decoration: BoxDecoration(color: Colors.redAccent, borderRadius: BorderRadius.circular(Dimension.gap5)),
                                                                    child: Icon(
                                                                      CupertinoIcons.delete_solid,
                                                                      color: Colors.black,
                                                                      size: Dimension.gap20,
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: Dimension.gap15,
                                                                ),
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    Get.toNamed(RouteHelper.getGroupEdit(item.id, item.shop_id));
                                                                  },
                                                                  child: Container(
                                                                    padding: EdgeInsets.all(3),
                                                                    decoration: BoxDecoration(color: AppColors.mainColor2, borderRadius: BorderRadius.circular(Dimension.gap5)),
                                                                    child: Icon(
                                                                      Icons.edit,
                                                                      color: Colors.white,
                                                                      size: Dimension.gap20,
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }))
                              : Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(top: Dimension.gap30 * 2),
                                      width: Dimension.screenWidth * 0.4,
                                      child: const Image(
                                        image: AssetImage("graphics/noschedule.png"),
                                        fit: BoxFit.fitWidth,
                                      ),
                                    ),
                                    SizedBox(
                                      height: Dimension.gap20,
                                    ),
                                    BigText(
                                      text: "No Schdule",
                                      color: AppColors.mainColor2,
                                    ),
                                  ],
                                )),
                      Container(
                          margin: EdgeInsets.only(left: Dimension.gap10, right: Dimension.gap10),
                          child: _groupListOfWeek[6].length != 0
                              ? Container(
                                  child: ListView.builder(
                                      physics: AlwaysScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: _groupListOfWeek[6].length,
                                      itemBuilder: (context, index) {
                                        final item = _groupListOfWeek[6][index];
                                        ShopModel shopModel = Get.find<ShopListController>().shopList[item.shop_id - 1]; //bug?
                                        return GestureDetector(
                                          onTap: () {
                                            Get.toNamed(RouteHelper.getGroupDetail(item.id));
                                          },
                                          child: Container(
                                            child: Stack(
                                              children: [
                                                Positioned(
                                                  child: Container(
                                                    margin: EdgeInsets.only(top: Dimension.gap5, bottom: Dimension.gap2, left: Dimension.gap10, right: Dimension.gap10),
                                                    padding: EdgeInsets.only(top: Dimension.gap2, bottom: Dimension.gap2, left: Dimension.gap5, right: Dimension.gap5),
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(Dimension.gap10),
                                                      color: Colors.white,
                                                      border: Border.all(width: Dimension.gap2 * 0.8, color: AppColors.borderColor1),
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        //shopname
                                                        Container(
                                                          margin: EdgeInsets.only(top: Dimension.gap2, bottom: Dimension.gap2, left: Dimension.gap5),
                                                          child: BigText(
                                                            text: shopModel.name!,
                                                            size: Dimension.gap15 * 1,
                                                          ),
                                                        ),
                                                        Row(
                                                          children: [
                                                            Container(
                                                              width: Dimension.gap30 * 3,
                                                              height: Dimension.gap30 * 3,
                                                              margin: EdgeInsets.only(top: Dimension.gap2, bottom: Dimension.gap2, left: Dimension.gap5, right: Dimension.gap10),
                                                              decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(Dimension.gap10),
                                                                  color: Colors.purple,
                                                                  image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(shopModel.coverPic!))),
                                                            ),
                                                            Container(
                                                              height: Dimension.gap30 * 3,
                                                              margin: EdgeInsets.only(
                                                                top: Dimension.gap2,
                                                                bottom: Dimension.gap2,
                                                              ),
                                                              child: Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      Icon(
                                                                        Icons.flag_outlined,
                                                                        size: Dimension.gap25,
                                                                      ),
                                                                      Container(
                                                                        margin: EdgeInsets.only(top: Dimension.gap2, bottom: Dimension.gap2, left: Dimension.gap5),
                                                                        child: BigText(
                                                                          text: item.name,
                                                                          size: Dimension.gap15,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      Icon(
                                                                        Icons.access_time_outlined,
                                                                        size: Dimension.gap20,
                                                                      ),
                                                                      SizedBox(
                                                                        width: 5,
                                                                      ),
                                                                      BigText(
                                                                        text: item.reserve_at.split("T")[0] + " " + item.reserve_at.split("T")[1].substring(0, 5),
                                                                        size: Dimension.fontBig * 0.6,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  SizedBox(
                                                                    height: Dimension.gap2,
                                                                  ),
                                                                  Container(
                                                                    width: Dimension.screenWidth * 0.45,
                                                                    padding: EdgeInsets.all(3),
                                                                    decoration: BoxDecoration(
                                                                      color: AppColors.bottomColor1,
                                                                      borderRadius: BorderRadius.circular(999),
                                                                    ),
                                                                    child: SingleChildScrollView(
                                                                      scrollDirection: Axis.horizontal,
                                                                      child: Wrap(
                                                                          children: List.generate(
                                                                              1,
                                                                              (index) => Container(
                                                                                    width: Dimension.screenWidth * 0.25,
                                                                                    child: UserAvatar(
                                                                                        userId: item.leader_id,
                                                                                        nameColor: AppColors.fontColor1,
                                                                                        avatarSize: Dimension.gap20,
                                                                                        nameSize: Dimension.gap10,
                                                                                        backGroundColor: Colors.white),
                                                                                  ))),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: Dimension.gap20,
                                                            ),
                                                            Column(
                                                              children: [
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    _showConfirmDialog(item.id);
                                                                  },
                                                                  child: Container(
                                                                    padding: EdgeInsets.all(3),
                                                                    decoration: BoxDecoration(color: Colors.redAccent, borderRadius: BorderRadius.circular(Dimension.gap5)),
                                                                    child: Icon(
                                                                      CupertinoIcons.delete_solid,
                                                                      color: Colors.black,
                                                                      size: Dimension.gap20,
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: Dimension.gap15,
                                                                ),
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    Get.toNamed(RouteHelper.getGroupEdit(item.id, item.shop_id));
                                                                  },
                                                                  child: Container(
                                                                    padding: EdgeInsets.all(3),
                                                                    decoration: BoxDecoration(color: AppColors.mainColor2, borderRadius: BorderRadius.circular(Dimension.gap5)),
                                                                    child: Icon(
                                                                      Icons.edit,
                                                                      color: Colors.white,
                                                                      size: Dimension.gap20,
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }))
                              : Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(top: Dimension.gap30 * 2),
                                      width: Dimension.screenWidth * 0.4,
                                      child: const Image(
                                        image: AssetImage("graphics/noschedule.png"),
                                        fit: BoxFit.fitWidth,
                                      ),
                                    ),
                                    SizedBox(
                                      height: Dimension.gap20,
                                    ),
                                    BigText(
                                      text: "No Schdule",
                                      color: AppColors.mainColor2,
                                    ),
                                  ],
                                )),
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
