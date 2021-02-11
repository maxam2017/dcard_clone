import 'package:dcard_clone/components/post_list.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Dcard Clone'),
            elevation: 0.0,
          ),
          body: Column(
            children: <Widget>[
              Container(
                  height: 44.0,
                  child: Material(
                    child: TabBar(
                      indicatorColor: Color(0xFF006AA6),
                      indicatorSize: TabBarIndicatorSize.label,
                      labelColor: Colors.black87,
                      unselectedLabelColor: Colors.black26,
                      labelStyle:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                      tabs: [
                        Tab(text: '熱門'),
                        Tab(text: '最新'),
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                      border:
                          Border(bottom: BorderSide(color: Colors.black12)))),
              Expanded(
                child: TabBarView(
                  children: [PostList(true), PostList(false)],
                ),
              ),
            ],
          ),
        ));
  }
}
