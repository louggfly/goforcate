import 'package:get/get.dart';

import '../data/repository/notice_repo.dart';
import '../models/notice_list.dart';
import '../models/response_model.dart';

class NoticeController extends GetxController {
  final NoticeRepo noticeRepo;

  NoticeController({required this.noticeRepo});

  List<dynamic> _noticeList = [];

  List<dynamic> get noticeList => _noticeList;

  Future<ResponseModel> getNoticeList() async {
    Response response = await noticeRepo.getNoticeList();
    late ResponseModel responseModel;
    print(response.statusCode);
    if (response.statusCode == 200) {
      print("got noticelist");
      _noticeList = [];
      _noticeList.addAll(NoticeList.fromJson(response.body).notices);
      update();
      responseModel = ResponseModel(true, "成功获取通知列表");
    } else {
      responseModel = ResponseModel(false, "无法获取通知列表");
    }
    return responseModel;
  }
}
