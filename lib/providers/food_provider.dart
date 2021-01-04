import 'dart:convert';

import 'package:case_study_leanscale/models/food.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FoodProvider with ChangeNotifier {
  List<Food> _foodList;
  List<Food> _drinkList = List<Food>();
  List<Food> _meatList = List<Food>();
  List<Food> _fruitList = List<Food>();
  List<Food> _fullCourseList = List<Food>();
  List<Food> _vegetableList = List<Food>();

  List<Food> get foodList => _foodList;
  List<Food> get meatList => _meatList;
  List<Food> get vegetableList => _vegetableList;
  List<Food> get fullCourseList => _fullCourseList;
  List<Food> get fruitList => _fruitList;
  List<Food> get drinkList => _drinkList;

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

  Future<List<Food>> getFoodList() async {
    String source = await rootBundle.loadString('lib/mock/mockdata.json');
    List<Food> res =
        jsonDecode(source).map<Food>((item) => Food.fromJson(item)).toList();
    _foodList = res;
    return res;
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

  Future<void> setFavList() async {
    final prefs = await SharedPreferences.getInstance();
  }
}
