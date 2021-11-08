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
    _encuestaReference = database!.reference().child(p.userid).child('encuestas');
    _encuestaReference!.push().set(encuesta.toJson());
  }

  Query getEncuestas() {
    _encuestaReference = database!.reference().child(p.userid).child('encuestas');
    return _encuestaReference!;
  }

  editarEncuesta(Encuesta encuesta) {
    _encuestaReference = database!.reference().child(p.userid).child('encuestas').child(encuesta.key!);
    _encuestaReference!.update(encuesta.toJson());
  }

  eliminarEncuesta(String key) {
    _encuestaReference = database!.reference().child(p.userid).child('encuestas').child(key);
    _encuestaReference!.remove();
  }

  addRespuesta(List<Map<String, dynamic>> campos, String key, String id) {

    _encuestaReference = database!
        .reference()
        .child(key);
    _encuestaReference!.push().set(campos);
  }

  Query getRespuesta(String id) {
    _encuestaReference =
        database!.reference().child(p.userid).child('respuestas').child(id);
    return _encuestaReference!;
  }
}
