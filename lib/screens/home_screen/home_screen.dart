import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:zomato_clone/models/users.dart';
import 'package:zomato_clone/scoped_models/home_screen_model.dart';
import 'package:zomato_clone/screens/home_screen/widgets/drawer.dart';
import 'package:zomato_clone/screens/home_screen/widgets/resturant_cards.dart';
import 'package:zomato_clone/utils/strings.dart';
import 'package:zomato_clone/utils/themes/themes_data.dart';

class HomeScreen extends StatefulWidget {
  final Users user;
  final String location;
  HomeScreen({Key key, this.user, this.location}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = true;
  init() async {
    await homeScreenModel.getCurrentLocation();
    await homeScreenModel
        .getrestaurantListFromApi(homeScreenModel.currentLocation);
    await homeScreenModel.getCurrentUser();
    await homeScreenModel.getTrendingListFromApi();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (isLoading)
        ? Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : ScopedModel<HomeScreenModel>(
            model: homeScreenModel,
            child: ScopedModelDescendant<HomeScreenModel>(
                builder: (context, child, model) {
              return Scaffold(
                drawer: HomeScreenDrawer(
                  user: model.user,
                ),
                appBar: AppBar(
                  title: Text(AppStrings.APP_NAME),
                ),
                body: ListView(
                  physics: ClampingScrollPhysics(),
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(10 * ThemesData.heightRatio),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              AppStrings.HOME_SCREEN_HEADING,
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w900),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 100 * ThemesData.heightRatio,
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: ListView.builder(
                                    physics: ClampingScrollPhysics(),
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: (model.trendingRestaurantList
                                                .collections.length !=
                                            0)
                                        ? model.trendingRestaurantList
                                            .collections.length
                                        : 1,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      if (model.trendingRestaurantList ==
                                          null) {
                                        return CircularProgressIndicator();
                                      } else {
                                        return Container(
                                          padding: EdgeInsets.only(
                                              left: 10 * ThemesData.widthRatio,
                                              right:
                                                  10 * ThemesData.widthRatio),
                                          margin: EdgeInsets.only(
                                              left: 10 * ThemesData.widthRatio,
                                              right:
                                                  10 * ThemesData.widthRatio),
                                          // height: 50,
                                          width: 110,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.transparent),
                                            image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: NetworkImage(model
                                                  .trendingRestaurantList
                                                  .collections[index]
                                                  .collection
                                                  .imageUrl),
                                            ),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                  10 * ThemesData.widthRatio),
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 30 * ThemesData.heightRatio),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Restaurants in ${model.currentLocation}',
                              style: TextStyle(
                                  fontSize: 14 * ThemesData.widthRatio,
                                  fontWeight: FontWeight.w900),
                            ),
                          ),
                          SizedBox(
                            height: 20 * ThemesData.heightRatio,
                          ),
                          Flexible(
                            fit: FlexFit.loose,
                            // flex: 2,
                            child: ListView.builder(
                              physics: ClampingScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount:
                                  (model.restaurantList.restaurants.length != 0)
                                      ? model.restaurantList.restaurants.length
                                      : 1,
                              itemBuilder: (BuildContext context, index) {
                                if (model.restaurantList == null) {
                                  return CircularProgressIndicator();
                                } else {
                                  return ResturantCards(model.restaurantList
                                      .restaurants[index].restaurant);
                                }
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
          );
  }
}
