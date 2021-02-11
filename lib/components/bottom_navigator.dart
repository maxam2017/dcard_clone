// refer to https://stackoverflow.com/questions/60515525/

import 'package:dcard_clone/routes.dart';
import 'package:dcard_clone/screens/home_screen.dart';
import 'package:dcard_clone/screens/store_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final routeNameList = routes.keys.toList();

Map<String, Icon> iconMap = {
  HomeScreen.routeName: Icon(Icons.home),
  StoreScreen.routeName: Icon(Icons.store),
};

class BottomNavigationBarController extends StatefulWidget {
  BottomNavigationBarController({Key key}) : super(key: key);

  @override
  _BottomNavigationBarControllerState createState() =>
      _BottomNavigationBarControllerState();
}

class _BottomNavigationBarControllerState
    extends State<BottomNavigationBarController>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  TabController _tabController;
  List<Widget> mainTabs = [];
  List<BottomNavigationBarRootItem> bottomNavigationBarRootItems = [];
  List<BuildContext> navStack = [];

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: routeNameList.length);

    var _index = 0;
    mainTabs = [];
    bottomNavigationBarRootItems = [];
    navStack = List.filled(routeNameList.length, null);

    routes.forEach((key, value) {
      final index = _index;
      mainTabs.add(Navigator(onGenerateRoute: (RouteSettings settings) {
        return PageRouteBuilder(pageBuilder: (context, animiX, animiY) {
          navStack[index] = context;
          return value(context);
        });
      }));

      bottomNavigationBarRootItems.add(BottomNavigationBarRootItem(
        routeName: key,
        // nestedNavigator: navStack[index],
        bottomNavigationBarItem: BottomNavigationBarItem(
          icon: iconMap[key],
          title: Text(key),
        ),
      ));

      _index = _index + 1;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
          body: TabBarView(
            controller: _tabController,
            physics: NeverScrollableScrollPhysics(),
            children: mainTabs,
          ),
          bottomNavigationBar: Container(
            child: BottomNavigationBar(
              showSelectedLabels: false,
              showUnselectedLabels: false,
              items: bottomNavigationBarRootItems
                  .map((e) => e.bottomNavigationBarItem)
                  .toList(),
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
            ),
            decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Colors.black12))),
          )),
      onWillPop: () async {
        if (Navigator.of(navStack[_tabController.index]).canPop()) {
          Navigator.of(navStack[_tabController.index]).pop();
          setState(() {
            _selectedIndex = _tabController.index;
          });
          return false;
        } else {
          if (_tabController.index == 0) {
            setState(() {
              _selectedIndex = _tabController.index;
            });
            SystemChannels.platform
                .invokeMethod('SystemNavigator.pop'); // close the app
            return true;
          } else {
            _tabController.index =
                0; // back to first tap if current tab history stack is empty
            setState(() {
              _selectedIndex = _tabController.index;
            });
            return false;
          }
        }
      },
    );
  }

  void _onItemTapped(int index) {
    _tabController.index = index;
    setState(() => _selectedIndex = index);
  }
}

class BottomNavigationBarRootItem {
  final String routeName;
  final NestedNavigator nestedNavigator;
  final BottomNavigationBarItem bottomNavigationBarItem;

  BottomNavigationBarRootItem({
    @required this.routeName,
    this.nestedNavigator,
    @required this.bottomNavigationBarItem,
  });
}

abstract class NestedNavigator extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  NestedNavigator({Key key, @required this.navigatorKey}) : super(key: key);
}
