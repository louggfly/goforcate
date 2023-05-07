import 'package:get/get.dart';
import 'package:goforcate_app/models/response_model.dart';

import '../data/repository/auth_repo.dart';
import '../models/signup_body.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;

  AuthController({required this.authRepo});

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<ResponseModel> registration(SignUpBody signUpBody) async {
    Response response = await authRepo.registration(signUpBody);
    late ResponseModel responseModel;
    if (response.statusCode == 201) {
      authRepo.saveUserPhoneAndPassword(signUpBody.phone, signUpBody.password);
      authRepo.saveUserToken(response.body["token"],response.body["qiniutoken"]);
      responseModel = ResponseModel(true, response.body["token"]);
      responseModel = ResponseModel(true, response.toString());
    } else {
      responseModel = ResponseModel(false, response.body['message']);
    }
    update();
    return responseModel;
  }

  Future<ResponseModel> login(String phone, String password) async {
    update();
    Response response = await authRepo.login(phone, password);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      authRepo.saveUserPhoneAndPassword(phone, password);
      authRepo.saveUserToken(response.body["token"],response.body["qiniutoken"]);
      responseModel = ResponseModel(true, response.body["token"]);
      responseModel = ResponseModel(true, response.toString());
    } else {
      responseModel = ResponseModel(false, response.body['message']);
    }
    _isLoading = true;
    update();
    return responseModel;
  }

  Future<ResponseModel> newpassword(String phone, String password) async {
    update();
    Response response = await authRepo.newpassword(phone,password);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      responseModel = ResponseModel(true, response.toString());
    } else {
      responseModel = ResponseModel(false, response.body['message']);
    }
    update();
    return responseModel;
  }

  void saveUserPhoneAndPassword(String phone, String password) async {
    authRepo.saveUserPhoneAndPassword(phone, password);
  }

  bool userLoggedIn() {
    return authRepo.userLoggedIn();
  }

  bool logout() {
    return authRepo.logout();
  }
}
