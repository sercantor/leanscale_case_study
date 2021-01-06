import 'package:cached_network_image/cached_network_image.dart';
import 'package:case_study_leanscale/providers/basket_provider.dart';
import 'package:case_study_leanscale/providers/food_provider.dart';
import 'package:case_study_leanscale/screens/detail_screen.dart';
import 'package:case_study_leanscale/services/db/localdb.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DrinkScreen extends StatelessWidget {
  static const route = '/drink';
  final localDB = LocalDBService();

  @override
  Widget build(BuildContext context) {
    final foodProvider = Provider.of<FoodProvider>(context);
    final basketProvider = Provider.of<BasketProvider>(context, listen: false);
    return Container(
      child: foodProvider.drinkList != null
          ? ListView.builder(
              itemBuilder: (context, index) =>
                  buildListTile(foodProvider, index, basketProvider, context),
              itemCount: foodProvider.drinkList.length,
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Widget buildListTile(FoodProvider foodProvider, int index,
      BasketProvider basketProvider, BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20.0),
      child: ListTile(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  DetailScreen(food: foodProvider.drinkList[index])));
        },
        leading: CachedNetworkImage(
          imageUrl: foodProvider.drinkList[index].imageURL,
          placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        title: Text(foodProvider.drinkList[index].name),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            FlatButton(
              child: Icon(Icons.add),
              onPressed: () {
                basketProvider.addToBasket(foodProvider.drinkList[index]);
              },
            ),
            FlatButton(
              child: ValueListenableBuilder(
                valueListenable: localDB.favBox.listenable(),
                builder: (context, box, widget) {
                  return Icon(
                    Icons.favorite,
                    color: box.get(foodProvider.drinkList[index].name) == true
                        ? Colors.red
                        : Colors.grey,
                  );
                },
              ),
              onPressed: () {
                foodProvider.toggleFav(foodProvider.drinkList[index], index);
              },
            )
          ],
        ),
      ),
    );
  }
}
