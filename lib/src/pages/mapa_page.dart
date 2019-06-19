import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:s9_qrscannerapp/src/models/scan_model.dart';

class MapaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final scan = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text("Coordenadas QR")),
          actions: <Widget>[
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.location_searching),
            )
          ],
        ),
        body: _crearFlutterMap(scan));
  }

  _crearFlutterMap(ScanModel scan) {
    return FlutterMap(
      options: MapOptions(zoom: 10, center: scan.getLatLong()),
      layers: [_crearMapa()],
    );
  }

  _crearMapa() {
    print("estoy adentro");
    return TileLayerOptions(
        urlTemplate: 'https://api.mapbox.com/v4/'
            '{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}',
        additionalOptions: {
          "accessToken":
              "pk.eyJ1Ijoicm9kcmlnb2gwMHBlciIsImEiOiJjangycXg1NWUwMXIxNDVvNXI2YWplaGxuIn0.Aq8QYqFvQqF0adHfFGMHsA",
          "id": "mapbox.streets"
        });
  }
}
