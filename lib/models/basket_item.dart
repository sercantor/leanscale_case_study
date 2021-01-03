import 'package:case_study_leanscale/models/food.dart';

class BasketItem {
  Food food;
  int quantity;

  BasketItem({
    this.food,
    this.quantity,
  });

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is BasketItem && o.food == food && o.quantity == quantity;
  }

  @override
  int get hashCode => food.hashCode ^ quantity.hashCode;
}
