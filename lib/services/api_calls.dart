import 'package:http/http.dart' as http;

class ApiCalls {
  String zomatoApiKey = 'e5964034a6f69322e3ccefb373ec72a6';
  Future<http.Response> getResturantlist(String location) async {
    try {
      String url =
          'https://developers.zomato.com/api/v2.1/search?entity_id=$location&entity_type=city';
      var restaurantList =
          await http.get(url, headers: {'user-key': zomatoApiKey});
      return restaurantList;
    } catch (error) {
      return error;
    }
  }

  Future<http.Response> getReastaurantDetails(int id) async {
    try {
      String url =
          'https://developers.zomato.com/api/v2.1/restaurant?res_id=$id';
      var restaurantDetails =
          await http.get(url, headers: {'user-key': zomatoApiKey});
      return restaurantDetails;
    } catch (error) {
      return error;
    }
  }
}
