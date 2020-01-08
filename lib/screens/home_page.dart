import 'package:flutter/material.dart';
import 'package:zomato_clone/services/get_location.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    LocationService().getLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Zomato Clone'),
      ),
      body: Container(
        padding: EdgeInsets.all(20), child:Column(children: <Widget>[Container()],),
      ),
    );
  }
}
