import 'package:cached_network_image/cached_network_image.dart';
import 'package:case_study_leanscale/models/food.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final Food food;
  DetailScreen({Key key, this.food}) : super(key: key);

  static const route = '/detail';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
              child: Container(
                padding: EdgeInsets.all(20.0),
                child: Card(
                  child: Column(
                    children: [
                      food.isFavourited == true
                          ? Align(
                              alignment: Alignment.topRight,
                              child: Icon(Icons.favorite, color: Colors.red),
                            )
                          : Container(),
                      Text(
                        food.name,
                        style: TextStyle(fontSize: 25.0),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      CachedNetworkImage(
                        imageUrl: food.imageURL,
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Text(
                        'Price: ${food.price.toString()}',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      Text(
                        'Stock: ${food.quantity.toString()}',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0)),
                ),
              ),
            ),
            FlatButton(
              child: Text('Go Back'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      ),
    );
  }
}
