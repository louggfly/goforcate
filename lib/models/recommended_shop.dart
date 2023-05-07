import 'package:goforcate_app/models/shop_model.dart';

class RecommendedShop {
  int? _shopcount;
  late List<ShopModel> _recommendedShop;

  List<ShopModel> get recommendedShop => _recommendedShop;

  RecommendedShop({required shopcount, required recommendedShop}) {
    this._shopcount = shopcount;
    this._recommendedShop = recommendedShop;
  }

  RecommendedShop.fromJson(Map<String, dynamic> json) {
    _shopcount = json['shopcount'];
    if (json['recommended_shops'] != null) {
      _recommendedShop = <ShopModel>[];
      json['recommended_shops'].forEach((v) {
        _recommendedShop!.add(new ShopModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['shopcount'] = this._shopcount;
    if (this._recommendedShop != null) {
      data['recommended_shops'] =
          this._recommendedShop!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
