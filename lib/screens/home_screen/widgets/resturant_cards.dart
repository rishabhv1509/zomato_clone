import 'package:flutter/material.dart';
import 'package:zomato_clone/models/restaurant_list.dart';
import 'package:zomato_clone/screens/restaurant_details.dart';
import 'package:zomato_clone/utils/themes/themes_data.dart';

class ResturantCards extends StatelessWidget {
  final Restaurant restaurant;
  ResturantCards(this.restaurant);

  @override
  Widget build(BuildContext context) {
    int ratingColorValue =
        int.parse('0xff${restaurant.userRating.ratingColor}');
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RestaurantDetails(
              id: int.parse(restaurant.id),
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 5.0, right: 5, top: 3, bottom: 3),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
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
                      Radius.circular(10),
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
                              padding:
                                  EdgeInsets.only(left: 10, top: 3, bottom: 3),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.transparent),
                              color: Color(ratingColorValue),
                              borderRadius: BorderRadius.all(
                                Radius.circular(3),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                restaurant.userRating.aggregateRating,
                                textAlign: TextAlign.center,
                                style: ThemesData.restaurantRatingStyle(),
                              ),
                            ),
                            padding: EdgeInsets.all(4),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              padding:
                                  EdgeInsets.only(left: 10, top: 3, bottom: 3),
                              child: Text(restaurant.cuisines),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            child: Text(
                                '${restaurant.currency} ${restaurant.averageCostForTwo.toString()} per person'),
                            padding:
                                EdgeInsets.only(left: 10, top: 3, bottom: 3),
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
}
