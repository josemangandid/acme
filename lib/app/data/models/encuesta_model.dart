// To parse this JSON data, do
//
//     final encuesta = encuestaFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Encuesta> encuestaFromJson(String str) =>
    List<Encuesta>.from(json.decode(str).map((x) => Encuesta.fromJson(x)));

String encuestaToJson(List<Encuesta> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Encuesta {
  Encuesta({
    this.key,
    @required this.name,
    @required this.discription,
    @required this.campos,
  });
  String? key;
  String? name;
  String? discription;
  List<Campo>? campos;

  factory Encuesta.fromJson(Map<dynamic, dynamic> json) => Encuesta(
        name: json["name"],
        discription: json["discription"],
        campos: List<Campo>.from(json["campos"].map((x) => Campo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "discription": discription,
        "campos": List<dynamic>.from(campos!.map((x) => x.toJson())),
      };
}

class Campo {
  Campo(
      {@required this.name,
      @required this.title,
      @required this.type,
      @required this.requerido});

  String? name;
  String? title;
  String? type;
  bool? requerido;

  factory Campo.fromJson(Map<dynamic, dynamic> json) => Campo(
        name: json["name"],
        title: json["title"],
        type: json["type"],
        requerido: json["requerido"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "title": title,
        "type": type,
        "requerido": requerido,
      };
}
