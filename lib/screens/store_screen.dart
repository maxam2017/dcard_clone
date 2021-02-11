import 'package:flutter/material.dart';

class StoreScreen extends StatefulWidget {
  static String routeName = "/store";

  @override
  _StoreScreenState createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Goods Clone'),
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
