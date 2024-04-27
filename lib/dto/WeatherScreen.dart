import 'package:flutter/material.dart';

class WeatherScreen{
 late String greeting="";
 late String name="Baku";
 late String region="Baku";
 late String localDateTime="";
 late String weatherConditionText="Sunny";
 late Image weatherConditionIcon=Image.asset("images/sunny default icon.jpeg");
 late String temperatureC="20";
 late String precip_mm="";

 WeatherScreen(this.greeting, this.name, this.region, this.localDateTime,
      this.weatherConditionText, this.weatherConditionIcon,this.temperatureC,this.precip_mm);

 WeatherScreen.empty();
}