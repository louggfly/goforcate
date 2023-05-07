import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:goforcate_app/utils/app_constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qiniu_flutter_sdk/qiniu_flutter_sdk.dart';

import '../../base/show_custom_snackbar.dart';
import '../../controllers/user_controller.dart';
import '../../routes/route_helper.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/big_text.dart';
import '../../widgets/button_icon.dart';

class UserAvatarEditPage extends StatefulWidget {
  const UserAvatarEditPage({Key? key}) : super(key: key);

  @override
  _UserAvatarEditPageState createState() => _UserAvatarEditPageState();
}

class _UserAvatarEditPageState extends State<UserAvatarEditPage> {
  final picker = ImagePicker();
  bool hasImage = false;
  late File _image;
  late String _imageUrl;

  Future<void> getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        hasImage = true;
      } else {
        print('没有选择任何图片');
      }
    });
  }

  Future<void> getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        hasImage = true;
      } else {
        print('没有选择任何图片');
      }
    });
  }

  Future<void> saveUserAvatar() async {
    print(Appconstants.QINIUTOKEN);
    if (_image != "") {
      ;
      Storage storage = Storage();
      PutController putController = PutController();
      putController.addStatusListener((StorageStatus status) {
        print('状态变化: 当前任务状态：$status');
      });

      List<Future> uploadTasks = [];

      Future task = storage
          .putFile(
        File(_image.path),
        Appconstants.QINIUTOKEN,
        options: PutOptions(
          controller: putController,
        ),
      )
          .then((response) {
        _imageUrl = ("http://rsuuytr2z.bkt.clouddn.com/${response.key!}");
      });
      uploadTasks.add(task);

      Future.wait(uploadTasks).then((responses) {
        Get.find<UserController>().updateUserAvatar(_imageUrl).then((status) {
          if (status.isSuccess) {
            ShowSuccessSnackBar("Update user avatar success");
            Get.toNamed(RouteHelper.userProfile);
          } else {
            ShowErrorSnackBar("Update user avatar failed");
          }
        });
      }).catchError((error) {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Get.toNamed(RouteHelper.getUserProfile());
          },
          child: Container(
            margin: EdgeInsets.all(Dimension.gap5),
            child: ButtonIcon(
                icon: Icons.arrow_back_outlined,
                iconColor: Colors.white,
                backGroundColor: AppColors.mainColor4,
                iconSize: Dimension.gap30),
          ),
        ),
        backgroundColor: Colors.white,
        title: BigText(
          text: "User Avatar Edit",
          size: Dimension.gap20,
          color: AppColors.fontColor3,
        ),
        centerTitle: true,
      ),
      body: GetBuilder<UserController>(builder: (userController) {
        return Container(
          width: Dimension.screenWidth,
          margin: EdgeInsets.only(
              right: Dimension.gap30,
              left: Dimension.gap30,
              top: Dimension.gap20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Column(
                  children: [
                    !hasImage
                        ? Container(
                            padding: EdgeInsets.only(
                                top: Dimension.gap5, bottom: Dimension.gap2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  height: Dimension.screenWidth * 0.4,
                                  width: Dimension.screenWidth * 0.4,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(999),
                                    color: Colors.purple,
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          userController.userModel.avatar!),
                                    ),
                                  ),
                                ),
                              ],
                            ))
                        : Container(
                            padding: EdgeInsets.only(
                                top: Dimension.gap5, bottom: Dimension.gap2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  height: Dimension.screenWidth * 0.4,
                                  width: Dimension.screenWidth * 0.4,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(999),
                                    color: Colors.purple,
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: FileImage(_image),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
      bottomNavigationBar: Container(
        width: Dimension.screenWidth,
        height: Dimension.screenHeight * 0.4,
        decoration: BoxDecoration(
          color: AppColors.mainColor3,
          borderRadius: BorderRadius.circular(Dimension.gap30),
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                  left: Dimension.gap30 * 2,
                  right: Dimension.gap30 * 2,
                  top: Dimension.gap20),
              decoration: BoxDecoration(
                color: AppColors.mainColor4,
                border: Border.all(
                    width: Dimension.gap2 * 0.8, color: Colors.white),
                borderRadius: BorderRadius.circular(Dimension.gap30),
              ),
              child: MaterialButton(
                onPressed: getImageFromGallery,
                child: Center(
                  child: Text(
                    "SELECT A PHOTO",
                    maxLines: 1,
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        color: Colors.white,
                        fontSize: Dimension.gap15, //fontBig或者size
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  left: Dimension.gap30 * 2,
                  right: Dimension.gap30 * 2,
                  top: Dimension.gap20),
              decoration: BoxDecoration(
                color: AppColors.mainColor4,
                border: Border.all(
                    width: Dimension.gap2 * 0.8, color: Colors.white),
                borderRadius: BorderRadius.circular(Dimension.gap30),
              ),
              child: MaterialButton(
                onPressed: getImageFromCamera,
                child: Center(
                  child: Text(
                    "TAKE A PICTURE",
                    maxLines: 1,
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        color: Colors.white,
                        fontSize: Dimension.gap15, //fontBig或者size
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  left: Dimension.gap30 * 2,
                  right: Dimension.gap30 * 2,
                  top: Dimension.gap20),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                    width: Dimension.gap2 * 0.8, color: Colors.white),
                borderRadius: BorderRadius.circular(Dimension.gap30),
              ),
              child: MaterialButton(
                onPressed: saveUserAvatar,
                child: Center(
                  child: Text(
                    "SAVE",
                    maxLines: 1,
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        color: AppColors.fontColor3,
                        fontSize: Dimension.gap15, //fontBig或者size
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
