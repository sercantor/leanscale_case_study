import 'package:case_study_leanscale/providers/navigation_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Root extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navigationProvider = Provider.of<NavigationProvider>(context);
    return WillPopScope(
      onWillPop: () async => navigationProvider.onWillPop(context),
      child: Scaffold(
        body: Container(),
        appBar: AppBar(),
      ),
    );
  }
}
