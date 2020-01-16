import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:zomato_clone/models/users.dart';
import 'package:zomato_clone/scoped_models/home_screen_model.dart';
import 'package:zomato_clone/screens/home_screen/widgets/drawer.dart';
import 'package:zomato_clone/screens/home_screen/widgets/resturant_cards.dart';
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
                  title: Text('Zomtao Clone'),
                ),
                body: Container(
                  padding: EdgeInsets.all(05 * ThemesData.heightRatio),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: ListView.builder(
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
              );
            }),
          );
  }
}
