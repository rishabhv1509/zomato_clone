import 'package:flutter/material.dart';

class RestaurantDetails extends StatelessWidget {
  final int id;

  RestaurantDetails({Key key, this.id}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(id.toString()),
    );
  }
}
