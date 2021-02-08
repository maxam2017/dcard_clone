import 'package:dcard_clone/screens/home_screen.dart';
import 'package:dcard_clone/screens/store_screen.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> routes = {
  HomeScreen.routeName: (context) => HomeScreen(),
  StoreScreen.routeName: (context) => StoreScreen()
};
