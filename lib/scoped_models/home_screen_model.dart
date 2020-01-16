import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:zomato_clone/models/restaurant_list.dart';
import 'package:zomato_clone/models/users.dart';
import 'package:zomato_clone/services/api_calls.dart';
import 'package:zomato_clone/services/authentication.dart';
import 'package:zomato_clone/services/get_location.dart';

class HomeScreenModel extends Model {
  LocationService locationService = LocationService();
  AuthenticationService _auth = AuthenticationService();
  ApiCalls apiCalls = ApiCalls();
  String currentLocation;
  Response response;
  Users user;
  getCurrentLocation() async {
    currentLocation = await locationService.getLocation();
    print(currentLocation);
    notifyListeners();
  }

  RestaurantList restaurantList;
  getrestaurantListFromApi(String location) async {
    response = await apiCalls.getResturantlist(location);
    restaurantList = RestaurantList.fromJson(json.decode(response.body));
    notifyListeners();
  }

  getCurrentUser() async {
    FirebaseUser firebaseUser = await _auth.getCurrentUser();
    final CollectionReference usersCollection =
        Firestore.instance.collection('Users');
    var userData = await usersCollection.document(firebaseUser.uid).get();
    user = Users.fromJson(userData.data);
    notifyListeners();
  }
  // updateUserDetails()async{
  //   FirebaseUser firebaseUser = await _auth.getCurrentUser();
  //   final CollectionReference usersCollection =
  //       Firestore.instance.collection('Users');
  //       await usersCollection.document(firebaseUser.uid).updateData(data)
  // }
}

HomeScreenModel homeScreenModel = HomeScreenModel();
