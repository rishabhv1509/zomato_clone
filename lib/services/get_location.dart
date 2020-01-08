import 'package:geolocator/geolocator.dart';

class LocationService {
  getLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemark = await Geolocator().placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemark[0].postalCode);
  }
}
