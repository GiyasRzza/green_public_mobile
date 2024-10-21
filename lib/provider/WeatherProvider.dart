import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:green_public_mobile/apis/WeatherApis.dart';
import 'package:green_public_mobile/dto/Weather.dart';
import 'package:green_public_mobile/dto/WeatherScreen.dart';
import 'package:intl/intl.dart';

class WeatherProvider extends ChangeNotifier {
  WeatherScreen weatherScreen = WeatherScreen.empty();

  WeatherProvider() {
    getCurrentLocation();
  }

  Future<void> getCurrentLocation() async {
    notifyListeners();
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
      var location = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      print(location.longitude);
      print(location.latitude);
      getCurrentWeather(location.latitude.toString(), location.longitude.toString());
    } else {
      print("User denied permission to access device location.");
    }
  }
  String formatTemperature(String temperature) {
    try {
      double tempValue = double.parse(temperature.split('°')[0]);
      int roundedTemp = tempValue.round();
      return '$roundedTemp°C';
    } catch (e) {
      print("Temperature format error: $e");
      return 'N/A';
    }
  }
  Future<void> getCurrentWeather(String latitude, String longitude) async {
    try {
      Weather weather = await WeatherApis.getCurrentWeather(latitude, longitude);
      weatherScreen.name = weather.city;
      weatherScreen.greeting = weather.storedWeatherData.greeting;
      weatherScreen.temperatureC = formatTemperature(weather.liveWeather.temperature);
      weatherScreen.weatherConditionText=weather.liveWeather.condition;
      weatherScreen.localDateTime = formatLocalTime(DateTime.now().toString());
      weatherScreen.weatherConditionIcon = getCloudImage("https://example.com/weather_icon.png");
      print(weatherScreen.localDateTime);
      notifyListeners();
    } catch (e) {
      print("Error fetching weather data: $e");
    }
  }

  Image getCloudImage(String url) {
    try {
      return Image.asset(
        "images/sunny default icon.jpeg",
      );
    } catch (e) {
      print("Image error: $e");
      return Image.asset(
        "images/sunny default icon.jpeg",
      );
    }
  }

  String formatLocalTime(String dateString) {
    final DateTime now = DateTime.parse(dateString);
    DateFormat dateFormat = DateFormat('EEEE, MMMM d, yyyy');
    return dateFormat.format(now);
  }
}
