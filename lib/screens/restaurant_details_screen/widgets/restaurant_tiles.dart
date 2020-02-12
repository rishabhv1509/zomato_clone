import 'package:flutter/material.dart';

class RestaurantTiles extends StatelessWidget {
  final String image;
  final String itemName;
  final String itemPrice;
  final Function increment;
  final Function decrement;
  final int quantity;
  RestaurantTiles(
      {Key key,
      this.image,
      this.itemName,
      this.itemPrice,
      this.quantity,
      this.decrement,
      this.increment})
      : super(key: key);

  int count = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        leading: (image == null)
            ? Container(
                height: 0,
                width: 0,
              )
            : Container(
                height: 80,
                width: 80,
                child: Image.asset((image)),
              ),
        title: Text(itemName),
        subtitle: Text(itemPrice),
        trailing: Container(
          width: 90,
          height: 30,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    decrement();
                  },
                  child: Icon(
                    Icons.remove,
                    size: 10,
                  ),
                ),
                VerticalDivider(),
                Text(quantity.toString(),
                    style: TextStyle(fontSize: 10, color: Colors.red)),
                VerticalDivider(),
                GestureDetector(
                    onTap: () {
                      increment();
                      // print('========?${/}');
                    },
                    child: Icon(
                      Icons.add,
                      size: 10,
                      color: Colors.black,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
