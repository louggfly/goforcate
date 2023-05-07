import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goforcate_app/controllers/user_controller.dart';
import 'package:goforcate_app/models/category_list.dart';
import 'package:goforcate_app/models/category_model.dart';
import 'package:goforcate_app/utils/dimensions.dart';
import 'package:goforcate_app/widgets/big_text.dart';
import 'package:goforcate_app/widgets/button_icon.dart';

import '../../base/show_custom_snackbar.dart';
import '../../controllers/area_controller.dart';
import '../../controllers/preference_controller.dart';
import '../../routes/route_helper.dart';
import '../../utils/colors.dart';

class UserPreferencePage extends StatefulWidget {
  int index;

  UserPreferencePage({Key? key, required this.index}) : super(key: key);

  @override
  _UserPreferencePageState createState() => _UserPreferencePageState();
}

class _UserPreferencePageState extends State<UserPreferencePage> with TickerProviderStateMixin {
  late TextEditingController _searchController;
  bool _isAllLoading = true;
  List<dynamic> categoryList = [];
  List<dynamic> preferenceList = [];
  List<List<dynamic>> results = [];

  @override
  void initState() {
    super.initState();
    categoryList = Get.find<PreferenceController>().categoryList;
    Get.find<PreferenceController>().getUserPreference();
    preferenceList = Get.find<PreferenceController>().preferenceList;
    for (CategoryModel category in categoryList){
      results.add([category, 0]);
    }
    for (CategoryModel preference in preferenceList){
      for(int i = 0; i < results.length; i++) {
        if(preference.name == results[i][0].name){
          results[i][1] = 1;
        }
      }
    }
    print(results);
  }

  @override
  Widget build(BuildContext context) {
    categoryList = Get.find<PreferenceController>().categoryList;
    Get.find<PreferenceController>().getUserPreference().then((status){
      if(status.isSuccess){
        preferenceList = Get.find<PreferenceController>().preferenceList;
      }
    });

    Future<void> saveUserPreference() async {
      for(int i = 0; i < results.length; i++) {
        if(results[i][1] == 0){
          for (CategoryModel preference in preferenceList){
              if(preference.name == results[i][0].name){
                Get.find<PreferenceController>().deletePreference(results[i][0].id);
              }
            }
        }
      }
      for(int i = 0; i < results.length; i++) {
        if(results[i][1] == 1){
          Get.find<PreferenceController>().createPreference(results[i][0].id);
        }
      }
      ShowSuccessSnackBar("Update user area success");
      Get.find<PreferenceController>().getUserPreference();
      if (widget.index == 0) {
        Get.toNamed(RouteHelper.getInital(0));
      } else if (widget.index == 1) {
        Get.toNamed(RouteHelper.getUserSetting());
      }
    }

    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              if (widget.index == 0) {
                Get.toNamed(RouteHelper.getInital(0));
              } else if (widget.index == 1) {
                Get.toNamed(RouteHelper.getUserSetting());
              }
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
          title: BigText(
            text: "Edit Your Preference",
            size: Dimension.gap20 * 1.1,
            color: AppColors.fontColor1,
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: GetBuilder<AreaController>(builder: (areaController) {
          return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: ListView.builder(
                physics: AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: results.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if(results[index][1]==1){
                          results[index][1]=0;
                        }else{
                          results[index][1]=1;
                        }
                      });
                    },
                    child: results[index][1]==0?Container(
                        decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(Dimension.gap10),
                          color: AppColors.mainColor2,
                        ),
                        margin: EdgeInsets.only(
                            top: Dimension.gap5,
                            bottom: Dimension.gap5,
                            left: Dimension.gap30,
                            right: Dimension.gap30),
                        padding: EdgeInsets.only(
                            left: Dimension.gap5,
                            right: Dimension.gap5,
                            top: Dimension.gap10,
                            bottom: Dimension.gap10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            BigText(text: results[index][0].name,size: Dimension.gap20*0.90,color: Colors.white,),
                          ],
                        )):
                    Container(
                        decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(Dimension.gap10),
                          color: AppColors.mainColor1,
                        ),
                        margin: EdgeInsets.only(
                            top: Dimension.gap5,
                            bottom: Dimension.gap5,
                            left: Dimension.gap30,
                            right: Dimension.gap30),
                        padding: EdgeInsets.only(
                            left: Dimension.gap5,
                            right: Dimension.gap5,
                            top: Dimension.gap10,
                            bottom: Dimension.gap10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            BigText(text: results[index][0].name,size: Dimension.gap20*0.90,color: AppColors.fontColor1,),
                            SizedBox(width: Dimension.gap10,),
                            Icon(CupertinoIcons.checkmark_alt_circle,color: AppColors.fontColor1,),
                          ],
                        )),
                  );
                })
            );
        }),
        bottomNavigationBar:
          GestureDetector(
            onTap: (){
                saveUserPreference();
            },
            child: Container(
              margin: EdgeInsets.only(
                  top: Dimension.gap5,
                  bottom: Dimension.gap20,
                  left: Dimension.gap30*3,
                  right: Dimension.gap30*3),
              padding: EdgeInsets.only(
                  left: Dimension.gap5,
                  right: Dimension.gap5,
                  top: Dimension.gap10,
                  bottom: Dimension.gap10),
              child: ButtonIcon(icon: CupertinoIcons.checkmark, iconColor: AppColors.fontColor1, backGroundColor: AppColors.mainColor1, iconSize: Dimension.gap30*1.3),
            ),
      ),
    );
  }
}
