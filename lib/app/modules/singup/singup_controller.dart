import 'package:acme/app/core/values/colors.dart';
import 'package:acme/app/data/provider/provider.dart';
import 'package:acme/app/glogal_widgets/glogal_controller.dart';
import 'package:acme/app/glogal_widgets/shared_preferences.dart';
import 'package:acme/app/routes/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final c = Get.find<GC>();
  GlobalKey get formKey => _formKey;
  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;

  @override
  void onClose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.onClose();
  }

  final RxBool _success = false.obs;
  final RxString _userEmail = ''.obs;

  bool get success => _success.value;
  String get userEmail => _userEmail.value;

  signup(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      await _register(context);
    }
  }

  final prefs = PrefsUser();
  final provider = Provider();

  Future<void> _register(BuildContext context) async {
    print('Se ha intentado crear usuario');
    final User? user = (await _auth.createUserWithEmailAndPassword(
      email: _emailController.text.replaceAll(' ', ''),
      password: _passwordController.text,
    ))
        .user;
    if (user != null) {
      prefs.userid = user.uid;
      prefs.authValue = true;
      print('usuario creado con exito');
      _success.value = true;
      _userEmail.value = user.email!;
      provider.createuser();
      Get.offNamed(Routes.home);
    } else {
      print('no se ha creado el usuario');
      _success.value = false;
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
        content: const Text('No se ha podido crear el usuario'),
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
            child: const Text('¿Reintentar?', style: TextStyle(color: Color(0xff303030)),),
          ),
        ],
      ),
    )) {
      case 'fun':
        signup(_);
        break;
    }
  }
}
