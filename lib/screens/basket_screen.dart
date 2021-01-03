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
      appBar: AppBar(),
      body: ListView.builder(
          itemBuilder: (context, index) => ListTile(
                leading: CachedNetworkImage(
                  imageUrl: basketProvider.basket[index].food.imageURL,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
                title: Text(basketProvider.basket[index].food.name),
                trailing:
                    Text(basketProvider.basket[index].quantity.toString()),
                onLongPress: () => basketProvider.removeFromBasket(
                    basketProvider.basket[index].food, index),
              ),
          itemCount: basketProvider.basket.length),
    );
  }
}
