import 'package:dcard_clone/components/bottom_navigator.dart';
import 'package:dcard_clone/components/post_list.dart';
import 'package:dcard_clone/providers/post_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = "/home";

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Dcard Clone'),
        ),
        body: ChangeNotifierProvider(
          create: (context) => PostProvider(),
          child: PostList(),
        ),
        bottomNavigationBar: BottomNavigator(
          activeRotueName: '/home',
        ));
  }
}
