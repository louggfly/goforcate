import 'package:goforcate_app/models/shop_model.dart';

class PopularShop {
  int? _shopcount;
  late List<ShopModel> _popularShop;

  List<ShopModel> get popularShop => _popularShop;

  PopularShop({required shopcount, required popularShop}) {
    this._shopcount = shopcount;
    this._popularShop = popularShop;
  }

  PopularShop.fromJson(Map<String, dynamic> json) {
    _shopcount = json['shopcount'];
    if (json['popular_shops'] != null) {
      _popularShop = <ShopModel>[];
      json['popular_shops'].forEach((v) {
        _popularShop!.add(new ShopModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['shopcount'] = this._shopcount;
    if (this._popularShop != null) {
      data['popular_shops'] =
          this._popularShop!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
