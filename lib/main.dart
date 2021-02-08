import 'package:dcard_clone/routes.dart';
import 'package:dcard_clone/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dcard Demo',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: Color(0xFF006AA6),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: HomeScreen.routeName,
      routes: routes,
      onGenerateRoute: (RouteSettings settings) {
        final String routeName = settings.name;
        if (routes.keys.toList().indexOf(routeName) == -1) {
          return null;
        }

        return MaterialPageRoute(
            builder: routes[routeName], settings: settings);
      },
      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute(
            builder: (BuildContext context) => HomeScreen());
      },
    );
  }
}
