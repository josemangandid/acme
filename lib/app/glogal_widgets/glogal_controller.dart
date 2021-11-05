import 'package:acme/app/glogal_widgets/shared_preferences.dart';
import 'package:acme/app/routes/routes.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';

class GC extends GetxController {
  final p = PrefsUser();
  User? user;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseAuth get auth => _auth;
  Future<void> signOut() async {
    await _auth.signOut();
    p.authValue = false;
    p.userid = '';
    Get.offNamed(Routes.singin);
  }

  @override
  void onInit() {
    _auth.userChanges().listen((event) => user = event);
    super.onInit();
  }

  checkConection(BuildContext context) async {
    ConnectivityResult connectivityResult =
        await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      Get.offNamed(p.authValue ? Routes.home : Routes.singin);
    } else {
      showD(context);
    }
  }

  showD(BuildContext _) async {
    switch (await showDialog(
      barrierDismissible: false,
      context: _,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.grey[850],
        title: const Text('¡Atención!'),
        content: const Text('No hay conexión a internet...'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(_, 'fun');
            },
            child: const Text('¿Reintentar?'),
          ),
        ],
      ),
    )) {
      case 'fun':
        checkConection(_);
        break;
    }
  }
}
