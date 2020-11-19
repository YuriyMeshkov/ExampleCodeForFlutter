import 'package:example_code_for_flutter/app/modules/search_places/data/model/place_search_history.dart';
import 'package:flutter/services.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class SearchManger {
  lookingNewPlaceOnMap(String nameNewPlace);
  getDataPlace(Address element);
  requestForRoute(LatLng start, LatLng end);
}

class ManagerForGoogleImpl implements SearchManger {

  @override
  Future<List<PlaceSearchHistory>> lookingNewPlaceOnMap(String nameNewPlace) async {
    List<PlaceSearchHistory> placesSearch = List<PlaceSearchHistory>();
    List<Address> places;
    try {
      places = await Geocoder.local.findAddressesFromQuery(nameNewPlace);
    } on PlatformException {}
    //places = await Geolocator().placemarkFromAddress(nameNewPlace);
    if(places != null) {
      places.forEach((element) {
        placesSearch.add(getDataPlace(element));
      });
    }
    return placesSearch;
  }

  @override
  PlaceSearchHistory getDataPlace(Address element) {
    var placeSearch = PlaceSearchHistory();
    placeSearch.namePlace = element.featureName;
    if(element.countryName != null) {
      placeSearch.addressPlace = element.countryName;
      if(element.adminArea != null) {
        placeSearch.addressPlace = placeSearch.addressPlace + ", " +
            element.adminArea;
      } else if (element.subAdminArea != null) {
        placeSearch.addressPlace = placeSearch.addressPlace + ", " +
            element.subAdminArea;
      }
    } else if(element.adminArea != null) {
      placeSearch.addressPlace = element.adminArea;
    } else if(element.subAdminArea != null) {
      placeSearch.addressPlace = element.subAdminArea;
    }
    placeSearch.latPlace = element.coordinates.latitude;
    placeSearch.lngPlace = element.coordinates.longitude;
    return placeSearch;
  }

  @override
  Future<String> requestForRoute(LatLng start, LatLng end) {
    // TODO: implement requestForRoute
    throw UnimplementedError();
  }

}
