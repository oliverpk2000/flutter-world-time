import 'package:flutter/material.dart';
import '../services/city_time_data.dart';
import 'home.dart';

class CityTile extends StatelessWidget {
  //Bleibt Stateless!!!
  var ctd;
  final void Function() selector;

  CityTile({super.key, required this.ctd, required this.selector});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: ListTile(
        leading: Image.network(ctd.flag!),
        title: Text("${ctd.name!}: ${ctd.time!}"),
        subtitle: Text("offset: ${ctd.offset!}"),
        trailing: IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            selector();
          },
        ),
      ),
    ));
  }
}
