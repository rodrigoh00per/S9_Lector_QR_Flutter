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
      options: MapOptions(
          zoom: 100, center: scan.getLatLong()), //en donde se localizara el mapa
      layers: [_crearMapa(), _crearMarcadores(scan)],
    );
  }

  _crearMapa() {
    print("estoy adentro");
    return TileLayerOptions(
        //aqui se ven las opciones para poder mostrar el mapa atraves de mapbox
        urlTemplate: 'https://api.mapbox.com/v4/'
            '{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}',
        additionalOptions: {
          "accessToken":
              "pk.eyJ1Ijoicm9kcmlnb2gwMHBlciIsImEiOiJjangycXg1NWUwMXIxNDVvNXI2YWplaGxuIn0.Aq8QYqFvQqF0adHfFGMHsA",
          "id": "mapbox.streets"
          //light,dark,streets,outdoors,satellite
        });
  }

  _crearMarcadores(ScanModel scan) {
    return MarkerLayerOptions(markers: [
      Marker(
          height: 100,
          width: 100,
          point: scan.getLatLong(),
          builder: (context) => Container(
                child: Icon(
                  Icons.location_on,
                  color: Theme.of(context).primaryColor,
                  size: 70,
                ),
              ))
    ]);
  }
}
