import 'package:acme/app/modules/crear_encuesta/crear_encuesta.dart';
import 'package:acme/app/modules/editar_encuesta/editar_encuesta.dart';
import 'package:acme/app/modules/forgot/forgot.dart';
import 'package:acme/app/modules/home/home.dart';
import 'package:acme/app/modules/singin/singin.dart';
import 'package:acme/app/modules/singup/singup.dart';
import 'package:acme/app/modules/splash_screen/splash_screen.dart';
import 'package:acme/app/routes/routes.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class AppPages {
  static final pages = [
    GetPage(name: Routes.splash, page: () => const Splash()),
    GetPage(name: Routes.home, page: () => const Home()),
    GetPage(name: Routes.singin, page: () => const SignIn()),
    GetPage(name: Routes.singup, page: () => const SignUp()),
    GetPage(name: Routes.forgot, page: () => const Forgot()),
    GetPage(name: Routes.crearencuesta, page: () => const CrearEncuesta()),
    GetPage(name: Routes.editarencuesta, page: () => const EditarEncuesta()),
  ];
}
