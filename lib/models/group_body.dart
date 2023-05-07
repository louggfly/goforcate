class GroupBody {
  int id;
  String name;
  int shopId;
  int leaderId;
  String reserve_at;

  GroupBody(
      {required this.id,
      required this.name,
      required this.shopId,
      required this.leaderId,
      required this.reserve_at});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["name"] = this.name;
    data["shopId"] = this.shopId;
    data["leaderId"] = this.leaderId;
    data["reserve_at"] = this.reserve_at;
    return data;
  }
}
