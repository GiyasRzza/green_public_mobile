import 'dart:convert';
import 'package:green_public_mobile/apis/settings/ServerSideConnection.dart';
import 'package:green_public_mobile/dto/ApiResponse.dart';
import 'package:green_public_mobile/dto/Placemark.dart';
import 'package:http/http.dart' as http;

class PlacemarkApis {
  static Future<List<Placemark>> getPlacemarks() async {
    String url = "${ServerSideConnection.connectionUrl}/placemarks";
    Map<String, String> headers = {
      "Content-Type": "application/json",
      'Accept-Charset': 'utf-8',
    };
    http.Response response = await http.get(
      Uri.parse(url),
      headers: headers,
    );

    if (response.statusCode == 200) {
      String responseBody = response.body;

      PlacemarkResponse placemarkResponse = PlacemarkResponse.fromJson(jsonDecode(responseBody));

      return placemarkResponse.data;
    } else {
      print("Error Post From Flutter: ${response.statusCode}, ${response.reasonPhrase}");
      return [];
    }
  }

  static Future<ApiResponse> getPlacemarkDetails(String id) async {
    String url = "${ServerSideConnection.connectionUrl}/company-trees?populate=*&filters[placemark][id][\$eq]=$id";

    Map<String, String> headers = {
      "Content-Type": "application/json",
      'Accept-Charset': 'utf-8',
    };

    try {

      http.Response response = await http.get(
        Uri.parse(url),
        headers: headers,
      );

      if (response.statusCode == 200) {

        String responseBody = response.body;


        ApiResponse apiResponse = ApiResponse.fromJson(jsonDecode(responseBody));

        return apiResponse;
      } else {

        print("Error From Flutter: ${response.statusCode}, ${response.reasonPhrase}");

      }
    } catch (e) {

      print("Exception in getPlacemarkDetails: $e");

    }
    return ApiResponse(data: []);
  }

}