import 'dart:convert';

class LiveWeather {
  final String temperature;
  final String condition;

  LiveWeather({
    required this.temperature,
    required this.condition,
  });

  factory LiveWeather.fromJson(Map<String, dynamic> json) {
    return LiveWeather(
      temperature: json['temperature'] ?? 'Unknown',
      condition: json['condition'] ?? 'Unknown',
    );
  }
}

class StoredWeatherData {
  final int id;
  final String greeting;
  final String greetingDescription;

  StoredWeatherData({
    required this.id,
    required this.greeting,
    required this.greetingDescription,
  });

  factory StoredWeatherData.fromJson(Map<String, dynamic> json) {
    return StoredWeatherData(
      id: json['id'] ?? 0,
      greeting: json['greeting'] ?? 'Hello!',
      greetingDescription: json['greetingDescription'] ?? 'No description available',
    );
  }
}

class Weather {
  final String city;
  final LiveWeather liveWeather;
  final List<StoredWeatherData> storedWeatherData;

  Weather({
    required this.city,
    required this.liveWeather,
    required this.storedWeatherData,
  });

  factory Weather.fromJson(String jsonString) {
    final Map<String, dynamic> json = jsonDecode(jsonString);

    final liveWeather = LiveWeather.fromJson(json['liveWeather'] ?? {});
    final storedWeatherDataList = json['storedWeatherData'] as List<dynamic>? ?? [];
    final storedWeatherData = storedWeatherDataList.map((data) => StoredWeatherData.fromJson(data)).toList();

    return Weather(
      city: json['city'] ?? 'Unknown',
      liveWeather: liveWeather,
      storedWeatherData: storedWeatherData,
    );
  }
}