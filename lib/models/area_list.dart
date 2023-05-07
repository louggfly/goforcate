import 'area_model.dart';

class AreaList {
  int? _areacount;
  late List<AreaModel> _areas;

  List<AreaModel> get areas => _areas;

  AreaList({required shopcount, required shops}) {
    this._areacount = shopcount;
    this._areas = shops;
  }

  AreaList.fromJson(Map<String, dynamic> json) {
    _areacount = json['areacount'];
    if (json['areas'] != null) {
      _areas = <AreaModel>[];
      json['areas'].forEach((v) {
        _areas!.add(new AreaModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['areacount'] = this._areacount;
    if (this._areas != null) {
      data['areas'] = this._areas!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
