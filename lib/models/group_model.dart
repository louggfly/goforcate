class GroupModel {
  int? id;
  String? name;
  int? shop_id;
  int? leader_id;
  String? reserve_at;

  GroupModel(
      {required this.id,
      required this.name,
      required this.shop_id,
      required this.leader_id,
      required this.reserve_at});

  factory GroupModel.fromJson(Map<String, dynamic> json) {
    return GroupModel(
      id: json['id'],
      name: json['name'],
      shop_id: json['shop_id'],
      leader_id: json['leader_id'],
      reserve_at: json['reserve_at'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['shop_id'] = this.shop_id;
    data['leader_id'] = this.leader_id;
    data['reserve_at'] = this.reserve_at;
    return data;
  }
}
