import 'package:example_code_for_flutter/app/modules/search_places/controllers/search_places_controller.dart';
import 'package:example_code_for_flutter/app/modules/search_places/data/model/place_search_history.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../../Constans.dart';


class SearchPlacesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          FieldTextSearch(),
          Expanded(
            child: ListPlace(),
          ),
        ],
      ),
    );
  }
}

class FieldTextSearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return GetBuilder<SearchPlacesController>(
      builder: (controller) {
        return Align(
          alignment: Alignment.topCenter,
          child: Container(
            margin: new EdgeInsets.only(left: 8, top: 8 + statusBarHeight, right: 8),
            height: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(24.0)),
              border: Border.all(width: 1, color: Colors.black26),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                InkWell(
                  onTap: () => controller.backToPreviousScreenWithoutPlace(),
                  child: Container(
                    width: 54,
                    child: Center(
                      child: Icon(Icons.arrow_back),
                    ),
                  ),
                ),
                Expanded(
                  child: TextField(
                    maxLines: 1,
                    //controller: controller.textEditingController,
                    onChanged: (text){
                      controller.textSearch.value = text;
                    },
                    decoration: InputDecoration(
                      hintText: "Search",
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ListPlace extends StatelessWidget {

  ListPlace() {
    Get.find<SearchPlacesController>().initListPlaceHistory();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchPlacesController>(
      builder: (controller) {
        return ListView.builder(
          itemCount: controller.placesHistory == null ? 0 : controller.placesHistory.length,
          itemBuilder: (BuildContext context, int index) {
            return PlaceListItem(controller.placesHistory[index]);
          },
        );
      },
    );
  }

}

class PlaceListItem extends StatelessWidget {

  final PlaceSearchHistory place;

  PlaceListItem(this.place);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchPlacesController>(
      builder: (controller) {
        return InkWell(
          onTap: () {
            controller.writeToDatabase(place);
          },
          child: Container(
            width: double.infinity,
            height: 56,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  width: 64,
                  child: Center(
                    child: Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Builder(
                          builder: (context) {
                            if (!place.history) {
                              return Icon(
                                MdiIcons.mapMarkerOutline,
                                color: colorSingOrange,
                                size: 26,
                              );
                            } else {
                              return ImageIcon(AssetImage('images/history.png'),
                                color: colorSingBlue,
                                size: 26,
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 1, color: Colors.black12),
                      ),
                    ),
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(top: 4),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                place.namePlace,
                                style: TextStyle(fontSize: 16),
                                textAlign: TextAlign.start,
                                maxLines: 1,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                place.addressPlace,
                                style:
                                TextStyle(fontSize: 14, color: Colors.black87),
                                textAlign: TextAlign.start,
                                maxLines: 1,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 1, color: Colors.black12),
                    ),
                  ),
                  width: 64,
                  child: Center(
                    child: Icon(
                      MdiIcons.arrowTopLeft,
                      color: colorSingOrange,
                      size: 26,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
