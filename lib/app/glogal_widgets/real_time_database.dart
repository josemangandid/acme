import 'dart:collection';
import 'dart:convert';

import 'package:acme/app/data/models/encuesta_model.dart';
import 'package:acme/app/glogal_widgets/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

class DatabaseService extends GetxController {
  final p = PrefsUser();
  FirebaseApp? app;
  DatabaseReference? _encuestaReference;
  FirebaseDatabase? database;
  //RealTime DAtabase

  @override
  void onInit() {
    initFirebase();

    super.onInit();
  }

  initFirebase() async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
  }

  addEncuest(Encuesta encuesta) {
    _encuestaReference = database!.reference().child(p.userid);
    _encuestaReference!.push().set(encuesta.toJson());
  }

  Query getEncuestas() {
    _encuestaReference = database!.reference().child(p.userid);
    return _encuestaReference!;
  }

  editarEncuesta(Encuesta encuesta) {
    _encuestaReference = database!.reference().child(p.userid);
    _encuestaReference!.child(encuesta.key!).update(encuesta.toJson());
  }

  eliminarEncuesta(String key) {
    _encuestaReference = database!.reference().child(p.userid);
    _encuestaReference!.child(key).remove();
  }
}
