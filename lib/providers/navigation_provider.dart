import 'package:case_study_leanscale/models/screen.dart';
import 'package:case_study_leanscale/screens/detail_screen.dart';
import 'package:case_study_leanscale/screens/drink_screen.dart';
import 'package:case_study_leanscale/screens/fullcourse_screen.dart';
import 'package:case_study_leanscale/screens/fruit_screen.dart';
import 'package:case_study_leanscale/screens/meat_screen.dart';
import 'package:case_study_leanscale/screens/root.dart';
import 'package:case_study_leanscale/screens/vegetable_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const FULLCOURSE_SCREEN = 0;
const VEGETABLE_SCREEN = 1;
const MEAT_SCREEN = 2;
const FRUIT_SCREEN = 3;
const DRINK_SCREEN = 4;

class NavigationProvider with ChangeNotifier {
  static NavigationProvider of(BuildContext context) =>
      Provider.of<NavigationProvider>(context, listen: false);

  int _currentScreenIndex = FULLCOURSE_SCREEN;

  final Map<int, Screen> _screens = {
    FULLCOURSE_SCREEN: Screen(
      label: 'Full Course',
      child: FullCourseScreen(),
      initialRoute: FullCourseScreen.route,
      navigatorState: GlobalKey<NavigatorState>(),
      onGenerateRoute: (settings) {
        print('Generating route: ${settings.name}');
        switch (settings.name) {
          case DetailScreen.route:
            return MaterialPageRoute(builder: (_) => DetailScreen());
          default:
            return MaterialPageRoute(builder: (_) => FullCourseScreen());
        }
      },
      scrollController: ScrollController(),
    ),
    VEGETABLE_SCREEN: Screen(
      label: 'Vegetables',
      child: VegetableScreen(),
      initialRoute: VegetableScreen.route,
      navigatorState: GlobalKey<NavigatorState>(),
      onGenerateRoute: (settings) {
        print('Generating route: ${settings.name}');
        switch (settings.name) {
          default:
            return MaterialPageRoute(builder: (_) => VegetableScreen());
        }
      },
      scrollController: ScrollController(),
    ),
    MEAT_SCREEN: Screen(
      label: 'Meats',
      child: MeatScreen(),
      initialRoute: MeatScreen.route,
      navigatorState: GlobalKey<NavigatorState>(),
      onGenerateRoute: (settings) {
        print('Generating route: ${settings.name}');
        switch (settings.name) {
          default:
            return MaterialPageRoute(builder: (_) => MeatScreen());
        }
      },
      scrollController: ScrollController(),
    ),
    FRUIT_SCREEN: Screen(
      label: 'Fruits',
      child: FruitScreen(),
      initialRoute: FruitScreen.route,
      navigatorState: GlobalKey<NavigatorState>(),
      onGenerateRoute: (settings) {
        print('Generating route: ${settings.name}');
        switch (settings.name) {
          default:
            return MaterialPageRoute(builder: (_) => FruitScreen());
        }
      },
      scrollController: ScrollController(),
    ),
    DRINK_SCREEN: Screen(
      label: 'Drinks',
      child: DrinkScreen(),
      initialRoute: DrinkScreen.route,
      navigatorState: GlobalKey<NavigatorState>(),
      onGenerateRoute: (settings) {
        print('Generating route: ${settings.name}');
        switch (settings.name) {
          default:
            return MaterialPageRoute(builder: (_) => DrinkScreen());
        }
      },
      scrollController: ScrollController(),
    ),
  };

  int get currentTabIndex => _currentScreenIndex;
  List<Screen> get screens => _screens.values.toList();
  Screen get currentScreen => _screens[_currentScreenIndex];

  void setTab(int tab) {
    if (tab == currentTabIndex) {
      _scrollToStart();
    } else {
      _currentScreenIndex = tab;
      notifyListeners();
    }
  }

  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    print('Generating route: ${settings.name}');
    switch (settings.name) {
      // We can push another screen  here, like settings
      case DetailScreen.route:
        return MaterialPageRoute(builder: (_) => DetailScreen());
      case MeatScreen.route:
        return MaterialPageRoute(builder: (_) => MeatScreen());
      case FullCourseScreen.route:
        return MaterialPageRoute(builder: (_) => FullCourseScreen());
      case FruitScreen.route:
        return MaterialPageRoute(builder: (_) => FruitScreen());
      case VegetableScreen.route:
        return MaterialPageRoute(builder: (_) => VegetableScreen());
      case DrinkScreen.route:
        return MaterialPageRoute(builder: (_) => DrinkScreen());
      default:
        return MaterialPageRoute(builder: (_) => Root());
    }
  }

  Future<bool> onWillPop(BuildContext context) async {
    final currentNavigatorState = currentScreen.navigatorState.currentState;

    if (currentNavigatorState.canPop()) {
      currentNavigatorState.pop();
      return false;
    } else {
      if (currentTabIndex != FULLCOURSE_SCREEN) {
        setTab(FULLCOURSE_SCREEN);
        notifyListeners();
        return false;
      } else {
        return await showDialog(
          context: context,
          //TODO: implement onWillPop
          builder: (context) => Text('asd'),
        );
      }
    }
  }

  void _scrollToStart() async {
    if (currentScreen.scrollController != null &&
        currentScreen.scrollController.hasClients) {
      await currentScreen.scrollController.animateTo(
        0.0,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 300),
      );
    }
  }
}
