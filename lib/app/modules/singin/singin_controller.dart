import 'package:acme/app/core/values/colors.dart';
import 'package:acme/app/glogal_widgets/glogal_controller.dart';
import 'package:acme/app/glogal_widgets/shared_preferences.dart';
import 'package:acme/app/routes/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _encuestaFormKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _encuesta = TextEditingController();
  final c = Get.find<GC>();
  GlobalKey get formKey => _formKey;
  GlobalKey get encuestaFormKey => _encuestaFormKey;
  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;
  TextEditingController get encuesta => _encuesta;

  final p = PrefsUser();


  signin(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      await signInWithEmailAndPassword(context);
    }
  }

  Future<void> signInWithEmailAndPassword(BuildContext context) async {
    try {
      final User? user = (await c.auth.signInWithEmailAndPassword(
        email: _emailController.text.replaceAll(" ", ""),
        password: _passwordController.text,
      ))
          .user;

      p.userid = user!.uid;
      p.authValue = true;
      Get.offNamed(Routes.home);
    } catch (e) {
      showD(context);
    }
  }

  nav(String route) {
    Get.offNamed(route);
  }

   final RxBool _isObscure = true.obs;
  bool get isObscure => _isObscure.value;

  setObscure() {
    _isObscure.value = !_isObscure.value;
  }

  showD(BuildContext _) async {
    switch (await showDialog(
      barrierDismissible: false,
      context: _,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.grey[850],
        title: const Text('¡Atención!'),
        content: const Text('No se ha podido iniciar sesión'),
        actions: [
          TextButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(MyColors.principal!),
            ),
            onPressed: () {
              Navigator.pop(_);
            },
            child: const Text('Cancelar', style: TextStyle(color: Color(0xff303030))),
          ),
          TextButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(MyColors.verde!),
            ),
            onPressed: () {
              Navigator.pop(_, 'fun');
            },
            child: const Text('¿Reintentar?', style: TextStyle(color: Color(0xff303030))),
          ),
        ],
      ),
    )) {
      case 'fun':
        signin(_);
        break;
    }
  }
}
