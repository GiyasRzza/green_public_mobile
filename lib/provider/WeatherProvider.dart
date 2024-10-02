
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:green_public_mobile/apis/WeatherApis.dart';
import 'package:green_public_mobile/dto/Weather.dart';
import 'package:green_public_mobile/dto/WeatherScreen.dart';
import 'package:intl/intl.dart';

class WeatherProvider extends ChangeNotifier{

    WeatherScreen weatherScreen=WeatherScreen.empty();

    WeatherProvider(){
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

  Future<void> getCurrentWeather(String geoLoc,String locale) async {
        Weather weather= await  WeatherApis.getCurrentWeather(geoLoc, locale);
        weatherScreen.name=weather.weatherData.locationName;
        weatherScreen.greeting=weather.greeting;
        weatherScreen.region=weather.weatherData.region;
        weatherScreen.weatherConditionText=weather.weatherData.current.conditionText;
        weatherScreen.localDateTime=formatLocalTime(weather.weatherData.localTime);
        weatherScreen.weatherConditionIcon=getCloudImage(weather.weatherData.current.conditionIcon);
        weatherScreen.temperatureC=weather.weatherData.current.temperatureC.toString();
        weatherScreen.precip_mm=weather.weatherData.current.precipMm.toString();
        print(weatherScreen.localDateTime);
        notifyListeners();
    }
    Image getCloudImage(String url) {
        try {
            return Image.network("https:$url");
        } catch (e) {
            print("Image error: $e");
            return Image.asset("images/sunny default icon.jpeg",);
        }
    }
    // String formatLocalTime(String dateString) {
    //   print("gelen date ${dateString}" );
    //   DateTime dateTime = DateTime.parse(dateString);
    //   DateFormat dateFormat = DateFormat('EEEE, MMMM d, yyyy');
    //   return dateFormat.format(dateTime);
    // }
    String formatLocalTime(String dateString) {
      final RegExp dateRegex = RegExp(r"(\d{4}-\d{2}-\d{2})");
      final match = dateRegex.firstMatch(dateString);
      if (match != null) {
        final datePart = match.group(1);
        DateTime dateTime = DateTime.parse(datePart!);
        DateFormat dateFormat = DateFormat('EEEE, MMMM d, yyyy');
        return dateFormat.format(dateTime);
      } else {
        throw FormatException('Invalid date format: $dateString');
      }
    }
}