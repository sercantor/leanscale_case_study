import 'package:cached_network_image/cached_network_image.dart';
import 'package:case_study_leanscale/providers/basket_provider.dart';
import 'package:case_study_leanscale/providers/food_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrinkScreen extends StatelessWidget {
  static const route = '/drink';

  @override
  Widget build(BuildContext context) {
    final foodProvider = Provider.of<FoodProvider>(context);
    final basketProvider = Provider.of<BasketProvider>(context, listen: false);
    return Container(
      child: foodProvider.drinkList != null
          ? ListView.builder(
              itemBuilder: (context, index) =>
                  buildListTile(foodProvider, index, basketProvider),
              itemCount: foodProvider.drinkList.length,
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  ListTile buildListTile(
      FoodProvider foodProvider, int index, BasketProvider basketProvider) {
    return ListTile(
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
              basketProvider.addToBasket(foodProvider.drinkList[index], index);
            },
          ),
          FlatButton(
            child: Icon(
              Icons.favorite,
              color: foodProvider.drinkList[index].isFavourited == false
                  ? Colors.black
                  : Colors.red,
            ),
            onPressed: () {
              foodProvider.toggleFav(foodProvider.drinkList[index], index);
            },
          )
        ],
      ),
    );
  }
}
