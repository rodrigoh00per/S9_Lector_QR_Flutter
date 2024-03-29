import 'dart:io';

import 'package:flutter/material.dart';
import 'package:s9_qrscannerapp/src/bloc/scans_bloc.dart';
import 'package:s9_qrscannerapp/src/models/scan_model.dart';
import 'package:s9_qrscannerapp/src/pages/%20mapa_direccion.dart';
import 'package:s9_qrscannerapp/src/utils/utils.dart' as utils;

import 'package:qrcode_reader/qrcode_reader.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scansBloc = new ScansBloc();
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    this._scansBloc.obtenerScans();
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Lector de Codigos QR")),
        actions: <Widget>[
          IconButton(
            onPressed: this._scansBloc.borrarScansTodos,
            icon: Icon(Icons.delete_forever),
          )
        ],
      ),
      body: this.regresarPaginaSeleccionada(this._currentIndex),
      bottomNavigationBar: _mostrarBottomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          this._scanQR(context);
        },
        child: Icon(Icons.camera),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

  Widget _mostrarBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: this._currentIndex,
      onTap: (index) {
        setState(() {
          this._currentIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.map), title: Text("Mapa")),
        BottomNavigationBarItem(
            icon: Icon(Icons.directions), title: Text("Direcciones"))
      ],
    );
  }

  Widget regresarPaginaSeleccionada(opcion) {
    switch (opcion) {
      case 0:
        return MapaDireccionPage(
          tipo: 1,
        );
      case 1:
        return MapaDireccionPage(
          tipo: 2,
        );
        break;
      default:
        return MapaDireccionPage(tipo: 1);
    }
  }

  void _scanQR(BuildContext context) async {
    //https://www.xataka.com.mx/
    //geo:19.439236181963764,-99.11794081171877

    String futureString = "";

    try {
      futureString = await new QRCodeReader().scan();
    } catch (e) {
      futureString = e.toString();
    }

    if (futureString != null) {
      print("CODIGO ESCANEO");
      print("futureString $futureString");

      final scan = ScanModel(valor: futureString);

      this._scansBloc.agregarScan(scan);

      if (Platform.isIOS) {
        Future.delayed(Duration(milliseconds: 750), () {
          utils.abrirURL(scan, context);
        });
      } else {
        utils.abrirURL(scan, context);
      }
    }
  }
}
