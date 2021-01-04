import 'package:cached_network_image/cached_network_image.dart';
import 'package:case_study_leanscale/providers/basket_provider.dart';
import 'package:case_study_leanscale/providers/food_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FruitScreen extends StatelessWidget {
  static const route = '/fruit';
  @override
  Widget build(BuildContext context) {
    final foodProvider = Provider.of<FoodProvider>(context);
    final basketProvider = Provider.of<BasketProvider>(context, listen: false);
    return Container(
      child: foodProvider.fruitList != null
          ? ListView.builder(
              itemBuilder: (context, index) =>
                  buildListTile(foodProvider, index, basketProvider),
              itemCount: foodProvider.fruitList.length,
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
        imageUrl: foodProvider.fruitList[index].imageURL,
        placeholder: (context, url) => CircularProgressIndicator(),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
      title: Text(foodProvider.fruitList[index].name),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FlatButton(
            child: Icon(Icons.add),
            onPressed: () {
              basketProvider.addToBasket(foodProvider.fruitList[index], index);
            },
          ),
          FlatButton(
            child: Icon(
              Icons.favorite,
              color: foodProvider.fruitList[index].isFavourited == false
                  ? Colors.black
                  : Colors.red,
            ),
            onPressed: () {
              foodProvider.toggleFav(foodProvider.fruitList[index], index);
            },
          )
        ],
      ),
    );
  }
}
