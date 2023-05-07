class UserBody {
  String username;
  int gender;
  String introduction;

  UserBody(
      {required this.username,
      required this.gender,
      required this.introduction});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["username"] = this.username;
    data["gender"] = this.gender;
    data["introduction"] = this.introduction;
    return data;
  }
}
