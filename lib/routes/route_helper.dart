import 'package:get/get.dart';
import 'package:goforcate_app/pages/group/group_create_page.dart';
import 'package:goforcate_app/pages/group/group_edit_page.dart';
import 'package:goforcate_app/pages/login/login_page.dart';
import 'package:goforcate_app/pages/login/password_forget_page.dart';
import 'package:goforcate_app/pages/login/register_verification_page.dart';
import 'package:goforcate_app/pages/notice/notice_page.dart';
import 'package:goforcate_app/pages/search/search_input_page.dart';
import 'package:goforcate_app/pages/shop/release_comment_page.dart';
import 'package:goforcate_app/pages/shop/release_success_page.dart';
import 'package:goforcate_app/pages/shop/shop_choose_page.dart';
import 'package:goforcate_app/pages/shop/shop_comment_page.dart';
import 'package:goforcate_app/pages/shop/shop_detail_page.dart';
import 'package:goforcate_app/pages/splash/splash_page.dart';
import 'package:goforcate_app/pages/user/user_comment_edit_page.dart';
import 'package:goforcate_app/pages/user/user_other_page.dart';
import 'package:goforcate_app/pages/user/user_preference_page.dart';
import 'package:goforcate_app/pages/user/user_profile_edit_page.dart';
import 'package:goforcate_app/pages/user/user_profile_page.dart';
import 'package:goforcate_app/pages/user/user_safety_page.dart';
import 'package:goforcate_app/pages/user/user_setting_page.dart';
import 'package:goforcate_app/widgets/bottom_bar.dart';

import '../pages/area/area_page.dart';
import '../pages/group/group_dest_page.dart';
import '../pages/group/group_detail_page.dart';
import '../pages/group/member_choose_page.dart';
import '../pages/user/avatar_edit_page.dart';
import '../pages/user/user_comment_dest_page.dart';
import '../pages/user/user_comment_page.dart';

class RouteHelper {
  static const String splashPage = "/splash-page";
  static const String inital = "/";
  static const String shopPage = "/shop-page";
  static const String shopComment = "/shop-comment";
  static const String releaseComment = "/release-comment";
  static const String releaseSuccess = "/release-success";
  static const String chooseShop = "/choose-shop";
  static const String inputSearch = "/input-search";
  static const String userOther = "/user-other";
  static const String userSetting = "/user-setting";
  static const String userSafety = "/user-safety";
  static const String userProfile = "/user-profile";
  static const String userProfileEdit = "/user-profile-edit";
  static const String userComment = "/user-comment";
  static const String userCommentEdit = "/user-comment-edit";
  static const String userCommentDest = "/user-comment-dest";
  static const String userAvatarEdit = "/user-avatar-edit";
  static const String groupCreate = "/group-create";
  static const String groupDetail = "/group-detail";
  static const String groupEdit = "/group-edit";
  static const String groupDest = "/group-dest";
  static const String chooseMember = "/choose_member";
  static const String login = "/login";
  static const String registerVer = "/register-verification";
  static const String forgetPassword = "/forget-password";
  static const String chooseArea = "/choose-area";
  static const String noticePage = "/notice-page";
  static const String userPreference = "/user-preference-page";

  static String getSplashPage() => '$splashPage';

  static String getInital(int index) => '$inital?index=$index';

  static String getShopPage(int shopId) => '$shopPage?shopId=$shopId';

  static String getShopComment(int commentId, int shopId) =>
      '$shopComment?commentId=$commentId&shopId=$shopId';

  static String getReleaseComment(int shopId) =>
      '$releaseComment?shopId=$shopId';

  static String getReleaseSuccess(int commentId, int shopId) =>
      '$releaseSuccess?commentId=$commentId&shopId=$shopId';

  static String getChoooseShop(int index) => '$chooseShop?index=$index';

  static String getInputSearch(int index) => '$inputSearch?index=$index';

  static String getOtherUser(int userId) => '$userOther?userId=$userId';

  static String getUserProfile() => '$userProfile';

  static String getUserProfileEdit() => '$userProfileEdit';

  static String getUserComment(int commentId, int shopId) =>
      '$userComment?commentId=$commentId&shopId=$shopId';

  static String getUserCommentEdit(int commentId, int shopId) =>
      '$userCommentEdit?commentId=$commentId&shopId=$shopId';

  static String getUserCommentDest(int commentId, int shopId) =>
      '$userCommentDest?commentId=$commentId&shopId=$shopId';

  static String getUserAvatarEdit() => '$userAvatarEdit';

  static String getUserSetting() => '$userSetting';

  static String getGroupCreate(int shopId) => '$groupCreate?shopId=$shopId';

  static String getGroupDetail(int groupId) => '$groupDetail?groupId=$groupId';

  static String getGroupEdit(int groupId, int shopId) =>
      '$groupEdit?groupId=$groupId&shopId=$shopId';

  static String getGroupDest(int groupId, int shopId) =>
      '$groupDest?groupId=$groupId&shopId=$shopId';

  static String getChooseMember() => '$chooseMember';

  static String getLogin() => '$login';

  static String getRegisterVer() => '$registerVer';

  static String getChooseArea(int index) => '$chooseArea?index=$index';

  static String getNoticePage() => '$noticePage';

  static String getUserPreferencePage(int index) => '$userPreference?index=$index';

  static String getUserSafetyPage() => '$userSafety';

  static String getForgetPasswordPage() => '$forgetPassword';

  static List<GetPage> routes = [
    GetPage(name: splashPage, page: () => SplashScreen()),
    GetPage(
        name: inital,
        page: () {
          var index = Get.parameters['index'];
          print("home page get caller " + index.toString());
          return BottomBar(index: int.parse(index!));
        }),
    //shop page
    GetPage(
      name: shopPage,
      page: () {
        var shopId = Get.parameters['shopId'];
        print("shop page get caller");
        return ShopDetailPage(shopId: int.parse(shopId!));
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: shopComment,
      page: () {
        var commentId = Get.parameters['commentId'];
        var shopId = Get.parameters['shopId'];
        print("shop comment get caller");
        return ShopPageComment(
          commentId: int.parse(commentId!),
          shopId: int.parse(shopId!),
        );
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: userOther,
      page: () {
        var userId = Get.parameters['userId'];
        print("other user get caller");
        return UserOtherPage(
          userId: int.parse(userId!),
        );
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: releaseComment,
      page: () {
        var shopId = Get.parameters['shopId'];
        print("release comment get caller");
        return ReleaseCommentPage(
          shopId: int.parse(shopId!),
        );
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: releaseSuccess,
      page: () {
        var commentId = Get.parameters['commentId'];
        var shopId = Get.parameters['shopId'];
        print("release success get caller");
        return ReleaseSuccessPage(
          commentId: int.parse(commentId!),
          shopId: int.parse(shopId!),
        );
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: inputSearch,
      page: () {
        var index = Get.parameters['index'];
        print("input search get caller");
        return SearchInputPage(index: int.parse(index!));
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: chooseArea,
      page: () {
        var index = Get.parameters['index'];
        print("area choose get caller");
        return AreaPage(index: int.parse(index!));
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: groupCreate,
      page: () {
        var shopId = Get.parameters['shopId'];
        print("group create get caller");
        return GroupCreatePage(shopId: int.parse(shopId!));
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: groupDetail,
      page: () {
        var groupId = Get.parameters['groupId'];
        print("group detail get caller");
        return GroupDetailPage(groupId: int.parse(groupId!));
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: groupEdit,
      page: () {
        var groupId = Get.parameters['groupId'];
        var shopId = Get.parameters['shopId'];
        print("group edit get caller");
        return GroupEditPage(
            groupId: int.parse(groupId!), shopId: int.parse(shopId!));
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: groupDest,
      page: () {
        var groupId = Get.parameters['groupId'];
        var shopId = Get.parameters['shopId'];
        print("group dest get caller");
        return GroupDestPage(
          groupId: int.parse(groupId!),
          shopId: int.parse(shopId!),
        );
      },
      transition: Transition.fadeIn,
    ),
    GetPage(name: chooseMember, page: () => MemberChoosePage()),
    GetPage(
      name: chooseShop,
      page: () {
        var index = Get.parameters['index'];
        print("shop choose get caller");
        return ShopChoosePage(index: int.parse(index!));
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: userComment,
      page: () {
        var commentId = Get.parameters['commentId'];
        var shopId = Get.parameters['shopId'];
        print("user comment get caller");
        return UserCommentPage(
          commentId: int.parse(commentId!),
          shopId: int.parse(shopId!),
        );
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: userCommentEdit,
      page: () {
        var commentId = Get.parameters['commentId'];
        var shopId = Get.parameters['shopId'];
        print("user comment edit get caller");
        return UserCommentEditPage(
          commentId: int.parse(commentId!),
          shopId: int.parse(shopId!),
        );
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: userCommentDest,
      page: () {
        var commentId = Get.parameters['commentId'];
        var shopId = Get.parameters['shopId'];
        print("user comment dest get caller");
        return UserCommentDestPage(
          commentId: int.parse(commentId!),
          shopId: int.parse(shopId!),
        );
      },
      transition: Transition.fadeIn,
    ),
    GetPage(name: userProfile, page: () => UserProfilePage()),
    GetPage(name: userProfileEdit, page: () => UserProfileEditPage()),
    GetPage(name: userAvatarEdit, page: () => UserAvatarEditPage()),
    GetPage(name: userSetting, page: () => UserSettingPage()),
    GetPage(name: login, page: () => LoginPage()),
    GetPage(name: registerVer, page: () => RegisterVerPage()),
    GetPage(name: noticePage, page: () => NoticePage()),
    GetPage(name: userSafety, page: () => UserSafetyPage()),
    GetPage(name: forgetPassword, page: () => ForgetPasswordPage()),
    GetPage(
      name: userPreference,
      page: () {
        var index = Get.parameters['index'];
        print("user preference get caller");
        return UserPreferencePage(index: int.parse(index!));
      },
      transition: Transition.fadeIn,
    ),
  ];
}
