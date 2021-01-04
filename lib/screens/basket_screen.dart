import 'package:cached_network_image/cached_network_image.dart';
import 'package:case_study_leanscale/providers/basket_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BasketScreen extends StatelessWidget {
  static const String route = '/basket';

  @override
  Widget build(BuildContext context) {
    final basketProvider = Provider.of<BasketProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [Icon(Icons.shopping_basket), Text(' Cart')],
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemBuilder: (context, index) => buildListTile(basketProvider, index),
          itemCount: basketProvider.basket.length),
    );
  }

  Widget buildListTile(BasketProvider basketProvider, int index) {
    return Container(
      padding: EdgeInsets.only(top: 20.0),
      child: ListTile(
        leading: CachedNetworkImage(
          imageUrl: basketProvider.basket[index].food.imageURL,
          placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        title: Text(basketProvider.basket[index].food.name),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            FlatButton(
              child: Text('Remove from cart'),
              onPressed: () => basketProvider.removeFromBasket(
                  basketProvider.basket[index].food, index),
            ),
            Text(basketProvider.basket[index].quantity.toString()),
          ],
        ),
      ),
    );
  }
}
