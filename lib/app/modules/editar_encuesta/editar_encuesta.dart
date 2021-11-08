import 'dart:ui';

import 'package:acme/app/core/values/colors.dart';
import 'package:acme/app/modules/editar_encuesta/editar_encuesta_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';

class EditarEncuesta extends StatelessWidget {
  const EditarEncuesta({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditarEncuestaController>(
      init: EditarEncuestaController(),
      builder: (_) => Scaffold(
          appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.grey,
                ),
              ),
              title: const Text('Crear Encuesta',
                  style: TextStyle(color: Colors.grey))),
          body: ListView(
            children: [
              Form(
                key: _.formKeyEncuesta,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: TextFormField(
                        autofocus: false,
                        controller: _.name,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          labelText: 'Nombre de la encuesta',
                        ),
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'No dejar este campo vacío';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 16, left: 16, bottom: 16),
                      child: TextFormField(
                        autofocus: false,
                        controller: _.descrition,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          labelText: 'Descripción',
                        ),
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'No dejar este campo vacío';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: <Widget>[
                    const Expanded(child: Divider()),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: const Text("Campos"),
                    ),
                    const Expanded(child: Divider()),
                  ],
                ),
              ),
              Obx(
                () => ListView.builder(
                  shrinkWrap: true,
                  itemCount: _.campos.length,
                  itemBuilder: (BuildContext context, int i) {
                    return Padding(
                      padding: const EdgeInsets.only(
                          right: 16, left: 16, bottom: 16),
                      child: Card(
                        color: MyColors.tarjetas,
                        child: ListTile(
                            onTap: () async {},
                            title: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    _.campos[i].title!,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: MyColors.textoClaro!,),
                                  overflow: TextOverflow.ellipsis,
                                  ),
                                )
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    _.edit(context, i);
                                  },
                                  icon: const Icon(
                                    Icons.create,
                                    color: Colors.grey,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    _.deleteCampo(i);
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            )),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
          floatingActionButton: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.grey)),
                onPressed: () {
                  _.editarEncuesta(context);
                },
                child: const Text(
                  'Guardar Encuesta',
                  style: TextStyle(color: Color(0xff303030)),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: CircleAvatar(
                  backgroundColor: Colors.grey,
                  maxRadius: 25,
                  child: IconButton(
                    icon: const Icon(
                      Icons.add,
                      color: Colors.black87,
                    ),
                    onPressed: () {
                      _.showD(context);
                    },
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
