import 'package:example_code_for_flutter/app/modules/search_places/data/model/place_search_history.dart';
import 'package:example_code_for_flutter/app/modules/search_places/data/repository_place_search_history.dart';
import 'package:get/get.dart';

class SearchPlacesController extends GetxController {

  final RepositorySearchHistory _repo;
  final textSearch = "".obs;
  final placesHistory = List<PlaceSearchHistory>().obs;

  SearchPlacesController(this._repo);

  @override
  void onInit() {
    debounce(textSearch, (value) => _listPlacesSearch(value), time: Duration(milliseconds: 500));
  }

  void initListPlaceHistory() async {
    var places = await _repo.initListPlaceHistory();
    //placesHistory.clear();
    placesHistory.addAll(places);
    update();
  }

  Future<void> _listPlacesSearch(String namePlaces) async {
    placesHistory.clear();
    var places = await _repo.searchNewPlace(namePlaces);
    placesHistory.addAll(places);
    update();
  }

  void writeToDatabase(PlaceSearchHistory place) {
    if(!place.history) {
      _repo.insertPlaceSearchToDatabase(place);
    }
    Get.back(result: place);
  }

  void backToPreviousScreenWithoutPlace() {
    Get.back();
  }

  @override
  void onReady() {}

  @override
  void onClose() {}
}