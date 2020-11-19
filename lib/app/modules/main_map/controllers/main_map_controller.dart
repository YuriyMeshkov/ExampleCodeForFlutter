import 'dart:async';
import 'package:example_code_for_flutter/app/modules/main_map/data/main_map_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../Constans.dart';

class MainMapController extends GetxController {

  final GoogleMapRepo _repo;
  GoogleMapController googleMapController;
  final markers = Set<Marker>().obs;
  MapType mapType = MapType.normal.obs.value;
  final isShowDirectionButton = false.obs;
  LatLng myPosition;
  LatLng startPosition;
  LatLng destination;
  List<LatLng> wayPoints = List();
  final polyLines = Set<Polyline>().obs;

  MainMapController(this._repo);

  void initGoogleMapController(GoogleMapController controller) {
    googleMapController = controller;
  }

  Future<void> getMyPosition() async {
    myPosition = await _repo.getMyPosition();
    showMarker(myPosition);
  }

  Future<void> getRoutes() async {
    isShowDirectionButton.value = false;
    Map<String, dynamic> queryParameter = Map();
    queryParameter['origin'] = '${myPosition.latitude},${myPosition.longitude}';
    queryParameter['destination'] =
        '${destination.latitude},${destination.longitude}';
    if (wayPoints.isNotEmpty) {
      queryParameter['waypoints'] = wayPoints;
    } else {
      queryParameter['waypoints'] = '';
    }
    queryParameter['alternatives'] = 'true';
    queryParameter['sensor'] = 'false';
    queryParameter['mode'] = 'driving';
    queryParameter['key'] = API_KEY_FOR_DESTINATION;
    var routes = await _repo.getRoutes(queryParameter);
    startPosition = myPosition;
    _showRoutes(routes);
  }

  void refreshGoogleMapController(LatLng position) async {
    if (googleMapController != null) {
      googleMapController.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: position, zoom: 9)));
    }
  }

  void showMarker(LatLng position) {
    refreshGoogleMapController(position);
    markers.clear();
    markers.add(Marker(
      markerId: MarkerId("It's me"),
      icon: BitmapDescriptor.defaultMarkerWithHue(350.0),
      position: position,
      infoWindow: InfoWindow(title: "It's me"),
    ));
    update();
  }

  void stateMapTape() {
    mapType = mapType == MapType.normal
        ? MapType.satellite
        : MapType.normal;
    update();
  }

  void _showRoutes(List<List<LatLng>> routes) {
    _showPolyline(routes);
    markers.clear();
    markers.add(Marker(
      markerId: MarkerId("Start"),
      icon: BitmapDescriptor.defaultMarkerWithHue(350.0),
      position: startPosition,
      infoWindow: InfoWindow(title: "Start"),
    ));
    markers.add(Marker(
      markerId: MarkerId("Destination"),
      icon: BitmapDescriptor.defaultMarkerWithHue(350.0),
      position: destination,
      infoWindow: InfoWindow(title: "Destination"),
    ));
    googleMapController.animateCamera(CameraUpdate.newLatLngBounds(
      getBoundsForShowPolyline(markers), 100,
    ));
    update();
  }

  void _showPolyline(List<List<LatLng>> routes) {
    polyLines.clear();
    int numberLine = 1;
    routes.forEach((element) {
      PolylineId id = PolylineId(numberLine.toString());
      Polyline polyline;
      var color = Colors.black;
      switch (numberLine) {
        case 1:
          color = Colors.red;
          break;
        case 2:
          color = Colors.blue;
          break;
        case 3:
          color = Colors.green;
          break;
      }
      polyline = Polyline(
        width: 4,
        polylineId: id,
        color: color,
        points: element,
      );
      polyLines.add(polyline);
      numberLine ++;
      update();
    });
  }

  LatLngBounds  getBoundsForShowPolyline(Set<Marker> markers) {
    double x0 = markers.elementAt(0).position.latitude;
    double x1 = x0;
    double y0 = markers.elementAt(0).position.longitude;
    double y1 = y0;
    markers.forEach((element) {
      if (element.position.latitude > x1) x1 = element.position.latitude;
      if (element.position.latitude < x0) x0 = element.position.latitude;
      if (element.position.longitude > y1) y1 = element.position.longitude;
      if (element.position.longitude < y0) y0 = element.position.longitude;
    });
    return LatLngBounds(northeast: LatLng(x1, y1), southwest: LatLng(x0, y0));
  }

  @override
  void onInit() {}

  @override
  void onReady() {}

  @override
  void onClose() {}

}
