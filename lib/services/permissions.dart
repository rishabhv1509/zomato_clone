import 'package:geolocator/geolocator.dart';
import 'package:location_permissions/location_permissions.dart';

class Permissions {
  getLocationPermission() async {
    GeolocationStatus geolocationStatus =
        await Geolocator().checkGeolocationPermissionStatus();
    if (geolocationStatus == GeolocationStatus.denied ||
        geolocationStatus == GeolocationStatus.disabled) {
      await LocationPermissions().requestPermissions();
    }
  }
}
