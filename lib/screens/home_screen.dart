import 'package:dcard_clone/components/bottom_navigator.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = "/home";

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Dcard Clone'),
        ),
        body: Column(
          children: [],
        ),
        bottomNavigationBar: BottomNavigator(
          activeRotueName: '/home',
        ));
  }
}
