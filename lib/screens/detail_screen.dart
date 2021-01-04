import 'package:case_study_leanscale/models/food.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final Food food;
  DetailScreen({Key key, this.food}) : super(key: key);

  static const route = '/detail';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Card(
          child: Text(food.name),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
        ),
      ),
    );
  }
}
