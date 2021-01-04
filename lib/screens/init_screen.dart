import 'package:case_study_leanscale/providers/food_provider.dart';
import 'package:case_study_leanscale/screens/root.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InitScreen extends StatefulWidget {
  @override
  _InitScreenState createState() => _InitScreenState();
}

//I want to make sure my provider has initialized the foodList

class _InitScreenState extends State<InitScreen> {
  @override
  void initState() {
    onStart();
    super.initState();
  }

  Future<void> onStart() async {
    await Provider.of<FoodProvider>(context, listen: false).getFoodList();
    await Provider.of<FoodProvider>(context, listen: false).categorize();
    await Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => Root()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
