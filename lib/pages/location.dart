import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:wmc_test_1/pages/city_tile.dart';
import 'package:wmc_test_1/pages/home.dart';
import 'package:wmc_test_1/services/city_time_data.dart';

class Location extends StatefulWidget {
  const Location({super.key});

  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
  var locationList = cityMap.keys.toList();
  var dropdownValue = cityMap.keys
      .toList()
      .first;
  late CityTimeData selectedCtd;

  @override
  Widget build(BuildContext context) {
    dropdownValueToCityTimeData();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text("Select a City"),
      ),
      body: Column(
        children: [
          SizedBox(
            width: 1000,
            child: DropdownButtonFormField<String>(
              value: dropdownValue,
              onChanged: (String? value) {
                setState(() {
                  dropdownValue = value!;
                });
              },
              items: [for(var location in locationList) DropdownMenuItem(value: location, child: Text(location),)],
            ),
          ),
          Expanded(child: CityTile(ctd: selectedCtd, selector: selector))
        ],
      ),
    );
  }

  Future<void> dropdownValueToCityTimeData() async {
    var path = 'http://worldtimeapi.org/api/timezone/';
    var fullPath = path + dropdownValue;
    try {
      Response response = await get(Uri.parse(fullPath));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        String name = dropdownValue.split("/")[1];
        String continent = dropdownValue.split("/")[0];
        String flag =
            "https://flagsapi.com/${cityMap[dropdownValue]}/shiny/64.png";
        String time = data["datetime"].toString().split("T")[1].split(".")[0];
        String offset = data["utc_offset"];
        setState(() {
          selectedCtd = CityTimeData(
              name,
              cityMap[dropdownValue],
              continent,
              flag,
              fullPath,
              "shiny",
              time,
              offset);
        });
      } else {
        // Code here
        print("invalid request");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void selector() {
    if(lCtd.where((element) => element.name == selectedCtd.name).isEmpty){
      lCtd.add(selectedCtd);
    }
  }
}
