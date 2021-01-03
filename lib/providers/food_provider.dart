import 'dart:convert';

import 'package:case_study_leanscale/models/food.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FoodProvider with ChangeNotifier {
  List<Food> _foodList;

  List<Food> get foodList => _foodList;

  void toggleFav(Food val, int index) {
    _foodList[index] = Food(
        category: val.category,
        id: val.id,
        imageURL: val.imageURL,
        isFavourited: !val.isFavourited,
        name: val.name,
        price: val.price,
        quantity: val.quantity);
    notifyListeners();
  }

  Future<void> getFoodList() async {
    String source = await rootBundle.loadString('lib/mock/mockdata.json');
    List<Food> res =
        jsonDecode(source).map<Food>((item) => Food.fromJson(item)).toList();
    _foodList = res;
    print(res);
    notifyListeners();
  }

  Future<void> setFavList() async {
    final prefs = await SharedPreferences.getInstance();
  }
}
