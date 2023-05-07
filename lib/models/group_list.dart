import 'group_model.dart';

class GroupList {
  int? _groupcount;
  late List<GroupModel> _groups;

  List<GroupModel> get groups => _groups;

  GroupList({required groupcount, required groups}) {
    this._groupcount = groupcount;
    this._groups = groups;
  }

  GroupList.fromJson(Map<String, dynamic> json) {
    _groupcount = json['groupcount'];
    if (json['groups'] != null) {
      _groups = <GroupModel>[];
      json['groups'].forEach((v) {
        _groups!.add(new GroupModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['groupcount'] = this._groupcount;
    if (this._groups != null) {
      data['groups'] = this._groups!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
