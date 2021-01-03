import 'dart:convert';

import 'package:case_study_leanscale/models/food.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class FoodProvider with ChangeNotifier {
  List<Food> _foodList;
  List<Food> _basket;

  List<Food> get foodList => _foodList;
  List<Food> get basket => _basket;

  void addFoodToBasket(Food val) {
    _basket.add(val);
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

  void removeFoodFromBasket(Food val) {
    _basket.remove(val);
    notifyListeners();
  }
}
