import 'package:cached_network_image/cached_network_image.dart';
import 'package:case_study_leanscale/models/food.dart';
import 'package:case_study_leanscale/providers/basket_provider.dart';
import 'package:case_study_leanscale/providers/food_provider.dart';
import 'package:case_study_leanscale/screens/detail_screen.dart';
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
      child: foodProvider.fullCourseList != null
          ? ListView.builder(
              itemBuilder: (context, index) =>
                  buildListTile(foodProvider, index, basketProvider),
              itemCount: foodProvider.fullCourseList.length,
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  ListTile buildListTile(
      FoodProvider foodProvider, int index, BasketProvider basketProvider) {
    return ListTile(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                DetailScreen(food: foodProvider.fullCourseList[index])));
      },
      leading: CachedNetworkImage(
        imageUrl: foodProvider.fullCourseList[index].imageURL,
        placeholder: (context, url) => CircularProgressIndicator(),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
      title: Text(foodProvider.fullCourseList[index].name),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FlatButton(
            child: Icon(Icons.add),
            onPressed: () {
              basketProvider.addToBasket(
                  foodProvider.fullCourseList[index], index);
            },
          ),
          FlatButton(
            child: Icon(
              Icons.favorite,
              color: foodProvider.fullCourseList[index].isFavourited == false
                  ? Colors.black
                  : Colors.red,
            ),
            onPressed: () {
              foodProvider.toggleFav(foodProvider.fullCourseList[index], index);
            },
          )
        ],
      ),
    );
  }
}
