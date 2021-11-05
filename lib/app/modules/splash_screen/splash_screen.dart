import 'dart:async';

import 'package:acme/app/glogal_widgets/glogal_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  Timer? timer;

  final c = Get.find<GC>();

  void to() {
    timer = Timer(
      const Duration(seconds: 1),
      fu,
    );
  }

  fu() {
    c.checkConection(context);
  }
  @override
  Widget build(BuildContext context) {
    to();
    return Material(
      color: Colors.grey[850],
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'BIENVENIDO',
              style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 15,
            ),
            CircularProgressIndicator(
              color: Colors.grey,
              strokeWidth: 2,
            ),
          ],
        ),
      ),
    );
  }
}
