import 'package:flutter/material.dart';
import 'package:s9_qrscannerapp/src/bloc/scans_bloc.dart';
import 'package:s9_qrscannerapp/src/models/scan_model.dart';


class MapasPage extends StatelessWidget {
  final _scansBloc = ScansBloc();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: this._scansBloc.scanStream,
      builder: (BuildContext context, AsyncSnapshot<List<ScanModel>> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final scans = snapshot.data;

        if (scans.length == 0) {
          return (Center(
            child: Text("No hay registros a mostrar en estos momentos"),
          ));
        }
        return ListView.builder(
          itemCount: scans.length,
          itemBuilder: (BuildContext context, int i) {
            return Dismissible(
              key: UniqueKey(),
              onDismissed: (direction) {
                this._scansBloc.borrarScan(scans[i].id);
              },
              background: Container(
                padding: EdgeInsets.only(right: 10.0),
                child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Icon(
                    Icons.delete_outline,
                    color: Colors.white,
                  )
                ]),
                color: Colors.red,
              ),
              child: ListTile(
                leading: Icon(
                  Icons.cloud_queue,
                  color: Theme.of(context).primaryColor,
                ),
                title: Text(scans[i].valor),
                subtitle: Text("${scans[i].id}"),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            );
          },
        );
      },
    );
  }
}
