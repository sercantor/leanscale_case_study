import 'package:case_study_leanscale/models/food.dart';
import 'package:case_study_leanscale/providers/basket_provider.dart';
import 'package:case_study_leanscale/providers/food_provider.dart';
import 'package:case_study_leanscale/providers/navigation_provider.dart';
import 'package:case_study_leanscale/screens/init_screen.dart';
import 'package:case_study_leanscale/screens/root.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  await Hive.openBox<bool>('favBox');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
        ChangeNotifierProvider(create: (_) => FoodProvider()),
        ChangeNotifierProvider(create: (_) => BasketProvider()),
      ],
      child: Builder(
        builder: (context) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            onGenerateRoute: NavigationProvider.of(context).onGenerateRoute,
            home: InitScreen(),
          );
        },
      ),
    );
  }
}
