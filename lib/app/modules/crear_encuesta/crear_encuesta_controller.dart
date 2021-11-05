import 'package:acme/app/core/values/colors.dart';
import 'package:acme/app/data/models/encuesta_model.dart';
import 'package:acme/app/glogal_widgets/real_time_database.dart';
import 'package:acme/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/state_manager.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class CrearEncuestaController extends GetxController {
  final GlobalKey<FormState> _formKeyEncuesta = GlobalKey<FormState>();
  GlobalKey<FormState> get formKeyEncuesta => _formKeyEncuesta;
  final TextEditingController _name = TextEditingController();
  TextEditingController get name => _name;
  final TextEditingController _description = TextEditingController();
  TextEditingController get descrition => _description;

  final GlobalKey<FormState> _formKeyCampo = GlobalKey<FormState>();
  final TextEditingController _titleCampo = TextEditingController();
  final TextEditingController _nameCampo = TextEditingController();

  final controller = Get.find<DatabaseService>();

  RxString dropDownValue = 'Texto'.obs;
  String type = 'text';
  RxBool requerido = false.obs;

  final RxList<Campo> _campos = <Campo>[].obs;
  List<Campo> get campos => _campos;
  List<String> items = ['Texto', 'Numérico', 'Fecha'];

  showD(BuildContext _, CrearEncuestaController __) async {
    dropDownValue.value = 'Texto';
    requerido.value = false;
    _titleCampo.text = '';
    _nameCampo.text = '';
    showDialog(
      barrierDismissible: false,
      context: _,
      builder: (_) => ListView(
        children: [
          AlertDialog(
            backgroundColor: Colors.grey[850],
            title: const Text('Agregar pregunta'),
            content: Form(
              key: _formKeyCampo,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 16, left: 16, bottom: 16),
                    child: TextFormField(
                      autofocus: false,
                      controller: _nameCampo,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        labelText: 'Nombre',
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
                    padding:
                        const EdgeInsets.only(right: 16, left: 16, bottom: 16),
                    child: TextFormField(
                      autofocus: false,
                      controller: _titleCampo,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        labelText: 'Titulo',
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
                    padding:
                        const EdgeInsets.only(right: 16, left: 16, bottom: 16),
                    child: Row(
                      children: [
                        const Text('Tipo'),
                        const Spacer(),
                        Obx(
                          () => DropdownButton(
                            value: dropDownValue.value,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            items: <String>['Texto', 'Numérico', 'Fecha']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              dropDownValue.value = newValue!;
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 16, left: 16, bottom: 16),
                    child: Row(
                      children: [
                        const Text('Requerido'),
                        const Spacer(),
                        Obx(
                          () => Switch(
                            value: requerido.value,
                            onChanged: (bool value) {
                              requerido.value = value;
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            actions: [
              TextButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(MyColors.principal!),
                ),
                onPressed: () {
                  Navigator.pop(_);
                },
                child: const Text('Cancelar',
                    style: TextStyle(color: Color(0xff303030))),
              ),
              TextButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(MyColors.verde!),
                ),
                onPressed: () async {
                  if (_formKeyCampo.currentState!.validate()) {
                    Navigator.pop(_);
                    agregarCampo();
                  }
                },
                child: const Text(
                  'Agregar',
                  style: TextStyle(color: Color(0xff303030)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  edit(BuildContext _, int i) async {
    Campo? campo = _campos[i];
    switch (campo.type) {
      case 'text':
        dropDownValue.value = 'Texto';
        break;
      case 'number':
        dropDownValue.value = 'Numérico';
        break;
      case 'date':
        dropDownValue.value = 'Fecha';
        break;
    }
    requerido.value = campo.requerido!;
    _titleCampo.text = campo.title!;
    _nameCampo.text = campo.name!;

    showDialog(
      barrierDismissible: false,
      context: _,
      builder: (_) => ListView(
        children: [
          AlertDialog(
            backgroundColor: Colors.grey[850],
            title: const Text('Editar pregunta'),
            content: Form(
              key: _formKeyCampo,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 16, left: 16, bottom: 16),
                    child: TextFormField(
                      autofocus: false,
                      controller: _nameCampo,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        labelText: 'Nombre',
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
                    padding:
                        const EdgeInsets.only(right: 16, left: 16, bottom: 16),
                    child: TextFormField(
                      autofocus: false,
                      controller: _titleCampo,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        labelText: 'Titulo',
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
                    padding:
                        const EdgeInsets.only(right: 16, left: 16, bottom: 16),
                    child: Row(
                      children: [
                        const Text('Tipo'),
                        const Spacer(),
                        Obx(
                          () => DropdownButton(
                            value: dropDownValue.value,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            items: <String>['Texto', 'Numérico', 'Fecha']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              dropDownValue.value = newValue!;
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 16, left: 16, bottom: 16),
                    child: Row(
                      children: [
                        const Text('Requerido'),
                        const Spacer(),
                        Obx(
                          () => Switch(
                            value: requerido.value,
                            onChanged: (bool value) {
                              requerido.value = value;
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            actions: [
              TextButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(MyColors.principal!),
                ),
                onPressed: () {
                  Navigator.pop(_);
                },
                child: const Text('Cancelar',
                    style: TextStyle(color: Color(0xff303030))),
              ),
              TextButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(MyColors.verde!),
                ),
                onPressed: () async {
                  if (_formKeyCampo.currentState!.validate()) {
                    Navigator.pop(_);
                    editCampo(i);
                  }
                },
                child: const Text(
                  'Guardar',
                  style: TextStyle(color: Color(0xff303030)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void agregarCampo() async {
    type = dropDownValue.value;
    if (type == 'Text') {
      type = 'text';
    } else if (type == 'Numérico') {
      type = 'number';
    } else if (type == 'Fecha') {
      type = 'date';
    }

    Campo campo = Campo(
        name: _nameCampo.text,
        title: _titleCampo.text,
        type: type,
        requerido: requerido.value);
    _campos.add(campo);
  }

  void editCampo(int i) {
    type = dropDownValue.value;
    switch (type) {
      case 'Text':
        type = 'text';
        break;
      case 'Numérico':
        type = 'number';
        break;
      case 'Fecha':
        type = 'date';
        break;
    }

    Campo campo = Campo(
        name: _nameCampo.text,
        title: _titleCampo.text,
        type: type,
        requerido: requerido.value);
    _campos[i] = campo;
  }

  void deleteCampo(int i) {
    _campos.removeAt(i);
  }

  addencuest(BuildContext context) {
    if (_formKeyEncuesta.currentState!.validate() && campos.isNotEmpty) {
      Encuesta encuesta = Encuesta(
          name: _name.text, discription: _description.text, campos: _campos);
      controller.addEncuest(encuesta);
      Get.offNamed(Routes.home);
    } else if (campos.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.grey,
          content: Text(
            'Es necesario agregar campos',
            style: TextStyle(color: Colors.grey[850]),
          ),
        ),
      );
    }
  }
}
