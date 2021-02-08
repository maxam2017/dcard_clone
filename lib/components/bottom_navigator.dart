import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dcard_clone/routes.dart';

final routeNameList = routes.keys.toList();

class BottomNavigator extends StatelessWidget {
  const BottomNavigator({
    Key key,
    @required this.activeRotueName,
  }) : super(key: key);

  final String activeRotueName;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: routeNameList.indexOf(activeRotueName),
      showSelectedLabels: false,
      showUnselectedLabels: false,
      onTap: (int index) {
        String name = routeNameList[index];
        if (activeRotueName == name) return;
        Navigator.pushReplacementNamed(context, name);
      },
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('home')),
        BottomNavigationBarItem(icon: Icon(Icons.store), title: Text('store')),
      ],
    );
  }
}
