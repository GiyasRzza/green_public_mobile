import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:green_public_mobile/apis/settings/ServerSideConnection.dart';
import 'package:green_public_mobile/dto/Weather.dart';
import 'package:http/http.dart' as http;

class WeatherApis{
  static  Future<void> getCurrentWeather(String geoLoc,String locale)  async {
    String url = "${ServerSideConnection.connectionUrl}/weather?";
    Map<String, String> headers = {"Content-Type": "application/json",'Accept-Charset': 'utf-8',};
    http.Response response = await http.get(Uri.parse(url),
      headers: headers,);
    if (response.statusCode == 200) {
      String responseBody = response.body;
      String decodedResponse = utf8.decode(responseBody.runes.toList());
      print(decodedResponse);
    } else {
      print("Error Post From Flutter: ${response.statusCode}, ${response
          .reasonPhrase}");
    }
  }
}