import 'category_model.dart';

class CategoryList {
  int? _categorycount;
  late List<CategoryModel> _categories;

  List<CategoryModel> get categories => _categories;

  AreaList({required categorycount, required categories}) {
    this._categorycount = categorycount;
    this._categories = categories;
  }

  CategoryList.fromJson(Map<String, dynamic> json) {
    _categorycount = json['categorycount'];
    if (json['categories'] != null) {
      _categories = <CategoryModel>[];
      json['categories'].forEach((v) {
        _categories!.add(new CategoryModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categorycount'] = this._categorycount;
    if (this._categories != null) {
      data['categories'] = this._categories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
