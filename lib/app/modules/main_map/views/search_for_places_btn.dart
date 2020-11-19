import 'package:example_code_for_flutter/app/modules/main_map/controllers/search_for_places_controller_btn.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Constans.dart';

class SearchForPlacesButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchForPlacesController>(
      builder: (controller) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: GestureDetector(
            onTap: () => controller.goToNewScreen(),
            child: Container(
              padding: const EdgeInsets.only(left: 16),
              width: double.infinity,
              height: 48,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(24.0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5), //помутнение
                      spreadRadius: 1, // радиус распространения
                      blurRadius: 2, // радиус размытия
                      //offset: Offset(-3, 3), // меняет положение тени (направление света)
                    ),
                  ]),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      child: Text(
                        controller.destinationName.value,
                        maxLines: 1,
                        style: TextStyle(
                          color: Colors.black45,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  Container(
                      width: 48,
                      child: controller.isFinalDestinationEstablished.value
                          ? InkWell(onTap: () => controller.clearTextDestination(),
                              child: Center(
                                child: Icon(
                                  Icons.clear,
                                  color: colorSingOrange,
                                ),
                              ),
                            )
                          : Center()),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
