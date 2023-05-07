class SignUpBody {
  String name;
  String phone;
  String password;

  SignUpBody({required this.name, required this.phone, required this.password});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["name"] = this.name;
    data["phone"] = this.phone;
    data["password"] = this.password;
    return data;
  }
}
