import 'package:case_study_leanscale/models/food.dart';
import 'package:hive/hive.dart';

class LocalDBService {
  final Box<bool> favBox = Hive.box<bool>('favBox');

  bool isFav(Food food) {
    if (favBox.get(food.name) == true) {
      return true;
    } else {
      return false;
    }
  }

  void setFav(Food food) {
    bool res = isFav(food);
    favBox.put(food.name, !res);
  }
}
