import 'package:case_study_leanscale/models/food.dart';
import 'package:case_study_leanscale/providers/basket_provider.dart';
import 'package:case_study_leanscale/providers/food_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FullCourseScreen extends StatefulWidget {
  static const route = '/fullcourse';

  @override
  _FullCourseScreenState createState() => _FullCourseScreenState();
}

class _FullCourseScreenState extends State<FullCourseScreen> {
  @override
  Widget build(BuildContext context) {
    final foodProvider = Provider.of<FoodProvider>(context);
    final basketProvider = Provider.of<BasketProvider>(context, listen: false);
    return Container(
      child: foodProvider.foodList != null
          ? ListView.builder(
              itemBuilder: (context, index) => ListTile(
                title: Text(foodProvider.foodList[index].name),
                trailing: FlatButton(
                  child: Icon(Icons.add),
                  onPressed: () {
                    //TODO: add to basket
                    basketProvider.addToBasket(
                        foodProvider.foodList[index], index);
                  },
                ),
              ),
              itemCount: foodProvider.foodList.length,
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
