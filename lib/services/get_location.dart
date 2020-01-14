import 'package:geolocator/geolocator.dart';

class LocationService {
  Future<String> getLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemark = await Geolocator()
        .placemarkFromCoordinates(position.latitude, position.longitude);
    return placemark[0].locality;
  }
}
