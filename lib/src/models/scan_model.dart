import 'package:latlong/latlong.dart';

class ScanModel {
  int id;
  String tipo;
  String valor;

  ScanModel({
    this.id,
    this.tipo,
    this.valor,
  }) {
    if (this.valor.contains("http")) {
      this.tipo = "http";
    } else {
      this.tipo = "geo";
    }
  }

  factory ScanModel.fromJson(Map<String, dynamic> json) => new ScanModel(
        id: json["id"],
        tipo: json["tipo"],
        valor: json["valor"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tipo": tipo,
        "valor": valor,
      };

  LatLng getLatLong() {
    final latlongtemp = this.valor.substring(4).split(",");
    print(latlongtemp);

    final lat = double.parse(latlongtemp[0]);
    final long = double.parse(latlongtemp[1]);
    print(lat);
    print(long);
    return LatLng(lat, long);
  }
}
