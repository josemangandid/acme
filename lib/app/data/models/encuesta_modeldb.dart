import 'package:meta/meta.dart';
import 'dart:convert';

String camposDbToJson(List<CampoDb> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CampoDb {
  CampoDb({
    @required this.campo,
    @required this.title,
  });
  dynamic campo;
  String? title;

  factory CampoDb.fromJson(Map<dynamic, dynamic> json) =>
      CampoDb(campo: json["campo"], title: json["title"]);

  Map<String, dynamic> toJson() => {"campo": campo, "title": title};
}
