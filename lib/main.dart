import 'package:dcard_clone/providers/index.dart';
import 'package:dcard_clone/routes.dart';
import 'package:dcard_clone/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: providers,
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dcard Demo',
      theme: ThemeData(
        primaryColor: Color(0xFF3397CF),
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
