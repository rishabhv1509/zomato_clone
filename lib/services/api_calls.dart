import 'package:http/http.dart' as http;

class ApiCalls {
  String zomatoApiKey = 'e5964034a6f69322e3ccefb373ec72a6';
  getResturantlist(String location) async {
    String url = 'https://developers.zomato.com/api/v2.1/search?entity_id=';
    var restaurantList =
        await http.get(url + location, headers: {'user-key': zomatoApiKey});
    print('resturant list======>${restaurantList.toString()}');
    return restaurantList;
  }
}
