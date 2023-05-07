class UserModel {
  int? id;
  String? username;
  String? avatar;
  String? mobile;
  int? gender;
  String? introduction;
  int? areaId;

  UserModel(
      {required this.id,
      required this.username,
      required this.avatar,
      required this.mobile,
      required this.gender,
      required this.introduction,
      required this.areaId});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      username: json['username'],
      avatar: json['avatar'],
      mobile: json['mobile'],
      gender: json['gender'],
      introduction: json['introduction'],
      areaId: json['area_id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['avatar'] = this.avatar;
    data['mobile'] = this.mobile;
    data['gender'] = this.gender;
    data['introduction'] = this.introduction;
    data['area_id'] = this.areaId;
    return data;
  }
}
