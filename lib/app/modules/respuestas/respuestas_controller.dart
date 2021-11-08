import 'package:get/get.dart';

class RespuestasController extends GetxController {
  final RxMap _args = {}.obs;
  Map get args => _args;
  @override
  void onInit() {
    _args.value = Get.arguments as Map;
    super.onInit();
  }
}
