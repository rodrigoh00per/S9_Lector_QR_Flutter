import 'dart:async';

import 'package:s9_qrscannerapp/src/models/scan_model.dart';
import 'package:s9_qrscannerapp/src/providers/db_provider.dart';

class ScansBloc {
  static final ScansBloc _singleton = ScansBloc._internal();

  factory ScansBloc() {
    return _singleton;
  }

  ScansBloc._internal() {
    this.obtenerScans();
  }

  final _scansController = StreamController<List<ScanModel>>.broadcast();

  Stream<List<ScanModel>> get scanStream => _scansController.stream;

  dispose() {
    _scansController?.close();
  }

  obtenerScans() async {
    _scansController.sink.add(await DBProvider.db.getTodosScans());
  }

  agregarScan(ScanModel scanModel) async {
    await DBProvider.db.nuevoScan(scanModel);
    this.obtenerScans();
  }

  borrarScan(int id) async {
    await DBProvider.db.deleteScan(id);
    this.obtenerScans();
  }

  borrarScansTodos() async {
    await DBProvider.db.deleteAll();
    this.obtenerScans();
  }
}
