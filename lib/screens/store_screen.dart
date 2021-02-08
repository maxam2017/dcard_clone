import 'package:dcard_clone/components/bottom_navigator.dart';
import 'package:flutter/material.dart';

class StoreScreen extends StatelessWidget {
  static String routeName = "/store";

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Goods Clone'),
        ),
        body: Column(
          children: [],
        ),
        bottomNavigationBar: BottomNavigator(
          activeRotueName: '/store',
        ));
  }
}
