import 'package:bin_yousuf_driver/core/models/models/category_model.dart';
import 'package:flutter/cupertino.dart';

class HomeScreenViewModel extends ChangeNotifier {
  List<CategoryModel> categoriesWithSubCategories = [];
  List<CategoryModel> items20Kg = [];
  List<CategoryModel> items5Kg = [];
  List<CategoryModel> items2_5Kg = [];

  void assignWeightCategories() {
    List<CategoryModel> categoriesWithSubCategories = categories
        .where((category) => category.subCategory.isNotEmpty)
        .toList();

    List<CategoryModel> categoriesWith20KgItems = categoriesWithSubCategories
        .where((category) =>
            category.items.any((item) => item['weight'] == '25kg'))
        .toList();
    items20Kg = categoriesWith20KgItems;

    List<CategoryModel> categoriesWith5KgItems = categoriesWithSubCategories
        .where(
            (category) => category.items.any((item) => item['weight'] == '5kg'))
        .toList();
    items5Kg = categoriesWith5KgItems;
    List<CategoryModel> categoriesWith2_5KgItems = categoriesWithSubCategories
        .where((category) =>
            category.items.any((item) => item['weight'] == '2.5kg'))
        .toList();
    items2_5Kg = categoriesWith2_5KgItems;
    notifyListeners();
  }
}
