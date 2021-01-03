import 'package:case_study_leanscale/providers/navigation_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Root extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navigationProvider = Provider.of<NavigationProvider>(context);
    return Builder(
      builder: (BuildContext context) => Consumer<NavigationProvider>(
        builder: (context, navigationProvider, child) {
          final bottomNavigationBarItems = navigationProvider.screens
              .map((screen) => BottomNavigationBarItem(
                  icon: Icon(Icons.ac_unit), label: screen.label))
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
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
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
}
