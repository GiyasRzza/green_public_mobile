import 'package:green_public_mobile/apis/settings/ServerSideConnection.dart';
import 'package:green_public_mobile/dto/Weather.dart';
import 'package:http/http.dart' as http;

class WeatherApis{
  static  Future<Weather> getCurrentWeather(String geoLoc,String locale)  async {
    String url = "${ServerSideConnection.connectionUrl}/weather?geoLoc=$geoLoc,%$locale&locale=en";
    Map<String, String> headers = {"Content-Type": "application/json",'Accept-Charset': 'utf-8',};
    http.Response response = await http.get(Uri.parse(url),
      headers: headers,);
    if (response.statusCode == 200) {
      String responseBody = response.body;
      // String decodedResponse = utf8.decode(responseBody.runes.toList());
      print(responseBody);
      return Weather.fromJson(responseBody);
    } else {
      print("Error Post From Flutter: ${response.statusCode}, ${response
          .reasonPhrase}");
      return Weather.fromJson(response.body);
    }
  }
}