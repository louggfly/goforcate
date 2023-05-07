import 'package:goforcate_app/models/shop_model.dart';

class ShopList {
  int? _shopcount;
  late List<ShopModel> _shops;

  List<ShopModel> get shops => _shops;

  ShopList({required shopcount, required shops}) {
    this._shopcount = shopcount;
    this._shops = shops;
  }

  ShopList.fromJson(Map<String, dynamic> json) {
    _shopcount = json['shopcount'];
    if (json['shops'] != null) {
      _shops = <ShopModel>[];
      json['shops'].forEach((v) {
        _shops!.add(new ShopModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['shopcount'] = this._shopcount;
    if (this._shops != null) {
      data['shops'] = this._shops!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
