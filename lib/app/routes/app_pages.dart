
import 'package:example_code_for_flutter/app/modules/main_map/bindings/main_map_binding.dart';
import 'package:example_code_for_flutter/app/modules/main_map/views/main_map_view.dart';
import 'package:example_code_for_flutter/app/modules/search_places/bindings/search_places_bbinding.dart';
import 'package:example_code_for_flutter/app/modules/search_places/views/search_places_view.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages extends GetxController{

  static const MAIN_MAP = Routes.MAIN_MAP;
  static const SEARCH_PLACES = Routes.SEARCH_PLACES;


  static final routes = [
    GetPage(
      name: Routes.MAIN_MAP, 
      page:()=> MainMapView(), 
      binding: MainMapBinding(),
    ),
    GetPage(
        name: Routes.SEARCH_PLACES,
        page: () => SearchPlacesView(),
        binding: SearchPlacesBinding(),
    )
  ];
}