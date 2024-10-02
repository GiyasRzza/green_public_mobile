import 'dart:convert';

import 'WeatherData.dart';

class Weather {
  final int id;
  final String greeting;
  final String createdAt;
  final String updatedAt;
  final String publishedAt;
  final String locale;
  final WeatherData weatherData;

  Weather({
    required this.id,
    required this.greeting,
    required this.createdAt,
    required this.updatedAt,
    required this.publishedAt,
    required this.locale,
    required this.weatherData
  });

  factory Weather.fromJson(String jsonString) {
    final Map<String, dynamic> json = jsonDecode(jsonString);
    final Map<String, dynamic> weatherDataMap = json['weatherData'] ?? {};
    final WeatherData weatherData = WeatherData.fromJson(weatherDataMap);

    return Weather(
      id: json['weather']['id'] ?? 0,
      greeting: json['weather']['greeting'] ?? 'Hello!',
      createdAt: json['weather']['createdAt'] ?? 'Unknown',
      updatedAt: json['weather']['updatedAt'] ?? 'Unknown',
      publishedAt: json['weather']['publishedAt'] ?? 'Unknown',
      locale: json['weather']['locale'] ?? 'en',
      weatherData: weatherData,
    );
  }
}


