import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class JsonParse {

  List<List<LatLng>> parse(String response) {
    List<List<LatLng>> routes = List();
    var parseJson = json.decode(response);
    if (parseJson['routes'] != null) {
      var jRoutes = parseJson['routes'] as List;
      jRoutes.forEach((element) {
        var jLegs = element['legs'] as List;
        List<LatLng> route = List();
        jLegs.forEach((elementLegs) {
          var jSteps = elementLegs['steps'] as List;
          jSteps.forEach((elementSteps) {
            String polyLine = '';
            polyLine = elementSteps['polyline']['points'];
            List<LatLng> list = _decodePoly(polyLine);
            list.forEach((elementPoints) {
              Map<String, String> map = Map();
              LatLng point = LatLng(elementPoints.latitude, elementPoints.longitude);
              map['lat'] = elementPoints.latitude.toString();
              map['lng'] = elementPoints.longitude.toString();
              route.add(point);
            });
          });
          routes.add(route);
        });
      });
    }
    return routes;
  }

  List<LatLng> _decodePoly(String encoded) {
    List<LatLng> poly = List();
    int index = 0;
    int len = encoded.length;
    int lat = 0;
    int lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dLat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dLat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dLng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dLng;

      LatLng p = LatLng((lat / 1E5).toDouble(), (lng / 1E5).toDouble());
      poly.add(p);
    }
    return poly;
  }
}