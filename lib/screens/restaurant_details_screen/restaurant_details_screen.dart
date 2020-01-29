import 'dart:math';
import 'package:flutter/material.dart';
import 'package:zomato_clone/models/restaurant_list.dart';
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
  final _random = new Random();
  int temp = 0;

  int next(int min, int max) => min + _random.nextInt(max - min);

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
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.white),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15)),
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
                                style: ThemesData.restaurantNameStyle(),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                widget.restaurant.cuisines,
                                style: ThemesData.restaurantCuisineStyle(),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(17)),
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
                                                bottom:
                                                    8 * ThemesData.heightRatio),
                                            child: Text(
                                              widget.restaurant.userRating
                                                  .aggregateRating,
                                              style: ThemesData
                                                  .restaurantRatingStyle(),
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
                                                top: 5 * ThemesData.heightRatio,
                                                bottom:
                                                    2 * ThemesData.heightRatio),
                                            child: Text(
                                              widget.restaurant.allReviewsCount
                                                  .toString(),
                                              style: ThemesData
                                                  .restaurantReviewCountStyle(),
                                            ),
                                          ),
                                          Text(
                                            AppStrings.REVIEW,
                                            style: ThemesData
                                                .restaurantReviewTextStyle(),
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
                          int rand = next(1, 10);
                          return RestaurantTiles(
                            image: 'assets/item$rand.jpeg',
                            itemName: 'Item ${index + 1}',
                            itemPrice:
                                '${widget.restaurant.currency} ${30 * rand}',
                            total: 0,
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
