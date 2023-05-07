import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:goforcate_app/models/group_body.dart';
import 'package:goforcate_app/widgets/button_icon_text.dart';
import 'package:goforcate_app/widgets/edit_text_field.dart';
import 'package:intl/intl.dart';

import '../../base/show_custom_snackbar.dart';
import '../../controllers/group_controller.dart';
import '../../controllers/shop_controller.dart';
import '../../controllers/user_controller.dart';
import '../../models/group_model.dart';
import '../../models/shop_model.dart';
import '../../routes/route_helper.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/big_text.dart';
import '../../widgets/button_icon.dart';
import '../../widgets/home_shoplist.dart';
import '../../widgets/user_avatar.dart';

class GroupEditPage extends StatefulWidget {
  final int groupId;
  final int shopId;

  const GroupEditPage({Key? key, required this.groupId, required this.shopId})
      : super(key: key);

  @override
  _GroupEditPageState createState() => _GroupEditPageState();
}

class _GroupEditPageState extends State<GroupEditPage> {
  var nameController = TextEditingController();
  bool _isAllLoading = false;
  DateTime selectedDate = DateTime.now();
  late GroupModel groupModel;
  late ShopModel shopModel;

  @override
  void initState() {
    super.initState();
    Get.find<GroupController>().getGroup(widget.groupId).then((status) {
      groupModel = Get.find<GroupController>().groupModel;
      selectedDate = DateTime.parse(groupModel.reserve_at!);
      nameController = TextEditingController(text: groupModel.name);
      Get.find<ShopController>().getShopInfo(widget.shopId).then((status) {
        if (status.isSuccess) {
          setState(() {
            shopModel = Get.find<ShopController>().shopModel;
            _isAllLoading = true;
            print(_isAllLoading);
          });
        }
      });
    });
  }

  Future<void> updateGroup() async {
    if (nameController.text.trim() == "") {
      ShowErrorSnackBar("Team name cannot be empty");
    } else {
      print(DateFormat('yyyy-MM-dd HH:mm').format(selectedDate));
      GroupBody groupBody = GroupBody(
          id: 0,
          name: nameController.text.trim(),
          shopId: shopModel.id!,
          leaderId: Get.find<UserController>().userModel.id!,
          reserve_at: DateFormat('yyyy-MM-dd HH:mm').format(selectedDate));
      Get.find<GroupController>()
          .updateGroup(groupBody, widget.groupId)
          .then((status) {
        if (status.isSuccess) {
          ShowSuccessSnackBar("", title: "Successfully update team!");
          Get.toNamed(RouteHelper.getGroupDetail(widget.groupId));
        } else {
          ShowErrorSnackBar(status.message, title: "Failed to update team!");
        }
      });
    }
  }

  Future<void> _showDatePicker() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  Future<void> _showTimePicker() async {
    final TimeOfDay? selectedValue = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(selectedDate),
    );

    if (selectedValue != null) {
      setState(() {
        selectedDate = DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          selectedValue.hour,
          selectedValue.minute,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Get.toNamed(RouteHelper.getGroupDetail(widget.groupId));
          },
          child: Container(
            margin: EdgeInsets.all(Dimension.gap5),
            child: ButtonIcon(
                icon: Icons.close,
                iconColor: AppColors.fontColor1,
                backGroundColor: Colors.white,
                iconSize: Dimension.icon30),
          ),
        ),
        backgroundColor: Colors.white,
        title: BigText(
          text: "Group Edit",
          size: Dimension.gap20,
          color: AppColors.fontColor1,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            //Destination
            GetBuilder<ShopController>(builder: (shopController) {
              return _isAllLoading
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.all(Dimension.gap10),
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: Dimension.gap5),
                                child: BigText(
                                  text: "CHOOSEN RESTAURANT",
                                  size: Dimension.gap15,
                                  color: AppColors.fontColor5,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(RouteHelper.getGroupDest(
                                      widget.groupId, widget.shopId));
                                },
                                child: Container(
                                  child: HomeShopList(
                                      name: shopController.shopModel.name!,
                                      num_com:
                                          shopController.shopModel.comments!,
                                      location:
                                          shopController.shopModel.address!,
                                      grade: shopController.shopModel.grade!,
                                      size: 0.7,
                                      image: shopController.shopModel.coverPic!,
                                      hot_com: ""),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    );
            }),
            //name
            Container(
              width: Dimension.screenWidth,
              margin: EdgeInsets.all(Dimension.gap10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimension.gap10),
                  color: Colors.white,
                  border: Border.all(
                      width: Dimension.gap2 * 0.8, color: AppColors.fontColor1),
                  boxShadow: const [
                    BoxShadow(
                        color: Color(0xffa7a1a1),
                        blurRadius: 1.0,
                        offset: Offset(1, 1))
                  ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  EditTextField(
                    textEditingController: nameController,
                    hintText: "Group Name",
                    length: 10,
                  )
                ],
              ),
            ),
            //date
            Container(
              width: Dimension.screenWidth,
              margin: EdgeInsets.all(Dimension.gap10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimension.gap10),
                  color: Colors.white,
                  border: Border.all(
                      width: Dimension.gap2 * 0.8, color: AppColors.fontColor1),
                  boxShadow: const [
                    BoxShadow(
                        color: Color(0xffa7a1a1),
                        blurRadius: 1.0,
                        offset: Offset(1, 1))
                  ]),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: Dimension.gap5),
                    child: BigText(
                      text: "APPOINTMENT TIME",
                      size: Dimension.gap15,
                      color: AppColors.fontColor5,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: Dimension.gap10, bottom: Dimension.gap10),
                    child: Text(
                      DateFormat('yyyy-MM-dd HH:mm').format(selectedDate),
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () => _showDatePicker(),
                        child: Text('Select Date '),
                      ),
                      SizedBox(width: 20),
                      ElevatedButton(
                        onPressed: () => _showTimePicker(),
                        child: Text('Select Time'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            //select member
            Container(
              width: Dimension.screenWidth,
              margin: EdgeInsets.all(Dimension.gap10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimension.gap10),
                  color: Colors.white,
                  border: Border.all(
                      width: Dimension.gap2 * 0.8, color: AppColors.fontColor1),
                  boxShadow: const [
                    BoxShadow(
                        color: Color(0xffa7a1a1),
                        blurRadius: 1.0,
                        offset: Offset(1, 1))
                  ]),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: Dimension.gap5),
                    child: BigText(
                      text: "Select Members",
                      size: Dimension.gap15,
                      color: AppColors.fontColor5,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: Dimension.gap5,
                        left: Dimension.gap10,
                        right: Dimension.gap30,
                        bottom: Dimension.gap5),
                    child: Row(
                      children: [
                        Icon(
                          CupertinoIcons.flag_fill,
                          color: AppColors.mainColor2,
                        ),
                        SizedBox(
                          width: Dimension.gap10,
                        ),
                        UserAvatar(
                            userId: Get.find<UserController>().userModel.id!,
                            nameColor: Colors.black,
                            avatarSize: Dimension.gap30,
                            nameSize: Dimension.fontMedium,
                            backGroundColor: Colors.white)
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteHelper.getChooseMember());
                    },
                    child: Container(
                      width: Dimension.screenWidth * 0.44,
                      child: ButtonIconText(
                          icon: Icons.add,
                          iconColor: AppColors.mainColor2,
                          backGroundColor: Colors.white,
                          buttonSize: Dimension.gap20,
                          iconSize: Dimension.gap25,
                          text: "Add Member",
                          textColor: AppColors.mainColor2,
                          textSize: Dimension.gap15),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
          height: Dimension.screenHeight * 0.1,
          padding: EdgeInsets.only(
              top: Dimension.gap15,
              bottom: Dimension.gap20,
              left: Dimension.gap30,
              right: Dimension.gap30),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: MaterialButton(
            onPressed: () {
              updateGroup();
            },
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFDFE07B),
                border: Border.all(
                    width: Dimension.gap2 * 0.8, color: Colors.white),
                borderRadius: BorderRadius.circular(Dimension.gap30),
              ),
              child: Center(
                child: Text(
                  "Save Group",
                  maxLines: 1,
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: AppColors.fontColor1,
                      fontSize: Dimension.gap20, //fontBig或者size
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          )),
    );
  }
}
