import 'dart:convert';

import 'package:case_study_leanscale/models/food.dart';
import 'package:case_study_leanscale/services/db/localdb.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class FoodProvider with ChangeNotifier {
  List<Food> _foodList;
  List<Food> _drinkList = List<Food>();
  List<Food> _meatList = List<Food>();
  List<Food> _fruitList = List<Food>();
  List<Food> _fullCourseList = List<Food>();
  List<Food> _vegetableList = List<Food>();
  LocalDBService _localDB = LocalDBService();

  List<Food> get foodList => _foodList;
  List<Food> get meatList => _meatList;
  List<Food> get vegetableList => _vegetableList;
  List<Food> get fullCourseList => _fullCourseList;
  List<Food> get fruitList => _fruitList;
  List<Food> get drinkList => _drinkList;

  void toggleFav(Food val, int index) {
    print(_localDB.isFav(val));
    switch (val.category) {
      case 'Vegetable':
        _localDB.setFav(_vegetableList[index]);
        break;
      case 'Meat':
        _localDB.setFav(_meatList[index]);
        break;
      case 'Fruit':
        _localDB.setFav(_fruitList[index]);
        break;
      case 'Drink':
        _localDB.setFav(_drinkList[index]);
        break;
      case 'FullCourse':
        _localDB.setFav(_fullCourseList[index]);
        break;
      default:
        break;
    }

    notifyListeners();
  }

  Future<void> getFoodList() async {
    String source = await rootBundle.loadString('lib/mock/mockdata.json');
    List<Food> res =
        jsonDecode(source).map<Food>((item) => Food.fromJson(item)).toList();
    _foodList = res;
  }

  void categorize() async {
    _foodList.forEach((food) {
      switch (food.category) {
        case 'Vegetable':
          _vegetableList.add(food);
          break;
        case 'Meat':
          _meatList.add(food);
          break;
        case 'Fruit':
          _fruitList.add(food);
          break;
        case 'Drink':
          _drinkList.add(food);
          break;
        case 'FullCourse':
          _fullCourseList.add(food);
          break;
        default:
          break;
      }
    });
    notifyListeners();
  }
}
