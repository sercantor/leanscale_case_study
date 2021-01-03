import 'package:case_study_leanscale/models/basket_item.dart';
import 'package:case_study_leanscale/models/food.dart';
import 'package:flutter/cupertino.dart';

class BasketProvider with ChangeNotifier {
  List<BasketItem> _basket = List<BasketItem>();
  int _basketLength = 0;

  List<BasketItem> get basket => _basket;
  int get basketLength => _basketLength;

  void addToBasket(Food val, int index) {
    if (_basket.every((element) => element.food != val)) {
      _basket.insert(index, BasketItem(food: val, quantity: 1));
    } else {
      _basket[index] =
          BasketItem(food: val, quantity: _basket[index].quantity + 1);
    }
    _basketLength++;
    notifyListeners();
  }

  void removeFromBasket(Food val, int index) {
    if (_basket[index].quantity > 1) {
      _basket[index] =
          BasketItem(food: val, quantity: _basket[index].quantity - 1);
      _basketLength--;
    } else {
      _basket.removeAt(index);
      _basketLength--;
    }
    print(_basket.length);
    notifyListeners();
  }
}
