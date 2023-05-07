import 'package:goforcate_app/models/user_model.dart';

class UserList {
  int? _usercount;
  late List<UserModel> _users;

  List<UserModel> get users => _users;

  ShopList({required usercount, required users}) {
    this._usercount = usercount;
    this._users = users;
  }

  UserList.fromJson(Map<String, dynamic> json) {
    _usercount = json['usercount'];
    if (json['users'] != null) {
      _users = <UserModel>[];
      json['users'].forEach((v) {
        _users!.add(new UserModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['usercount'] = this._usercount;
    if (this._users != null) {
      data['users'] = this._users!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
