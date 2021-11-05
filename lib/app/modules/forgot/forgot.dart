import 'dart:ui';
import 'package:acme/app/behavior/hiden_scroll_behavior.dart';
import 'package:acme/app/core/values/colors.dart';
import 'package:acme/app/modules/forgot/forgot_controller.dart';
import 'package:acme/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Forgot extends StatelessWidget {
  const Forgot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ForgotController>(
      init: ForgotController(),
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
                                    'Olvidé mi contraseña',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  child: const Text(
                                    'Por favor introduzca una dirección de correo electrónico. Recibirás un link para crear una nueva contraseña.',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: TextFormField(
                                    autofocus: false,
                                    controller: _.emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      labelStyle: const TextStyle(color: MyColors.verde),
                                      contentPadding: const EdgeInsets.all(10.0),
                                      labelText: 'Correo electrónico',
                                      enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: MyColors.principal!),
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                        borderSide: BorderSide(
                                            color: MyColors.verde!, width: 2),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                        borderSide: BorderSide(
                                          color: MyColors.error!,
                                        ),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                        borderSide: BorderSide(
                                          color: MyColors.error!,
                                        ),
                                      ),
                                    ),
                                    validator: (String? value) {
                                      if (value!.isEmpty)
                                        {return 'Escriba su correo electrónico';}
                                      return null;
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  child: Card(
                                    child: ListTile(
                                      title: const Center(
                                        child: Text(
                                            'Solicitar enlace para contraseña'),
                                      ),
                                      onTap: () async {
                                        _.reset(context);
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            const Spacer(),
                            TextButton(
                              onPressed: () {
                                _.nav(Routes.singin);
                              },
                              child: Text(
                                '¿Iniciar sesión?',
                                style: TextStyle(color: MyColors.verde!),
                              ),
                            ),
                          ],
                        ),
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
