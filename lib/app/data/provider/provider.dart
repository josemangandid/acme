import 'dart:convert';

import 'package:acme/app/data/models/encuesta_model.dart';
import 'package:http/http.dart' as http;

const String urlraiz = 'url';

class Provider {
  Future<bool> createuser() async {
    return false;
  }

  Future<Encuesta> getEncuesta(String? query) async {
    Uri url = Uri.https(urlraiz, '$query!');
    http.Response response = await http.get(url);
    final uncoded = json.decode(response.body);
    Encuesta encuesta = Encuesta.fromJson(uncoded);
    return encuesta;
  }
}
