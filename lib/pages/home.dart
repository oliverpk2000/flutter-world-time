import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:wmc_test_1/services/city_time_data.dart';
import 'package:wmc_test_1/pages/city_tile.dart';

List<CityTimeData> lCtd = [];

class Home extends StatefulWidget {
  final String title;

  const Home({super.key, required this.title});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    loadTimes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: Colors.lightBlue,
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    Navigator.pushNamed(context, "/location", arguments: lCtd);
                  });
                },
                icon: const Icon(
                  Icons.location_pin,
                  color: Colors.deepOrangeAccent,
                ))
          ]),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: lCtd.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Image.network(lCtd[index].flag!),
                      title: Text("${lCtd[index].name!}: ${lCtd[index].time!}"),
                      subtitle: Text("offset: ${lCtd[index].offset!}"),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            lCtd.removeAt(index);
                          });
                        },
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            for (var element in lCtd) {element.getTime();}
          });
        },
        child: const Icon(Icons.alt_route_rounded),
      ),
    );
  }

  void loadTimes(){
    for (var keyValue in cityMap.entries) {
      getContinentCity(keyValue.key, keyValue.value);
    }
  }

  Future<void> getContinentCity(String areaLocation, String code) async {
    var path = 'http://worldtimeapi.org/api/timezone/';
    var fullPath = path + areaLocation;
    try {
      Response response = await get(Uri.parse(fullPath));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        String name = areaLocation.split("/")[1];
        String continent = areaLocation.split("/")[0];
        String flag = "https://flagsapi.com/$code/shiny/64.png";
        String time = data["datetime"].toString().split("T")[1].split(".")[0];
        String offset = data["utc_offset"];
        setState(() {
          lCtd.add(CityTimeData(
              name, code, continent, flag, fullPath, "shiny", time, offset));
        });
      } else {
        // Code here
        print("invalid request");
      }
    } catch (e) {
      print(e.toString());
    }
  }
}

// Code here
