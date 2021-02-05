import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

class _DataProdiver {
  List<dynamic> datos = [];

  _DataProdiver() {
    //cargarData();
  }

  Future<List<dynamic>> cargarDatos() async {
    final resp = await rootBundle.loadString('data/distribuidoras.json');
    Map dataMap = json.decode(resp);
    datos = dataMap['datos'];
    return datos;
  }

}

final dataProvider = _DataProdiver();
