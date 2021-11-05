import 'package:acme/app/routes/routes.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';

class HomeController extends GetxController{
  gotoCrearEncuesta(){
    Get.toNamed(Routes.crearencuesta);
  }
}