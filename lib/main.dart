import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() {
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Application",
      initialRoute: Routes.MAIN_MAP,
      getPages: AppPages.routes,
      defaultTransition: Transition.zoom,
    ),
  );
}
