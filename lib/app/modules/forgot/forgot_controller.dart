import 'package:acme/app/glogal_widgets/glogal_controller.dart';
import 'package:acme/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotController extends GetxController {
  final c = Get.find<GC>();
  final _formKey = GlobalKey<FormState>();

final   TextEditingController? _email = TextEditingController();
  GlobalKey<FormState> get formKey => _formKey;
  TextEditingController get emailController => _email!;

  reset(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      try {
        await c.auth
            .sendPasswordResetEmail(email: _email!.text.replaceAll(' ', ''));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.grey,
            content: Text(
              text,
              style: TextStyle(color: Colors.grey[850]),
            ),
          ),
        );
        Get.offNamed(Routes.singin);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.grey,
            content: Text(
              'Fallo, intentelo nuevamente.',
              style: TextStyle(color: Colors.grey[850]),
            ),
          ),
        );
      }
    }
  }

  String text =
      'Correo electrónico de restablecimiento de contraseña enviado! Por favor revise su bandeja de entrada';

  nav(String route) {
    Get.offNamed(route);
  }
}
