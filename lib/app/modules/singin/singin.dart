import 'package:acme/app/behavior/hiden_scroll_behavior.dart';
import 'package:acme/app/core/values/colors.dart';
import 'package:acme/app/glogal_widgets/shared_preferences.dart';
import 'package:acme/app/modules/singin/singin_controller.dart';
import 'package:acme/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

final prefs = PrefsUser();

class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignInController>(
      init: SignInController(),
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
                                  'Iniciar sesión',
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
                              Container(
                                padding: const EdgeInsets.only(right: 5),
                                child: Row(
                                  children: [
                                    const Spacer(),
                                    TextButton(
                                      onPressed: () {
                                        _.nav(Routes.forgot);
                                      },
                                      child: const Text(
                                        '¿Olvidaste tu contraseña?',
                                        style: TextStyle(color: MyColors.verde),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                child: Card(
                                  child: ListTile(
                                    title: const Center(
                                      child: Text('Iniciar sesión'),
                                    ),
                                    onTap: () async {
                                      _.signin(context);
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
                          const Text('¿No tienes cuenta?'),
                          TextButton(
                            onPressed: () {
                              _.nav(Routes.singup);
                            },
                            child: const Text(
                              'Registrarse',
                              style: TextStyle(color: MyColors.verde),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Form(
                              key: _.encuestaFormKey,
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: TextFormField(
                                  autofocus: false,
                                  controller: _.encuesta,
                                  enableSuggestions: false,
                                  autocorrect: false,
                                  keyboardType: TextInputType.url,
                                  decoration: const InputDecoration(
                                    labelText: 'Encuesta',
                                  ),
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'No dejar este campo vacío';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                _.ressponderEncuesta();
                              },
                              icon: const Icon(Icons.arrow_forward_ios,
                                  color: MyColors.verde))
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
