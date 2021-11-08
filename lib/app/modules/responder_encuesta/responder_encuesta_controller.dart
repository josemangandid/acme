import 'dart:math';

import 'package:acme/app/data/models/encuesta_model.dart';
import 'package:acme/app/data/provider/provider.dart';
import 'package:acme/app/glogal_widgets/real_time_database.dart';
import 'package:acme/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';

class ResponderEncuestaController extends GetxController {
  final GlobalKey<FormState> _formKeyEncuesta = GlobalKey<FormState>();
  GlobalKey<FormState> get formKeyEncuesta => _formKeyEncuesta;
  Uri? deepLink;
  Encuesta? _encuesta;
  Encuesta get encuesta => _encuesta!;

  final RxBool _loaded = false.obs;
  bool get loaded => _loaded.value;
  String? keyDB = '';

  @override
  void onInit() {
    deepLink = Get.arguments as Uri;
    getEncuesta();
    super.onInit();
    geturl();
  }

  geturl() {
    keyDB = deepLink!.toString().substring(49, 108).replaceAll("encuestas", "respuestas");
  }

  final p = Provider();

  getEncuesta() async {
    _encuesta = await p.getEncuesta(deepLink!);
    _loaded.value = true;
  }

  List<Map<String, dynamic>> campos = [];

  final controller = Get.find<DatabaseService>();
  final String _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  final Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  addEncuesta() {
    controller.addRespuesta(campos, keyDB!, getRandomString(10));
    Get.toNamed(Routes.splash);
  }
}
