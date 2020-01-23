import 'package:flutter/material.dart';

class RestaurantTiles extends StatefulWidget {
  final String image;
  final String itemName;
  final String itemPrice;
  int total = 0;
  RestaurantTiles(
      {Key key, this.image, this.itemName, this.itemPrice, this.total})
      : super(key: key);

  @override
  _RestaurantTilesState createState() => _RestaurantTilesState();
}

class _RestaurantTilesState extends State<RestaurantTiles> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    print('total======>${widget.total}');
    return Container(
      child: ListTile(
        leading: Container(
          height: 80,
          width: 80,
          child: Image.asset(widget.image),
        ),
        title: Text(widget.itemName),
        subtitle: Text(widget.itemPrice),
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
                    setState(() {
                      if (count > 0) {
                        count--;
                        widget.total = widget.total +
                            (int.parse(widget.itemPrice.substring(3)) * count);
                      } else {
                        count = count;
                        widget.total = widget.total +
                            (int.parse(widget.itemPrice.substring(3)) * count);
                      }
                      print(count);
                    });
                  },
                  child: Icon(
                    Icons.remove,
                    size: 10,
                  ),
                ),
                VerticalDivider(),
                Text(count.toString(), style: TextStyle(fontSize: 10)),
                VerticalDivider(),
                GestureDetector(
                    onTap: () {
                      setState(() {
                        count++;
                        widget.total = widget.total +
                            (int.parse(widget.itemPrice.substring(3)) * count);
                        print(count);
                      });
                    },
                    child: Icon(
                      Icons.add,
                      size: 10,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
