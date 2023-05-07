import 'package:get/get.dart';
import 'package:goforcate_app/data/api/api_client.dart';
import 'package:goforcate_app/models/signup_body.dart';
import 'package:goforcate_app/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo extends GetxService {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  AuthRepo({
    required this.apiClient,
    required this.sharedPreferences,
  });

  Future<Response> registration(SignUpBody signUpBody) async {
    return await apiClient.postData(
        Appconstants.REGISTRATION_URI, signUpBody.toJson());
  }

  bool userLoggedIn() {
    if (sharedPreferences.getString(Appconstants.TOKEN) == "") {
      return false;
    }
    return true;
  }

  Future<Response> login(String phone, String password) async {
    return await apiClient.postData(
        Appconstants.LOGIN_URI, {"phone": phone, "password": password});
  }

  Future<Response> newpassword(String phone, String password) async {
    return await apiClient.postData(
        Appconstants.NEW_PASSWORD_URI, {"phone": phone, "password": password});
  }

  Future<String> getUserToken() async {
    return await sharedPreferences.getString(Appconstants.TOKEN) ?? "None";
  }

  Future<bool> saveUserToken(String token,String qiniutoken) async {
    apiClient.token = token;
    apiClient.updateHeader(token);
    Appconstants.TOKEN = token;
    //Appconstants.QINIUTOKEN = qiniutoken;
    //await sharedPreferences.setString(Appconstants.QINIUTOKEN, qiniutoken);
    return await sharedPreferences.setString(Appconstants.TOKEN, token);
  }

  Future<void> saveUserPhoneAndPassword(String phone, String password) async {
    try {
      Appconstants.PASSWORD = password;
      Appconstants.PHONE = phone;
      await sharedPreferences.setString(Appconstants.PHONE, phone);
      await sharedPreferences.setString(Appconstants.PASSWORD, password);
    } catch (e) {
      throw e;
    }
  }

  bool logout() {
    print("Deleted token: " + sharedPreferences.getString(Appconstants.TOKEN)!);
    Appconstants.TOKEN = "";
    Appconstants.PASSWORD = "";
    Appconstants.PHONE = "";
    Appconstants.QINIUTOKEN="";
    sharedPreferences.remove(Appconstants.TOKEN);
    sharedPreferences.remove(Appconstants.PHONE);
    sharedPreferences.remove(Appconstants.PASSWORD);
    //sharedPreferences.remove(Appconstants.QINIUTOKEN);
    apiClient.token = "";
    apiClient.updateHeader("");
    return true;
  }
}
