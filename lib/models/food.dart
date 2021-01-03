import 'dart:convert';

import 'package:uuid/uuid.dart';

var _uuid = Uuid();

class Food {
  final String id;
  final String name;
  final int quantity;
  final String category;
  final int price;
  final bool isFavourited;
  final String imageURL;

  Food(
      {this.name,
      this.quantity,
      this.category,
      this.price,
      this.imageURL,
      String id,
      this.isFavourited})
      : id = id ?? _uuid.v4();

  Food.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        quantity = json['quantity'],
        imageURL = json['imageURL'],
        category = json['category'],
        isFavourited = json['is_favourited'],
        price = json['price'];

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Food &&
        o.id == id &&
        o.name == name &&
        o.quantity == quantity &&
        o.category == category &&
        o.price == price &&
        o.isFavourited == isFavourited &&
        o.imageURL == imageURL;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        quantity.hashCode ^
        category.hashCode ^
        price.hashCode ^
        isFavourited.hashCode ^
        imageURL.hashCode;
  }

  @override
  String toString() {
    return 'Food(id: $id, name: $name, quantity: $quantity, category: $category, price: $price, isFavourited: $isFavourited, imageURL: $imageURL)';
  }
}
