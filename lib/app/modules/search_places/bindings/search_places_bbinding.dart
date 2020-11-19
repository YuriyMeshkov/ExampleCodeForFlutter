import 'package:example_code_for_flutter/app/modules/search_places/controllers/search_places_controller.dart';
import 'package:example_code_for_flutter/app/modules/search_places/data/repository_place_search_history.dart';
import 'package:get/get.dart';

class SearchPlacesBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut(() => SearchPlacesController(RepositorySearchHistoryImpl()));
  }

}