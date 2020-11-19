
import 'package:example_code_for_flutter/app/modules/main_map/controllers/main_map_controller.dart';
import 'package:example_code_for_flutter/app/modules/main_map/views/search_for_places_btn.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../Constans.dart';
import 'direction_btn.dart';




class MainMapView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          OurMap(),
          Container(
            margin: EdgeInsets.only(
                left: 8, top: 8 + Get.mediaQuery.padding.top, right: 8),
            width: double.infinity,
            child: Column(
              children: [
                SearchForPlacesButton(),
                MainMapTape(),
              ],
            ),
          ),

          Align(
            alignment: Alignment.bottomLeft,
            child: DirectionButton(),
          ),
        ],
      ),
    );
  }
}

class OurMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainMapController>(
      builder: (controller) {
        return GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(48.95, -106.77),
            zoom: 3,
          ),
          onMapCreated: (GoogleMapController mapController) {
            controller.initGoogleMapController(mapController);
            controller.getMyPosition();
          },
          markers: controller.markers,
          mapType: controller.mapType,
          polylines: controller.polyLines,
        );
      },
    );
  }
}

class MainMapTape extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainMapController>(
      builder: (controller) {
        return Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16.0, right: 8.0),
              child: Align(
                alignment: Alignment.topRight,
                child: Container(
                  width: 36,
                  height: 36,
                  child: FloatingActionButton(
                    onPressed: () => controller.stateMapTape(),
                    materialTapTargetSize: MaterialTapTargetSize.padded,
                    backgroundColor: Colors.white,
                    child: const Icon(
                      Icons.layers,
                      color: colorSingOrange,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
