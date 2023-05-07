import 'category_model.dart';

class PreferenceList {
  int? _preferencecount;
  late List<CategoryModel> _preferences;

  List<CategoryModel> get preferences => _preferences;

  PreferenceList({required preferencecount, required preferences}) {
    this._preferencecount = preferencecount;
    this._preferences = preferences;
  }

  PreferenceList.fromJson(Map<String, dynamic> json) {
    _preferencecount = json['preferencecount'];
    if (json['preferences'] != null) {
      _preferences = <CategoryModel>[];
      json['preferences'].forEach((v) {
        _preferences!.add(new CategoryModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['preferencecount'] = this._preferencecount;
    if (this._preferences != null) {
      data['preferences'] = this._preferences!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
