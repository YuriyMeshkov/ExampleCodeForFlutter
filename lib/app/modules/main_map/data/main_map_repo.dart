import 'package:example_code_for_flutter/app/modules/main_map/api_google/locations.dart';
import 'package:example_code_for_flutter/app/modules/main_map/api_google/search_route_api.dart';
import 'package:example_code_for_flutter/app/modules/main_map/utils/json_parse.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class GoogleMapRepo {
  getMyPosition();
  getRoutes(Map<String, dynamic> queryParameter);
}

class GoogleMapRepoImpl implements GoogleMapRepo {

  Locations _locations = Locations();
  SearchRouteApi _searchRouteApi = SearchRouteApi();

  @override
  Future<LatLng> getMyPosition() async  {
    var result = await _locations.getLocation();
    return result;
  }

  @override
  Future<List<List<LatLng>>> getRoutes(Map<String, dynamic> queryParameter) async {
    String result = await _searchRouteApi.getRoute(queryParameter);
    if (result != null) {
      return JsonParse().parse(result);
    } else {
      return null;
    }
  }
}
