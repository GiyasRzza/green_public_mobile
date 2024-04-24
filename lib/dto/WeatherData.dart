class WeatherData {
  final String locationName;
  final String region;
  final String country;
  final double lat;
  final double lon;
  final String timezone;
  final String localTime;
  final double temperatureC;
  final double temperatureF;
  final bool isDay;
  final String conditionText;
  final String conditionIcon;
  final int conditionCode;
  final double windMph;
  final double windKph;
  final int windDegree;
  final String windDirection;
  final double pressureMb;
  final double pressureIn;
  final double precipMm;
  final double precipIn;
  final int humidity;
  final int cloud;
  final double feelsLikeC;
  final double feelsLikeF;
  final double visibilityKm;
  final double visibilityMiles;
  final int uv;
  final double gustMph;
  final double gustKph;

  WeatherData({
    required this.locationName,
    required this.region,
    required this.country,
    required this.lat,
    required this.lon,
    required this.timezone,
    required this.localTime,
    required this.temperatureC,
    required this.temperatureF,
    required this.isDay,
    required this.conditionText,
    required this.conditionIcon,
    required this.conditionCode,
    required this.windMph,
    required this.windKph,
    required this.windDegree,
    required this.windDirection,
    required this.pressureMb,
    required this.pressureIn,
    required this.precipMm,
    required this.precipIn,
    required this.humidity,
    required this.cloud,
    required this.feelsLikeC,
    required this.feelsLikeF,
    required this.visibilityKm,
    required this.visibilityMiles,
    required this.uv,
    required this.gustMph,
    required this.gustKph,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    final location = json['location'] ?? {};
    final current = json['current'] ?? {};

    return WeatherData(
      locationName: location['name'] ?? 'Unknown',
      region: location['region'] ?? 'Unknown',
      country: location['country'] ?? 'Unknown',
      lat: location['lat'] ?? 0.0,
      lon: location['lon'] ?? 0.0,
      timezone: location['tz_id'] ?? 'Unknown',
      localTime: location['localtime'] ?? 'Unknown',
      temperatureC: current['temp_c'] ?? 0.0,
      temperatureF: current['temp_f'] ?? 0.0,
      isDay: current['is_day'] ?? false,
      conditionText: current['condition']['text'] ?? 'No condition available',
      conditionIcon: current['condition']['icon'] ?? '',
      conditionCode: current['condition']['code'] ?? 0,
      windMph: current['wind_mph'] ?? 0.0,
      windKph: current['wind_kph'] ?? 0.0,
      windDegree: current['wind_degree'] ?? 0,
      windDirection: current['wind_dir'] ?? 'Unknown',
      pressureMb: current['pressure_mb'] ?? 0.0,
      pressureIn: current['pressure_in'] ?? 0.0,
      precipMm: current['precip_mm'] ?? 0.0,
      precipIn: current['precip_in'] ?? 0.0,
      humidity: current['humidity'] ?? 0,
      cloud: current['cloud'] ?? 0,
      feelsLikeC: current['feelslike_c'] ?? 0.0,
      feelsLikeF: current['feelslike_f'] ?? 0.0,
      visibilityKm: current['vis_km'] ?? 0.0,
      visibilityMiles: current['vis_miles'] ?? 0.0,
      uv: current['uv'] ?? 0,
      gustMph: current['gust_mph'] ?? 0.0,
      gustKph: current['gust_kph'] ?? 0.0,
    );
  }
}