import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Locations {

  Future<LatLng> getLocation() async {
    Geolocator geolocator = Geolocator()
      ..forceAndroidLocationManager = true;
    Position position = await geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high);
    //Position position = await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    return LatLng(position.latitude, position.longitude);
  }

}