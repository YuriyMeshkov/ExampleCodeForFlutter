class PlaceSearchHistory {
  String namePlace;
  String addressPlace;
  double latPlace;
  double lngPlace;
  bool history;

  PlaceSearchHistory(
      {this.namePlace,
        this.addressPlace : "",
        this.latPlace,
        this.lngPlace,
        this.history : false}
      );

  Map<String, dynamic> placeToMap() {
    return {
      "nameplace" : namePlace,
      "addressplace" : addressPlace,
      "lat" : latPlace,
      "lng" : lngPlace
    };
  }
}