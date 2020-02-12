import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:zomato_clone/models/restaurant_list.dart';
import 'package:zomato_clone/models/restaurant_trending_list.dart';
import 'package:zomato_clone/models/users.dart';
import 'package:zomato_clone/services/api_calls.dart';
import 'package:zomato_clone/services/authentication.dart';
import 'package:zomato_clone/services/get_location.dart';

class HomeScreenModel extends ChangeNotifier {
  LocationService locationService = LocationService();
  AuthenticationService _auth = AuthenticationService();
  ApiCalls apiCalls = ApiCalls();
  String currentLocation;
  Users user;
  RestaurantList restaurantList;
  TrendingRestaurantList trendingRestaurantList;
  bool isInternet = true;
  bool isLoading = false;
  getCurrentLocation() async {
    var checkConnection = await Connectivity().checkConnectivity();
    if (checkConnection == ConnectivityResult.none) {
      isInternet = false;
      notifyListeners();
    } else {
      currentLocation = await locationService.getLocation();
      isInternet = true;
      notifyListeners();
    }
  }

  getrestaurantListFromApi() async {
    isLoading = true;

    try {
      var checkConnection = await Connectivity().checkConnectivity();
      if (checkConnection == ConnectivityResult.none) {
        isInternet = false;
        notifyListeners();
      } else {
        isInternet = true;

        Response response = await apiCalls.getRestaurantList(currentLocation);
        restaurantList = RestaurantList.fromJson(json.decode(response.body));
        // print(restaurantList.restaurants.length);

        notifyListeners();
      }
    } on Exception {}
    isLoading = false;
    notifyListeners();
  }

  getCurrentUser() async {
    FirebaseUser firebaseUser = await _auth.getCurrentUser();
    final CollectionReference usersCollection =
        Firestore.instance.collection('Users');

    var userData = await usersCollection.document(firebaseUser.uid).get();
    user = Users.fromJson(userData.data);
    // print(user.email);
    notifyListeners();
  }

  getTrendingListFromApi() async {
    // isLoading = true;
    try {
      var checkConnection = await Connectivity().checkConnectivity();
      if (checkConnection == ConnectivityResult.none) {
        isInternet = false;

        notifyListeners();
      } else {
        isInternet = true;

        Response response =
            await apiCalls.getTrendingRestaurants(currentLocation);
        trendingRestaurantList =
            TrendingRestaurantList.fromJson(json.decode(response.body));
        // print(trendingRestaurantList.collections);

        notifyListeners();
      }
    } catch (e) {}
    // isLoading = false;
    notifyListeners();
  }
}

// HomeScreenModel khomeScreenModel = HomeScreenModel();
