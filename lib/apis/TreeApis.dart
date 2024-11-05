import 'dart:convert';
import 'package:green_public_mobile/apis/settings/ServerSideConnection.dart';
import 'package:http/http.dart' as http;
import '../dto/Tree.dart';

class TreeApis {
  static Future<List<Tree>> getTrees() async {
    String url = "${ServerSideConnection.connectionUrl}/trees?populate[characteristic_bundle][populate]=*&populate[planting_process][populate]=*&populate=video&populate[picture][populate]=*";
    Map<String, String> headers = {
      "Content-Type": "application/json",
      'Accept-Charset': 'utf-8',
    };
    http.Response response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      String responseBody = response.body;
      print(responseBody);
      final Map<String, dynamic> jsonResponse = json.decode(responseBody);

      final List<dynamic> treeData = jsonResponse['data'] ?? [];
      if (treeData.isEmpty) {
        print("No trees found in the response.");
        return [];
      }

      List<Tree> trees = treeData.map((data) => Tree.fromJson(data)).toList();
      return trees;
    } else {
      print("Error fetching trees: ${response.statusCode}, ${response.reasonPhrase}");
      return [];
    }
  }
}
