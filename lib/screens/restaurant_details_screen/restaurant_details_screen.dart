// import 'dart:js';

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zomato_clone/models/restaurant_list.dart';
import 'package:zomato_clone/scoped_models/restaurant_details_screen_model.dart';
import 'package:zomato_clone/screens/restaurant_details_screen/widgets/restaurant_tiles.dart';
import 'package:zomato_clone/utils/constants/strings.dart';
import 'package:zomato_clone/utils/themes/themes_data.dart';

class RestaurantDetailsScreen extends StatefulWidget {
  final Restaurant restaurant;

  RestaurantDetailsScreen({Key key, this.restaurant}) : super(key: key);

  @override
  _RestaurantDetailsState createState() => _RestaurantDetailsState();
}

class _RestaurantDetailsState extends State<RestaurantDetailsScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int total = 0;
  bool didGenerateList = false;
  @override
  void initState() {
    print('in init');

    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!didGenerateList) {
      didGenerateList = true;

      Provider.of<RestaurantDetailsScreenModel>(context).generateList();
    }
  }

  @override
  Widget build(BuildContext context) {
    int co = int.parse('0xff${widget.restaurant.userRating.ratingColor}');
    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            Container(
              height: ThemesData.height / 4,
              width: ThemesData.width,
              child: Image.network(
                widget.restaurant.thumb,
                fit: BoxFit.fitWidth,
              ),
            ),
            Expanded(
                child: Container(
              color: Colors.white,
            ))
          ],
        ),
        Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.white),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: Stack(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
                child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(10 * ThemesData.heightRatio),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    widget.restaurant.name,
                                    // style: ThemesData.restaurantNameStyle(),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    widget.restaurant.cuisines,
                                    // style: ThemesData.restaurantCuisineStyle(),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(17)),
                              child: Container(
                                child: Card(
                                  elevation: 5,
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: <Widget>[
                                          Container(
                                            width: 47 * ThemesData.widthRatio,
                                            color: Color(co),
                                            child: Center(
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    top: 5.0 *
                                                        ThemesData.heightRatio,
                                                    bottom: 8 *
                                                        ThemesData.heightRatio),
                                                child: Text(
                                                  widget.restaurant.userRating
                                                      .aggregateRating,
                                                  // style: ThemesData
                                                  //     .restaurantRatingStyle(),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Column(
                                            children: <Widget>[
                                              Container(
                                                margin: EdgeInsets.only(
                                                    top: 5 *
                                                        ThemesData.heightRatio,
                                                    bottom: 2 *
                                                        ThemesData.heightRatio),
                                                child: Text(
                                                  widget.restaurant
                                                      .allReviewsCount
                                                      .toString(),
                                                  // style: ThemesData
                                                  //   //     .restaurantReviewCountStyle(),
                                                ),
                                              ),
                                              Text(
                                                AppStrings.REVIEW,
                                                // style: ThemesData
                                                //     .restaurantReviewTextStyle(),
                                              )
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: 10,
                            itemBuilder: (context, index) {
                              return Consumer<RestaurantDetailsScreenModel>(
                                builder: (BuildContext context,
                                    RestaurantDetailsScreenModel value,
                                    Widget child) {
                                  return RestaurantTiles(
                                    image:
                                        '${value.itemList[index]['image']}.jpeg',
                                    itemName:
                                        '${value.itemList[index]['item']}',
                                    itemPrice:
                                        '${value.itemList[index]['price']}',
                                    quantity: value.itemQuantity[index],
                                    decrement: () {
                                      value.decrement(index,
                                          '${value.itemList[index]['price']}');
                                    },
                                    increment: () {
                                      value.increment(index,
                                          '${value.itemList[index]['price']}');
                                    },
                                  );
                                },
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Consumer<RestaurantDetailsScreenModel>(
                builder: (BuildContext context,
                    RestaurantDetailsScreenModel value, Widget child) {
                  return AnimatedCrossFade(
                    duration: Duration(milliseconds: 150),
                    crossFadeState: (value.total > 0)
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
                    firstChild: Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(10),
                              height: 70,
                              child: RaisedButton(
                                  highlightColor: Colors.white60,
                                  color: Colors.amber[500],
                                  onPressed: () {
                                    int count = 0;
                                    value.itemQuantity.forEach((f) {
                                      if (f > 0) {
                                        count++;
                                      }
                                    });
                                    _scaffoldKey.currentState.showBottomSheet(
                                        (context) => Consumer<
                                                RestaurantDetailsScreenModel>(
                                              builder:
                                                  (context, value, child) =>
                                                      BackdropFilter(
                                                filter: ImageFilter.blur(
                                                    sigmaX: 2, sigmaY: 2),
                                                child: Container(
                                                  height:
                                                      ThemesData.height / 1.5,
                                                  child: Column(
                                                    children: <Widget>[
                                                      Row(
                                                        children: <Widget>[
                                                          Expanded(
                                                            child: Container(
                                                              height: 80,
                                                              color:
                                                                  Colors.blue,
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(10),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: <
                                                                    Widget>[
                                                                  Text(
                                                                    AppStrings
                                                                        .DELIVERY_AT,
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            12),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 5,
                                                                  ),
                                                                  Text(
                                                                    'hello',
                                                                    // khomeScreenModel
                                                                    //     .currentLocation,
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            13,
                                                                        fontWeight:
                                                                            FontWeight.w700),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 5,
                                                                  ),
                                                                  Text(
                                                                    'Delivery in 30 minutes',
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          11,
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Expanded(
                                                        child: ListView(
                                                          children: <Widget>[
                                                            ListView.builder(
                                                              shrinkWrap: true,
                                                              physics:
                                                                  ClampingScrollPhysics(),
                                                              itemCount: count,
                                                              itemBuilder:
                                                                  (BuildContext
                                                                          context,
                                                                      index) {
                                                                return RestaurantTiles(
                                                                  image:
                                                                      '${value.itemList[index]['image']}.jpeg',
                                                                  itemName:
                                                                      '${value.itemList[index]['item']}',
                                                                  itemPrice:
                                                                      '${value.itemList[index]['price']}',
                                                                  quantity: value
                                                                          .itemQuantity[
                                                                      index],
                                                                  decrement:
                                                                      () {
                                                                    value.decrement(
                                                                        index,
                                                                        '${value.itemList[index]['price']}');
                                                                    // notifyListeners();
                                                                  },
                                                                  increment:
                                                                      () {
                                                                    value.increment(
                                                                        index,
                                                                        '${value.itemList[index]['price']}');
                                                                    // notifyListeners();
                                                                  },
                                                                );
                                                              },
                                                            ),
                                                            Text(
                                                                'datajjgtrdrtgdfgc')
                                                          ],
                                                        ),
                                                      ),
                                                      Text('data')
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                        elevation: 5);
                                  },
                                  child: Consumer<RestaurantDetailsScreenModel>(
                                    builder: (BuildContext context,
                                        RestaurantDetailsScreenModel value,
                                        Widget child) {
                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.all(5.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                (value.totalQuantity > 1)
                                                    ? Text(
                                                        '${value.totalQuantity.toString()} ITEMS',
                                                        style: ThemesData
                                                            .orderModalSheetQuantityStyle(),
                                                      )
                                                    : Text(
                                                        '${value.totalQuantity.toString()} ITEM',
                                                        style: ThemesData
                                                            .orderModalSheetQuantityStyle(),
                                                      ),
                                                Text(
                                                  'Rs ${value.total}',
                                                  style: ThemesData
                                                      .orderModalSheetPriceStyle(),
                                                )
                                              ],
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                              Text(
                                                AppStrings.VIEW_CART,
                                                style: ThemesData
                                                    .orderModalSheetPriceStyle(),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Icon(
                                                Icons.send,
                                                size: 15,
                                                color: Colors.white,
                                              )
                                            ],
                                          )
                                        ],
                                      );
                                    },
                                  )),
                            ),
                          )
                        ],
                      ),
                    ),
                    secondChild: Container(),
                  );
                  // builder: (BuildContext context, RestaurantDetailsScreenModel value, Widget child) {},
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
