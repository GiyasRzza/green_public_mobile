import 'dart:convert';
import 'package:green_public_mobile/apis/settings/ServerSideConnection.dart';
import 'package:http/http.dart' as http;
import '../dto/Tree.dart';

class TreeApis {
  static Future<List<Tree>> getTrees() async {
    String url = "${ServerSideConnection.connectionUrl}/trees?populate=*";
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
      for (var tree in trees) {
        print('Tree name: ${tree.name}');
        print('Tree name: ${tree.price}');
        print('Tree name: ${tree.pictureUrl}');
      }
      return trees;
    } else {
      print("Error Post From Flutter: ${response.statusCode}, ${response.reasonPhrase}");
      return [];
    }
  }
}
