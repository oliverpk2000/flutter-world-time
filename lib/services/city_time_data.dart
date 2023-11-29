import 'dart:convert';

import 'package:http/http.dart';
import 'package:intl/intl.dart';

const Map<String, String> cityMap = {
  "Europe/Vienna": 'AT',
  "Europe/Paris": 'FR',
  "Europe/London": 'GB',
  "Pacific/Tahiti": 'PF',
  "Indian/Maldives": 'IN',
  "Asia/Kabul": 'AF',
  "Asia/Singapore": 'SG',
  "America/New_York": 'US',
  "America/Mexico_City": 'US',
  "Africa/Maputo": 'MZ',
  "Africa/Tunis": 'TN',
};

class CityTimeData {
  String? name;
  String? code;
  String? continent;

  String? flag;
  String? url;
  String style = "shiny";

  String? time;
  String? offset;



  CityTimeData(this.name, this.code, this.continent, this.flag, this.url,
      this.style, this.time, this.offset);

  CityTimeData.NameContinent(this.name, this.continent); // Constructor


  Future<void> getTime() async {
    var path = url;
    try {
      Response response = await get(Uri.parse(path!));
      if (response.statusCode == 200) {
        Map data = jsonDecode(response.body);
        time = data["datetime"].toString().split("T")[1].split(".")[0];
      }
      else {
        print("didn't work");
      }
    } catch (e) {
      print("didn't work 2");
    }
  }

}