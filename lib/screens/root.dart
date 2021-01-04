import 'package:case_study_leanscale/providers/basket_provider.dart';
import 'package:case_study_leanscale/providers/food_provider.dart';
import 'package:case_study_leanscale/providers/navigation_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

import 'basket_screen.dart';

class Root extends StatelessWidget {
  static const route = '/root';
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) => Consumer<NavigationProvider>(
        builder: (context, navigationProvider, child) {
          final bottomNavigationBarItems = navigationProvider.screens
              .map((screen) => BottomNavigationBarItem(
                  icon: buildBottomNavBarIcons(screen.label),
                  label: screen.label))
              .toList();

          final screens = navigationProvider.screens
              .map(
                (screen) => Navigator(
                  key: screen.navigatorState,
                  onGenerateRoute: screen.onGenerateRoute,
                ),
              )
              .toList();

          return WillPopScope(
            onWillPop: () async => navigationProvider.onWillPop(context),
            child: Scaffold(
              appBar: AppBar(
                actions: [buildBasketIcon(context)],
                title: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [Icon(Icons.food_bank), Text(' LeanScale')],
                ),
                centerTitle: true,
              ),
              body: IndexedStack(
                children: screens,
                index: navigationProvider.currentTabIndex,
              ),
              bottomNavigationBar: BottomNavigationBar(
                items: bottomNavigationBarItems,
                currentIndex: navigationProvider.currentTabIndex,
                onTap: navigationProvider.setTab,
                type: BottomNavigationBarType.fixed,
                showSelectedLabels: false,
                showUnselectedLabels: false,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildBottomNavBarIcons(String label) {
    switch (label) {
      case 'Full Course':
        return Icon(Icons.fastfood);
        break;
      case 'Vegetables':
        return Icon(FontAwesome.leaf);
        break;
      case 'Meats':
        return Icon(FontAwesome.heart);
        break;
      case 'Fruits':
        return Icon(FontAwesome.lemon_o);
        break;
      case 'Drinks':
        return Icon(FontAwesome.beer);
        break;
      default:
        return Text('Not Found');
        break;
    }
  }

  Widget buildBasketIcon(BuildContext context) {
    final basketProvider = Provider.of<BasketProvider>(context);
    return FlatButton(
      child: Stack(
        children: [
          Container(
            child: Icon(
              Icons.shopping_basket,
              size: 40.0,
            ),
          ),
          Container(
            height: 15.0,
            width: 15.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.redAccent,
            ),
            child: Center(
              child: Text(
                basketProvider.basketLength.toString(),
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      onPressed: () => Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => BasketScreen())),
    );
  }
}
