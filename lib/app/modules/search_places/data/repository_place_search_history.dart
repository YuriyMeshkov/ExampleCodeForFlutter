import 'package:example_code_for_flutter/app/modules/search_places/api_google/map_location_manager.dart';
import 'package:example_code_for_flutter/app/modules/search_places/storage/database/db_provider.dart';

import 'model/place_search_history.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

abstract class RepositorySearchHistory {
  insertPlaceSearchToDatabase(PlaceSearchHistory place);
  getPlacesSearchHistoryFromDatabase();
  initListPlaceHistory();
  searchNewPlace(String nameNewPlace);
}

class RepositorySearchHistoryImpl implements RepositorySearchHistory {

  var _dataSourceDatabase = DBProvider.db;
  var _tableName = DBProvider.PLACES_TABLE_NAME;
  var _dataSourceGoogle = ManagerForGoogleImpl();
  List<PlaceSearchHistory> _places = List();

  @override
  Future<void> insertPlaceSearchToDatabase(PlaceSearchHistory place) async{
    final Database database = await _dataSourceDatabase.database;
    for(int i = 0 ; i < _places.length ; i++) {
      if(_places[i].namePlace == place.namePlace &&
          _places[i].addressPlace == place.addressPlace) {
        return;
      }
    }
    place.history = true;
    _places.add(place);
    _sortPlaces(_places);
    await database.insert(
        _tableName,
        place.placeToMap(),
        conflictAlgorithm: ConflictAlgorithm.replace
    );
  }

  @override
  Future<List<PlaceSearchHistory>> getPlacesSearchHistoryFromDatabase() async {
    final Database database = await _dataSourceDatabase.database;
    final List<Map<String, dynamic>> places = await database.query(_tableName);
    return List.generate(places.length, (index) {
      return PlaceSearchHistory(
          namePlace: places[index]["nameplace"],
          addressPlace: places[index]["addressplace"],
          latPlace: places[index]["lat"],
          lngPlace: places[index]["lng"],
          history: true
      );
    });
  }

  @override
  Future<List<PlaceSearchHistory>> initListPlaceHistory() async {
    _places = await getPlacesSearchHistoryFromDatabase();
    if(_places.length > 10) {
      var placesInit = List<PlaceSearchHistory>();
      for(int i = _places.length - 1; i >_places.length - 11; i --) {
        placesInit.add(_places[i]);
      }
      _sortPlaces(placesInit);
      return placesInit;
    } else {
      _sortPlaces(_places);
      return _places;
    }
  }

  @override
  Future<List<PlaceSearchHistory>> searchNewPlace(String nameNewPlace) async {
    var places = await _dataSourceGoogle.lookingNewPlaceOnMap(nameNewPlace);
    var placesSort = List<PlaceSearchHistory>();
    _places.forEach((element) {
      if(element.namePlace.toLowerCase().startsWith(nameNewPlace.toLowerCase())) {
        placesSort.add(element);
      }
    });
    if(placesSort.length != 0) {
      placesSort.forEach((element) {
        places.add(element);
      });
    }
    return places;
  }



  void _sortPlaces(List<PlaceSearchHistory> placeSort) {
    Comparator<PlaceSearchHistory> nameComparator = (a, b) =>
        a.namePlace.toLowerCase().compareTo(b.namePlace.toLowerCase());
    placeSort.sort(nameComparator);
  }
}