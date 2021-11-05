import 'package:acme/app/behavior/hiden_scroll_behavior.dart';
import 'package:acme/app/core/values/colors.dart';
import 'package:acme/app/modules/singup/singup_controller.dart';
import 'package:acme/app/routes/routes.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUp extends StatelessWidget {
  final String title = 'Registration';

  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignUpController>(
      init: SignUpController(),
      builder: (_) => Scaffold(
        body: SafeArea(
          child: ScrollConfiguration(
            behavior: HidenScrollBehavior(),
            child: ListView(
              children: [
                Form(
                  key: _.formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Card(
                          color: Colors.transparent,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.center,
                                  child: const Text(
                                    'Crear una cuenta',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: TextFormField(
                                    autofocus: false,
                                    controller: _.emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: const InputDecoration(
                                      labelText: 'Correo electrónico',
                                    ),
                                    validator: (String? value) {
                                      if (value!.isEmpty) {
                                        return 'Escriba su correo electrónico';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Obx(
                                    () => TextFormField(
                                      autofocus: false,
                                      obscureText: _.isObscure,
                                      controller: _.passwordController,
                                      enableSuggestions: false,
                                      autocorrect: false,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        suffixIcon: IconButton(
                                            icon: Icon(
                                              _.isObscure
                                                  ? Icons.visibility
                                                  : Icons.visibility_off,
                                              color: MyColors.verde,
                                            ),
                                            onPressed: () {
                                              _.setObscure();
                                            }),
                                        labelText: 'Contraseña',
                                      ),
                                      validator: (String? value) {
                                        if (value!.isEmpty) {
                                          return 'Escriba su contraseña';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  child: Card(
                                    child: ListTile(
                                      title: const Center(
                                        child: Text('Crear cuenta'),
                                      ),
                                      onTap: () async {
                                        _.signup(context);
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            const Spacer(),
                            const Text('¿Ya tienes cuenta?'),
                            TextButton(
                              onPressed: () {
                                _.nav(Routes.singin);
                              },
                              child: const Text(
                                'Iniciar sesión',
                                style: TextStyle(color: MyColors.verde),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Obx(
                            () => Container(
                              alignment: Alignment.center,
                              child: Text(
                                _.success == false
                                    ? ''
                                    : '${_.userEmail} se ha registrado correctamente.',
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
