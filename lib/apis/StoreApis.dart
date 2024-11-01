import 'dart:convert';
import 'package:green_public_mobile/apis/settings/ServerSideConnection.dart';
import 'package:http/http.dart' as http;

import '../dto/Store.dart';

class StoreApis{
  static  Future<List<Store>> getStores()  async {
    String url = "${ServerSideConnection.connectionUrl}/stores?populate[products][populate]=image&populate[trees][populate]=picture";
    Map<String, String> headers = {"Content-Type": "application/json",'Accept-Charset': 'utf-8',};
    http.Response response = await http.get(Uri.parse(url),
      headers: headers,);
    if (response.statusCode == 200) {
      String responseBody = response.body;
      final Map<String, dynamic> jsonResponse = json.decode(responseBody);
      final List<dynamic> treeData = jsonResponse['data'] ?? jsonResponse['results'];
      List<Store> stores = treeData.map((data) => Store.fromJson(data)).toList();
      return stores;
    } else {
      print("Error Post From Flutter: ${response.statusCode}, ${response
          .reasonPhrase}");
      return [];
    }
  }
}