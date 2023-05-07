class ShopModel {
  int? id;
  String? name;
  String? coverPic;
  String? address;
  String? phone;
  int? comments;
  double? grade;
  String? price;
  String? opentime;
  String? shareLink;
  String? keyword;
  int? areaId;
  int? categoryId;
  String? time;

  ShopModel(
      {required this.id,
      required this.name,
      required this.coverPic,
      required this.address,
      required this.phone,
      required this.comments,
      required this.grade,
      required this.price,
      required this.opentime,
      required this.shareLink,
      required this.keyword,
      required this.areaId,
      required this.categoryId,
      required this.time});

  factory ShopModel.fromJson(Map<String, dynamic> json) {
    return ShopModel(
        id: json['id'],
        name: json['name'],
        coverPic: json['cover_pic'],
        address: json['address'],
        phone: json['phone'],
        comments: json['comments'],
        grade: json['grade'],
        price: json['price'],
        opentime: json['opentime'],
        shareLink: json['share_link'],
        keyword: json['keyword'],
        areaId: json['area_id'],
        categoryId: json['category_id'],
        time: json['time']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['cover_pic'] = this.coverPic;
    data['address'] = this.address;
    data['phone'] = this.phone;
    data['comments'] = this.comments;
    data['grade'] = this.grade;
    data['price'] = this.price;
    data['opentime'] = this.opentime;
    data['share_link'] = this.shareLink;
    data['keyword'] = this.keyword;
    data['area_id'] = this.areaId;
    data['category_id'] = this.categoryId;
    data['time'] = this.time;
    return data;
  }
}
