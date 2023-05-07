import 'package:get/get.dart';
import 'package:goforcate_app/controllers/user_controller.dart';

import '../data/repository/area_repo.dart';
import '../data/repository/autoscore_repo.dart';
import '../models/area_list.dart';
import '../models/response_model.dart';

class AutoScoreController extends GetxController {
  final AutoScoreRepo autoScoreRepo;

  int grade = 0;

  AutoScoreController({required this.autoScoreRepo});

  Future<ResponseModel> getSentaScore(String input) async {
    Response response = await autoScoreRepo.getSentaScore(input);
    late ResponseModel responseModel;
    print(response.statusCode);
    if (response.statusCode == 200) {
      print("got score");
      grade = response.body["score"];
      print("grade=" + grade.toString());
      update();
      responseModel = ResponseModel(true, "成功获取自动评分");
    } else {
      responseModel = ResponseModel(false, "无法获取自动评分");
    }
    return responseModel;
  }


}
