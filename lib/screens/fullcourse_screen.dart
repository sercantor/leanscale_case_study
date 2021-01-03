import 'package:cached_network_image/cached_network_image.dart';
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
                leading: CachedNetworkImage(
                  imageUrl: foodProvider.foodList[index].imageURL,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
                title: Text(foodProvider.foodList[index].name),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FlatButton(
                      child: Icon(Icons.add),
                      onPressed: () {
                        basketProvider.addToBasket(
                            foodProvider.foodList[index], index);
                      },
                    ),
                    FlatButton(
                      child: Icon(
                        Icons.favorite,
                        color:
                            foodProvider.foodList[index].isFavourited == false
                                ? Colors.black
                                : Colors.red,
                      ),
                      onPressed: () {
                        foodProvider.toggleFav(
                            foodProvider.foodList[index], index);
                      },
                    )
                  ],
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
