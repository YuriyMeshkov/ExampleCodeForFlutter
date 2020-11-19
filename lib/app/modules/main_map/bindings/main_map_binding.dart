import 'package:example_code_for_flutter/app/modules/main_map/controllers/main_map_controller.dart';
import 'package:example_code_for_flutter/app/modules/main_map/controllers/search_for_places_controller_btn.dart';
import 'package:example_code_for_flutter/app/modules/main_map/data/main_map_repo.dart';
import 'package:get/get.dart';


class MainMapBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainMapController>(
      () => MainMapController(GoogleMapRepoImpl()),
    );
    Get.lazyPut(() => SearchForPlacesController());
  }
}
