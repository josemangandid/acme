import 'package:acme/app/behavior/hiden_scroll_behavior.dart';
import 'package:acme/app/data/models/encuesta_model.dart';
import 'package:acme/app/data/models/encuesta_modeldb.dart';
import 'package:acme/app/modules/responder_encuesta/responder_encuesta_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/state_manager.dart';
import 'package:intl/intl.dart';

class ResponderEncuesta extends StatelessWidget {
  const ResponderEncuesta({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ResponderEncuestaController>(
      init: ResponderEncuestaController(),
      builder: (_) => Obx(
        () => _.loaded
            ? Scaffold(
                appBar: AppBar(
                  title: Text(_.encuesta.name!),
                ),
                body: Form(
                  key: _.formKeyEncuesta,
                  child: ScrollConfiguration(
                    behavior: HidenScrollBehavior(),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: _.encuesta.campos!.length + 1,
                      itemBuilder: (context, i) {
                        return i == 0
                            ? Padding(
                                padding: const EdgeInsets.only(
                                    top: 16, right: 16, left: 16),
                                child: Text(
                                  _.encuesta.discription!,
                                  textAlign: TextAlign.justify,
                                ),
                              )
                            : item(_.encuesta.campos![i - 1], context, _);
                      },
                    ),
                  ),
                ),
                floatingActionButton: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.grey)),
                      onPressed: () {
                        if (_.formKeyEncuesta.currentState!.validate()) {
                          _.addEncuesta();
                        }
                        _.campos = [];
                      },
                      child: const Text(
                        'Enviar Encuesta',
                        style: TextStyle(color: Color(0xff303030)),
                      ),
                    ),
                  ],
                ),
              )
            : Material(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: const <Widget>[
                    Center(
                      child: CircularProgressIndicator(
                        color: Colors.grey,
                        strokeWidth: 2,
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }

  Widget item(
      Campo itemS, BuildContext context, ResponderEncuestaController _) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
      child: Card(
        child: Container(
            margin: const EdgeInsets.all(8), child: child(itemS, context, _)),
      ),
    );
  }

  Widget child(
      Campo item, BuildContext context, ResponderEncuestaController _) {
    TextEditingController _controller = TextEditingController();

    setFecha(DateTime f) {
      _controller.text = DateFormat.yMMMd().format(f);
    }

    Future<void> sshowDatePicker(BuildContext context) async {
      final picked = await showDatePicker(
        initialDate: DateTime.now(),
        firstDate: DateTime(1950),
        lastDate: DateTime(2030),
        context: context,
      );
      if (picked != null && picked != DateTime.now()) {
        setFecha(picked);
      }
    }

    data() {
      final dato = item.type == 'number'
          ? int.parse(_controller.text)
          : _controller.text;

      final campoDb = CampoDb(campo: dato, title: item.name!).toJson();
      _.campos.add(campoDb);
    }

    final texfield = TextFormField(
      autofocus: false,
      controller: _controller,
      keyboardType:
          item.type == 'number' ? TextInputType.number : TextInputType.text,
      decoration: const InputDecoration(
        labelText: 'Escribe un texto',
      ),
      validator: (String? value) {
        if (value!.isEmpty && item.requerido!) {
          return 'Este Campo es obligatorio';
        } else {
          data();
          return null;
        }
      },
    );

    return item.type == 'date'
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
                Row(
                  children: [
                    Text(item.title!),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(child: texfield),
                    IconButton(
                        onPressed: () {
                          sshowDatePicker(context);
                        },
                        icon: const Icon(Icons.date_range))
                  ],
                ),
              ])
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 5, left: 5, right: 5),
                child: Text(
                  item.title!,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
              texfield
            ],
          );
  }
}
