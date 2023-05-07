class NoticeModel {
  int? id;
  int? admin_id;
  String? title;
  String? content;
  String? time;

  NoticeModel(
      {required this.id,
      required this.admin_id,
      required this.title,
      required this.content,required this.time});

  factory NoticeModel.fromJson(Map<String, dynamic> json) {
    return NoticeModel(
        id: json['id'],
        admin_id: json['admin_id'],
        title: json['title'],
        content: json['content'],
        time: json['time']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['admin_id'] = this.admin_id;
    data['title'] = this.title;
    data['content'] = this.content;
    data['time'] = this.time;
    return data;
  }
}
