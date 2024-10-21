import 'dart:convert';
import 'package:green_public_mobile/apis/settings/ServerSideConnection.dart';
import 'package:http/http.dart' as http;
import '../dto/Tree.dart';

class TreeApis {
  static Future<List<Tree>> getTrees() async {
    String url = "${ServerSideConnection.connectionUrl}/trees?populate=picture,video,store,characteristic_bundle.characteristics,planting_process.process_elements,localizations";
    Map<String, String> headers = {
      "Content-Type": "application/json",
      'Accept-Charset': 'utf-8',
    };
    http.Response response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      String responseBody = response.body;
      final Map<String, dynamic> jsonResponse = json.decode(responseBody);
      final List<dynamic> treeData = jsonResponse['data'] ?? jsonResponse['results'];
      List<Tree> trees = treeData.map((data) => Tree.fromJson(data)).toList();
      trees.forEach((element) {
        element.plantingProcess?.processElements.forEach((element) {
          print(element.text);
        },);
      },);
      return trees;
    } else {
      print("Error Post From Flutter: ${response.statusCode}, ${response.reasonPhrase}");
      return [];
    }
  }
}
