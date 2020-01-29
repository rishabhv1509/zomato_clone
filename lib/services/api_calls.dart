import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class ApiCalls {
  String zomatoApiKey = 'e5964034a6f69322e3ccefb373ec72a6';
  Future<http.Response> getRestaurantList(String location) async {
    try {
      String url =
          'https://developers.zomato.com/api/v2.1/search?entity_id=$location&entity_type=city';
      http.Response restaurantList =
          await http.get(url, headers: {'user-key': zomatoApiKey});

      return restaurantList;
    } on SocketException {
      throw SocketException('message');
    }
  }

  Future<http.Response> getRestaurantDetails(int id) async {
    try {
      String url =
          'https://developers.zomato.com/api/v2.1/restaurant?res_id=$id';
      http.Response restaurantDetails =
          await http.get(url, headers: {'user-key': zomatoApiKey});
      return restaurantDetails;
    } catch (error) {
      return error;
    }
  }

  Future<http.Response> getTrendingRestaurants(String location) async {
    try {
      String getIdUrl =
          'https://developers.zomato.com/api/v2.1/cities?q=$location';

      http.Response locationId =
          await http.get(getIdUrl, headers: {'user-key': zomatoApiKey});
      var tempId = json.decode(locationId.body);
      int id = tempId['location_suggestions'][0]['id'];
      String url =
          'https://developers.zomato.com/api/v2.1/collections?city_id=$id';

      http.Response trendingRestaurants =
          await http.get(url, headers: {'user-key': zomatoApiKey});

      return trendingRestaurants;
    } catch (error) {
      return error;
    }
  }
}
