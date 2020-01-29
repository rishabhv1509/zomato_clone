import 'package:flutter/material.dart';
import 'package:zomato_clone/models/restaurant_list.dart';
import 'package:zomato_clone/screens/restaurant_details_screen/restaurant_details_screen.dart';
import 'package:zomato_clone/utils/constants/route_names.dart';
import 'package:zomato_clone/utils/themes/themes_data.dart';

class ResturantCards extends StatelessWidget {
  final Restaurant restaurant;
  ResturantCards(this.restaurant);

  @override
  Widget build(BuildContext context) {
    int ratingColorValue =
        int.parse('0xff${restaurant.userRating.ratingColor}');
    // print(restaurant.photosUrl);
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, RouteNames.RESTAURANT_DETAILS_SCREEN,
            arguments: restaurant);
      },
      child: Padding(
        padding: EdgeInsets.only(
            left: 5.0 * ThemesData.widthRatio,
            right: 5 * ThemesData.widthRatio,
            top: 3 * ThemesData.heightRatio,
            bottom: 3 * ThemesData.heightRatio),
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(8.0 * ThemesData.heightRatio),
            child: Row(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.transparent),
                    image: DecorationImage(
                      image: NetworkImage(
                        (restaurant.thumb.length > 0)
                            ? restaurant.thumb
                            : 'https://image.shutterstock.com/image-vector/no-image-available-sign-internet-600w-261719003.jpg',
                      ),
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10 * ThemesData.heightRatio),
                    ),
                  ),
                  height: 50 * ThemesData.heightRatio,
                  width: 50 * ThemesData.widthRatio,
                  child: Container(),
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              child: Text(
                                restaurant.name,
                                style: ThemesData.restaurantNameStyle(),
                              ),
                              padding: EdgeInsets.only(
                                  left: 10 * ThemesData.widthRatio,
                                  top: 3 * ThemesData.heightRatio,
                                  bottom: 3 * ThemesData.heightRatio),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.transparent),
                              color: Color(ratingColorValue),
                              borderRadius: BorderRadius.all(
                                Radius.circular(3 * ThemesData.heightRatio),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                restaurant.userRating.aggregateRating,
                                textAlign: TextAlign.center,
                                style: ThemesData.restaurantRatingStyle(),
                              ),
                            ),
                            padding: EdgeInsets.all(4 * ThemesData.heightRatio),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5 * ThemesData.heightRatio,
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: 10 * ThemesData.widthRatio,
                                  top: 3 * ThemesData.heightRatio,
                                  bottom: 3 * ThemesData.heightRatio),
                              child: Text(
                                restaurant.cuisines,
                                style: ThemesData.restaurantCuisineStyle(),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5 * ThemesData.heightRatio,
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            child: Text(
                              '${restaurant.currency} ${restaurant.averageCostForTwo.toString()} per person',
                              style: ThemesData.restaurantCostStyle(),
                            ),
                            padding: EdgeInsets.only(
                                left: 10 * ThemesData.widthRatio,
                                top: 3 * ThemesData.heightRatio,
                                bottom: 3 * ThemesData.heightRatio),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Route navigateToDetails() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          RestaurantDetailsScreen(
        restaurant: restaurant,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 4.0);
        var end = Offset.zero;
        var curve = Curves.fastLinearToSlowEaseIn;
        // easeOutCubic

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
