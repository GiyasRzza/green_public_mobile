import 'Current.dart';

class WeatherData {
  final String locationName;
  final String region;
  final String country;
  final double lat;
  final double lon;
  final String timezoneId;
  final int localTimeEpoch;
  final String localTime;
  final Current current;

  WeatherData({
    required this.locationName,
    required this.region,
    required this.country,
    required this.lat,
    required this.lon,
    required this.timezoneId,
    required this.localTimeEpoch,
    required this.localTime,
    required this.current,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      locationName: json['location']['name'],
      region: json['location']['region'],
      country: json['location']['country'],
      lat: json['location']['lat'],
      lon: json['location']['lon'],
      timezoneId: json['location']['tz_id'],
      localTimeEpoch: json['location']['localtime_epoch'],
      localTime: json['location']['localtime'],
      current: Current.fromJson(json['current']),
    );
  }
}
