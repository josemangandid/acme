import 'package:acme/app/core/values/colors.dart';
import 'package:acme/app/data/models/encuesta_modeldb.dart';
import 'package:acme/app/glogal_widgets/real_time_database.dart';
import 'package:acme/app/modules/respuestas/respuestas_controller.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';

class RespuestasPage extends StatelessWidget {
  const RespuestasPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RespuestasController>(
      init: RespuestasController(),
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: Obx(() => Text(_.args["title"])),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: [
              _getEncuestasList(_.args["key"]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getEncuestasList(String id) {
    //final c = Get.find<GC>();
    final c2 = Get.find<DatabaseService>();
    //final p = PrefsUser();
    return Expanded(
      child: FirebaseAnimatedList(
        shrinkWrap: true,
        query: c2.getRespuesta(id),
        itemBuilder: (context, snapshot, animation, index) {
          final listjson = snapshot.value as List;
          final List<CampoDb>? campos = listjson.map((e) {
            return CampoDb(title: e["title"], campo: e["campo"]);
          }).toList();
          final i = index + 1;
          return Padding(
            padding: const EdgeInsets.only(right: 8, left: 8, bottom: 8),
            child: Card(
              color: MyColors.tarjetas,
              child: ExpansionTile(
                title: Text(
                  'Respuesta $i',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: MyColors.textoClaro!),
                ),
                children: List.generate(
                  campos!.length,
                  (index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ListTile(
                      title: Text(campos[index].title! +
                          " : " +
                          campos[index].campo.toString()),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
