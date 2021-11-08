import 'dart:convert';

import 'package:acme/app/data/models/encuesta_model.dart';
import 'package:http/http.dart' as http;

const String urlraiz = 'url';

class Provider {
  Future<Encuesta> getEncuesta(Uri? uri) async {
    http.Response response = await http.get(uri!);
    final uncoded = json.decode(response.body);
    Encuesta encuesta = Encuesta.fromJson(uncoded);
    return encuesta;
  }
}
