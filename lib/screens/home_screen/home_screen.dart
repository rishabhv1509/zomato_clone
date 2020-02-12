import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zomato_clone/models/users.dart';
import 'package:zomato_clone/scoped_models/home_screen_model.dart';
import 'package:zomato_clone/scoped_models/restaurant_details_screen_model.dart';
import 'package:zomato_clone/screens/home_screen/widgets/drawer.dart';
import 'package:zomato_clone/screens/home_screen/widgets/resturant_cards.dart';
import 'package:zomato_clone/utils/constants/strings.dart';
import 'package:zomato_clone/utils/themes/themes_data.dart';

class HomeScreen extends StatefulWidget {
  final Users user;
  final String location;
  HomeScreen({Key key, this.user, this.location}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var subscription;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((c) {
      HomeScreenModel model = Provider.of<HomeScreenModel>(context);

      model.getCurrentLocation();
      model.getCurrentUser();
      model.getrestaurantListFromApi();
      model.getTrendingListFromApi();
    });
    // init();
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      print('result====>$result');
      // await init();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Consumer<HomeScreenModel>(
          builder: (BuildContext context, HomeScreenModel value, Widget child) {
            return HomeScreenDrawer(
              user: value.user,
            );
          },
        ),
        appBar: AppBar(
          title: Text(AppStrings.APP_NAME),
        ),
        body: Consumer2<HomeScreenModel, RestaurantDetailsScreenModel>(
            builder: (BuildContext context, value, model, Widget child) {
          return RefreshIndicator(
            // key: _refreshIndicatorKey,
            onRefresh: () async {
              // await init();
            },
            child: (value.isInternet)
                ? (value.isLoading ||
                        value.restaurantList == null ||
                        value.restaurantList.restaurants.length == 0 ||
                        value.trendingRestaurantList == null ||
                        value.trendingRestaurantList.collections.length == 0)
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView(
                        physics: ClampingScrollPhysics(),
                        children: <Widget>[
                          Container(
                            padding:
                                EdgeInsets.all(10 * ThemesData.heightRatio),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    AppStrings.HOME_SCREEN_HEADING,
                                    // style:
                                    //     ThemesData.homeScreenHeadingStyle(),
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
                                          itemCount: value
                                              .trendingRestaurantList
                                              .collections
                                              .length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Container(
                                              padding: EdgeInsets.only(
                                                  left: 10 *
                                                      ThemesData.widthRatio,
                                                  right: 10 *
                                                      ThemesData.widthRatio),
                                              margin: EdgeInsets.only(
                                                  left: 10 *
                                                      ThemesData.widthRatio,
                                                  right: 10 *
                                                      ThemesData.widthRatio),
                                              width: 110,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.transparent),
                                                image: DecorationImage(
                                                  fit: BoxFit.fill,
                                                  image: NetworkImage(value
                                                      .trendingRestaurantList
                                                      .collections[index]
                                                      .collection
                                                      .imageUrl),
                                                ),
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(10 *
                                                      ThemesData.widthRatio),
                                                ),
                                              ),
                                            );
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
                                    'Restaurants in ${value.currentLocation}',
                                    // style:
                                    //     ThemesData.homeScreenHeadingStyle(),
                                  ),
                                ),
                                SizedBox(
                                  height: 20 * ThemesData.heightRatio,
                                ),
                                Flexible(
                                  fit: FlexFit.loose,
                                  child: ListView.builder(
                                    physics: ClampingScrollPhysics(),
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: (value.restaurantList.restaurants
                                                .length ==
                                            0)
                                        ? 1
                                        : value
                                            .restaurantList.restaurants.length,
                                    itemBuilder: (BuildContext context, index) {
                                      return ChangeNotifierProxyProvider<
                                          RestaurantDetailsScreenModel,
                                          HomeScreenModel>(
                                        create: (c) => HomeScreenModel(),
                                        child: ResturantCards(
                                            Provider.of<HomeScreenModel>(
                                                    context)
                                                .restaurantList
                                                .restaurants[index]
                                                .restaurant),
                                        update: (BuildContext context,
                                            RestaurantDetailsScreenModel value,
                                            HomeScreenModel previous) {
                                          return previous;
                                        },
                                      );
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      )
                : Column(
                    children: <Widget>[
                      Expanded(
                        child: Image.asset('assets/snap.png'),
                      ),
                    ],
                  ),
          );
        }));

    // : Scaffold(
    //     body: ,
    //   );
    // });
  }
}
