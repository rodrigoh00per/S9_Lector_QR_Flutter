import 'package:s9_qrscannerapp/src/models/scan_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

abrirURL(ScanModel scanModel, BuildContext context) async {
  if (scanModel.tipo == "http") {
    if (await canLaunch(scanModel.valor)) {
      await launch(scanModel.valor);
    } else {
      throw 'No se puede abriir ${scanModel.valor}';
    }
  } else {
    Navigator.pushNamed(context, "mapa", arguments: scanModel.valor);
    print("mapita");
  }
}
