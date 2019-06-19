import 'package:flutter/material.dart';

class MapaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final coordenadas = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Center(child:Text("Coordenadas QR")),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.location_searching),
          )
        ],
      ),
      body: Center(
        child: Text(coordenadas),
      ),
    );
  }
}
