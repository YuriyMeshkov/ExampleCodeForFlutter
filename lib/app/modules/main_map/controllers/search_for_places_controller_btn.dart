import 'package:example_code_for_flutter/app/modules/search_places/data/model/place_search_history.dart';
import 'package:example_code_for_flutter/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'main_map_controller.dart';

class SearchForPlacesController extends GetxController {

  final isFinalDestinationEstablished = false.obs;
  final destinationName = "Search".obs;
  MainMapController mapController = Get.find();

  void stateButtonDestination(bool state) {
    isFinalDestinationEstablished.value = state;
    update();
  }

  void settingTextToWidget(String text) {
    if (isFinalDestinationEstablished.value) {
      destinationName.value = text;
    } else {
      destinationName.value = "Search";
    }
    update();
  }

  void goToNewScreen() async {
    var place = await Get.toNamed(Routes.SEARCH_PLACES);
    if (place is PlaceSearchHistory && PlaceSearchHistory != null) {
      var position = LatLng(place.latPlace, place.lngPlace);
      stateButtonDestination(true);
      settingTextToWidget('${place.namePlace}, ${place.addressPlace}');
      mapController.isShowDirectionButton.value = true;
      mapController.showMarker(position);
      mapController.destination = position;
    }
  }

  void clearTextDestination() {
    stateButtonDestination(false);
    settingTextToWidget("Search");
    mapController.polyLines.clear();
    mapController.startPosition = null;
    mapController.isShowDirectionButton.value = false;
    mapController.getMyPosition();
  }


  @override
  void onInit() {}

  @override
  void onReady() {}

  @override
  void onClose() {}
}