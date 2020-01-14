import 'package:scoped_model/scoped_model.dart';
import 'package:zomato_clone/services/api_calls.dart';
import 'package:zomato_clone/services/get_location.dart';
import 'package:http/http.dart' as http;

class HomeScreenModel extends Model {
  LocationService locationService = LocationService();
  ApiCalls apiCalls = ApiCalls();
  String zomatoApiKey = 'e5964034a6f69322e3ccefb373ec72a6';
  String currentLocation;
  var response;
  getCurrentLocation() async {
    currentLocation = await locationService.getLocation();
    print(currentLocation);
    notifyListeners();
  }

  getrestaurantListFromApi(String location) async {
    response = await apiCalls.getResturantlist(location);
    notifyListeners();
  }
}
