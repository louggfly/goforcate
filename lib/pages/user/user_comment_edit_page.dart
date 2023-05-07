import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:goforcate_app/controllers/commentlist_controller.dart';
import 'package:goforcate_app/models/comment_body.dart';
import 'package:goforcate_app/models/comment_model.dart';
import 'package:goforcate_app/models/shop_model.dart';
import 'package:goforcate_app/utils/app_constants.dart';
import 'package:goforcate_app/widgets/edit_text_field.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qiniu_flutter_sdk/qiniu_flutter_sdk.dart';

import '../../base/show_custom_snackbar.dart';
import '../../controllers/autoscore_controller.dart';
import '../../controllers/shop_controller.dart';
import '../../routes/route_helper.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/big_text.dart';
import '../../widgets/button_icon.dart';
import '../../widgets/home_shoplist.dart';

class UserCommentEditPage extends StatefulWidget {
  final int shopId;
  final int commentId;

  const UserCommentEditPage(
      {Key? key, required this.shopId, required this.commentId})
      : super(key: key);

  @override
  _UserCommentEditPageState createState() => _UserCommentEditPageState();
}

class _UserCommentEditPageState extends State<UserCommentEditPage> {
  var commentController = TextEditingController();
  List<File> _images = [];
  late List<String> _imagesUrl;
  final picker = ImagePicker();
  int grade = 5;
  bool isLoading = false;

  Future<void> getImageFromGallery() async {
    final pickedFiles = await picker.pickMultiImage();

    setState(() {
      if (pickedFiles != null) {
        _images = pickedFiles.map((file) => File(file.path)).toList();
      } else {
        print('没有选择任何图片');
      }
    });
  }

  Future<void> uploadImages() async {
    _imagesUrl = [];
    if (_images.length != 0) {
      Storage storage = Storage();
      PutController putController = PutController();
      putController.addStatusListener((StorageStatus status) {
        print('状态变化: 当前任务状态：$status');
      });

      List<Future> uploadTasks = [];

      for (int i = 0; i < _images.length; i++) {
        Future task = storage
            .putFile(File(_images[i].path), Appconstants.QINIUTOKEN,
                options: PutOptions(
                  controller: putController,
                ))
            .then((response) {
          _imagesUrl.add("http://rsuuytr2z.bkt.clouddn.com/" + response.key!);
        });

        uploadTasks.add(task);
      }

      Future.wait(uploadTasks).then((responses) {
        CommentBody commentBody = CommentBody(
            shopId: widget.shopId,
            comment: commentController.text,
            imagesUrl: _imagesUrl,
            grade: 5.0);
        Get.find<ShopController>().releaseComment(commentBody).then((status) {
          if (status.isSuccess) {
            ShowSuccessSnackBar("", title: "发布成功!");
            print(int.parse(status.message));
            Get.toNamed(RouteHelper.getReleaseSuccess(
                int.parse(status.message), widget.shopId));
          } else {
            ShowErrorSnackBar(status.message, title: "发布失败!");
          }
        });
      }).catchError((error) {});
    }
  }

  @override
  Widget build(BuildContext context) {
    int shopId = widget.shopId;
    int commentId = widget.commentId;
    bool _isAllLoading = false;
    late ShopComment commentModel;
    late ShopModel shopModel;
    Get.find<ShopController>().getShopInfo(shopId).then((status) {
      shopModel = Get.find<ShopController>().shopModel;
      if (status.isSuccess) {
        commentModel =
            Get.find<CommentListController>().getCommentInfo(commentId);
        _isAllLoading = true;
        commentController = TextEditingController(text: commentModel.content);
        grade = commentModel.grade!.ceil();
      }
    });

    void getAutoScore(String input){
      if(input==""){
        ShowErrorSnackBar("", title: "评价内容为空！");
      } else if(input.length < 10){
        ShowErrorSnackBar("", title: "评价内容不得少于10个字符！");
      } else{
        setState(() {
          isLoading = true;
        });
        Get.find<AutoScoreController>().getSentaScore(input).then((status){
          if (status.isSuccess) {
            grade = Get.find<AutoScoreController>().grade;
            print(grade);
            setState(() {
              grade = Get.find<AutoScoreController>().grade;
              isLoading = false;
            });
          }
        });
      }
    }

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Get.toNamed(RouteHelper.getUserComment(commentId, shopId));
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
        backgroundColor: Colors.white,
        elevation: 0,
        title: BigText(
          text: "Edit Comment",
          size: Dimension.gap20,
          color: AppColors.mainColor2,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: GetBuilder<ShopController>(builder: (shopController) {
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
                                //Get.toNamed(RouteHelper.getUserCommentDest(commentId,shopId));
                              },
                              child: Container(
                                child: HomeShopList(
                                    name: shopModel.name!,
                                    num_com: shopModel.comments!,
                                    location: shopModel.address!,
                                    grade: shopModel.grade!,
                                    size: 0.7,
                                    image: shopModel.coverPic!,
                                    hot_com: ""),
                              ),
                            )
                          ],
                        ),
                      ),
                      MaterialButton(
                        onPressed: getImageFromGallery,
                        child: Container(
                          width: Dimension.screenWidth,
                          margin: EdgeInsets.all(Dimension.gap5),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Dimension.gap10),
                              color: Colors.white,
                              border: Border.all(
                                  width: Dimension.gap2 * 0.8,
                                  color: AppColors.mainColor2),
                              boxShadow: const [
                                BoxShadow(
                                    color: Color(0xffa7a1a1),
                                    blurRadius: 1.0,
                                    offset: Offset(1, 1))
                              ]),
                          child: _images.length != 0
                              ? Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: Dimension.gap5,
                                          bottom: Dimension.gap5),
                                      child: BigText(
                                        text: "UPLOAD PICTURES",
                                        size: Dimension.gap10,
                                        color: AppColors.mainColor2,
                                      ),
                                    ),
                                    Wrap(
                                      spacing: 10,
                                      runSpacing: 10,
                                      children: _images
                                          .map((image) => Image.file(
                                                image,
                                                fit: BoxFit.cover,
                                                width: Dimension.screenWidth *
                                                    0.25,
                                                height: Dimension.screenWidth *
                                                    0.25,
                                              ))
                                          .toList(),
                                    ),
                                    SizedBox(
                                      height: Dimension.gap10,
                                    )
                                  ],
                                )
                              : Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: Dimension.gap5,
                                          bottom: Dimension.gap5),
                                      child: BigText(
                                        text: "UPLOAD PICTURES",
                                        size: Dimension.gap10,
                                        color: AppColors.mainColor2,
                                      ),
                                    ),
                                    Wrap(
                                      spacing: 10,
                                      runSpacing: 10,
                                      children: commentModel.pictures
                                          .map((image) => Image.network(
                                                image.pictureLink!,
                                                fit: BoxFit.cover,
                                                width: Dimension.screenWidth *
                                                    0.25,
                                                height: Dimension.screenWidth *
                                                    0.25,
                                              ))
                                          .toList(),
                                    ),
                                    SizedBox(
                                      height: Dimension.gap10,
                                    )
                                  ],
                                ),
                        ),
                      ),
                      Container(
                        width: Dimension.screenWidth,
                        height: Dimension.screenHeight * 0.5,
                        margin: EdgeInsets.all(Dimension.gap10),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimension.gap10),
                            color: Colors.white,
                            border: Border.all(
                                width: Dimension.gap2 * 0.8,
                                color: AppColors.mainColor2),
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
                              textEditingController: commentController,
                              hintText: "Add comment content",
                              length: 255,
                            ),
                            !isLoading?Column(
                              children: [
                                ElevatedButton(
                                    onPressed: (){
                                      getAutoScore(commentController.text.trim());
                                    },
                                    child: Text("AutoScore")
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    BigText(text: grade.toString()),
                                    SizedBox(width: Dimension.gap10,),
                                    Wrap(
                                      //评分星级
                                      children: List.generate(
                                          grade.ceil(),
                                              (index) => Icon(Icons.star,
                                              color: AppColors.mainColor1,
                                              size: Dimension.gap30)),
                                    ),
                                  ],
                                ),
                              ],
                            )
                                :Center(child: CircularProgressIndicator(),)
                          ],
                        ),
                      ),
                    ],
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  );
          })),
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
            onPressed: uploadImages,
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFDFE07B),
                border: Border.all(
                    width: Dimension.gap2 * 0.8, color: Colors.white),
                borderRadius: BorderRadius.circular(Dimension.gap30),
              ),
              child: Center(
                child: Text(
                  "Save",
                  maxLines: 1,
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: Colors.black54,
                      fontSize: Dimension.gap20, //fontBig或者size
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          )),
    );
  }
}
