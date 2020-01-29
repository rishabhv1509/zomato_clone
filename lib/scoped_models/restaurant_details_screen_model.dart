import 'dart:convert';

import 'package:http/http.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:zomato_clone/models/restaurant_details_model.dart';
import 'package:zomato_clone/services/api_calls.dart';

class RestaurantDetailsScreenModel extends Model {
  // int count = 0;
  increment(int count) {
    count++;
    notifyListeners();
    // return count;
  }

  decrement(int count) {
    if (count > 0) {
      count--;
      notifyListeners();
    } else {
      count = count;
      notifyListeners();
    }
    // return count;
  }

  RestaurantDetailsModel details;
  ApiCalls apiCalls = ApiCalls();
  getRestaurantDetails(int id) async {
    Response response = await apiCalls.getRestaurantDetails(id);
    details = RestaurantDetailsModel.fromJson(json.decode(response.body));
    notifyListeners();
  }
}

RestaurantDetailsScreenModel detailsScreenModel =
    RestaurantDetailsScreenModel();
