import 'package:example_code_for_flutter/app/modules/main_map/controllers/main_map_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Constans.dart';

class DirectionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainMapController>(
      builder: (controller) {
        if (!controller.isShowDirectionButton.value) {
          return Container();
        } else {
          return GestureDetector(
            onTap: () => controller.getRoutes(),
            child: Container(
              margin: EdgeInsets.only(
                left: 16,
                bottom: 24,
              ),
              padding: EdgeInsets.all(4.0),
              height: 40,
              width: 128,
              decoration: BoxDecoration(
                color: colorSingOrange,
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5), //помутнение
                    spreadRadius: 1, // радиус распространения
                    blurRadius: 2, // радиус размытия
                    offset: Offset(-3, 3), // меняет положение тени (направление света)
                  ),
                ],
              ),
              child: Center(
                child: Row(
                  children: [
                    SizedBox(width: 4.0),
                    Icon(
                      Icons.directions,
                      color: Colors.white,
                    ),
                    SizedBox(width: 4.0),
                    Text(
                      "Directions",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
