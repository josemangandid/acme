import 'package:acme/app/core/values/colors.dart';
import 'package:acme/app/data/models/encuesta_model.dart';
import 'package:acme/app/glogal_widgets/glogal_controller.dart';
import 'package:acme/app/glogal_widgets/real_time_database.dart';
import 'package:acme/app/modules/home/home_controller.dart';
import 'package:acme/app/routes/routes.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final c = Get.find<GC>();
    //print(c2.getEncuestas());
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (_) => Scaffold(
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                  child: Container(
                padding: const EdgeInsets.all(10),
                child: const Text('Encuestas Acme'),
              )),
              const Divider(
                height: 1,
                color: Colors.grey,
              ),
              ListTile(
                title: const Text('Cerrar Sesión'),
                onTap: () {
                  c.signOut();
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: const Text('Encuestas'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [_getEncuestasList()],
          ),
        ),
        floatingActionButton: Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            maxRadius: 25,
            child: IconButton(
              icon: const Icon(
                Icons.add,
                color: Colors.black87,
              ),
              onPressed: () {
                _.gotoCrearEncuesta();
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _getEncuestasList() {
    print('Inicializado');
    final c2 = Get.find<DatabaseService>();
    return Expanded(
      child: FirebaseAnimatedList(
        query: c2.getEncuestas(),
        itemBuilder: (context, snapshot, animation, index) {
          final json = snapshot.value as Map<dynamic, dynamic>;
          final encuesta = Encuesta.fromJson(json);
          return Padding(
            padding: const EdgeInsets.only(right: 8, left: 8, bottom: 8),
            child: Card(
              color: MyColors.tarjetas,
              child: ListTile(
                onTap: () async {},
                subtitle: Text(encuesta.discription!),
                title: Row(
                  children: [
                    Text(
                      encuesta.name!,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: MyColors.textoClaro!),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        Encuesta e = Encuesta(
                            key: snapshot.key,
                            campos: encuesta.campos,
                            discription: encuesta.discription,
                            name: encuesta.name);
                        Get.toNamed(Routes.editarencuesta, arguments: e);
                      },
                      icon: const Icon(
                        Icons.create,
                        color: Colors.grey,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        c2.eliminarEncuesta(snapshot.key!);
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
