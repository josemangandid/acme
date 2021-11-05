import 'package:acme/app/core/theme/theme.dart';
import 'package:acme/app/glogal_widgets/glogal_controller.dart';
import 'package:acme/app/glogal_widgets/real_time_database.dart';
import 'package:flutter/material.dart';
import 'package:acme/app/routes/pages.dart';
import 'package:acme/app/routes/routes.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(GC());
    Get.put(DatabaseService());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EncuestaAcme',
      getPages: AppPages.pages,
      initialRoute: Routes.splash,
      theme: theme(context),
    );
  }
}