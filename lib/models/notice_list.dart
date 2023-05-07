import 'notice_model.dart';

class NoticeList {
  int? _noticecount;
  late List<NoticeModel> _notices;

  List<NoticeModel> get notices => _notices;

  NoticeList({required noticecount, required notices}) {
    this._noticecount = noticecount;
    this._notices = notices;
  }

  NoticeList.fromJson(Map<String, dynamic> json) {
    _noticecount = json['noticecount'];
    if (json['notices'] != null) {
      _notices = <NoticeModel>[];
      json['notices'].forEach((v) {
        _notices!.add(new NoticeModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['noticecount'] = this._noticecount;
    if (this._notices != null) {
      data['notices'] = this._notices!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
