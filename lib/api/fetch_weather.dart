import 'dart:convert';
import 'package:weatherapp/api/api_key.dart';
import 'package:weatherapp/model/weather_data.dart';
import 'package:weatherapp/model/weather_data_current.dart';
import 'package:weatherapp/model/weather_data_daily.dart';
import 'package:weatherapp/model/weather_data_hourly.dart';
import 'package:http/http.dart' as http;

class FetchWeatherAPI {
  WeatherData? weatherData;

  // procecssing the data from response -> to json
  Future<WeatherData> processData(lat, lon) async {
    try {
      print('Fetching weather data for lat: $lat, lon: $lon');
      var response = await http.get(Uri.parse(apiURL(lat, lon)));
      print('API Response status: ${response.statusCode}');
      print('API Response body: ${response.body}');
      
      if (response.statusCode != 200) {
        throw Exception('Failed to load weather data: ${response.statusCode}');
      }
      
      var jsonString = jsonDecode(response.body);
      print('Parsed JSON: $jsonString');
      
      if (jsonString == null) {
        throw Exception('Failed to parse weather data');
      }
      
      weatherData = WeatherData(
        WeatherDataCurrent.fromJson(jsonString),
        WeatherDataHourly.fromJson(jsonString),
        WeatherDataDaily.fromJson(jsonString)
      );
      
      return weatherData!;
    } catch (e) {
      print('Error in processData: $e');
      rethrow;
    }
  }
}

String apiURL(var lat, var lon) {
  String url;
  url =
      'https://api.openweathermap.org/data/3.0/onecall?lat=$lat&lon=$lon&exclude=minutely&appid=$apiKey&units=metric';
  return url;
}
