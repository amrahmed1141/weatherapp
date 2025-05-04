import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:weatherapp/api/fetch_weather.dart';
import 'package:weatherapp/model/weather_data.dart';

class GlobalController extends GetxController {
  // create various variables
  final RxBool _isLoading = true.obs;
  final RxDouble _lattitude = 0.0.obs;
  final RxDouble _longitude = 0.0.obs;
  

  // instance for them to be called
  RxBool checkLoading() => _isLoading;
  RxDouble getLattitude() => _lattitude;
  RxDouble getLongitude() => _longitude;

  final weatherData = Rxn<WeatherData>();

  WeatherData? getData() {
    return weatherData.value;
  }

  @override
  void onInit() {
    if (_isLoading.isTrue) {
      getLocation();
    }
    super.onInit();
  }

  getLocation() async {
    try {
      bool isServiceEnabled;
      LocationPermission locationPermission;

      isServiceEnabled = await Geolocator.isLocationServiceEnabled();
      // return if service is not enabled
      if (!isServiceEnabled) {
        _isLoading.value = false;
        return Future.error("Location not enabled");
      }

      // status of permission
      locationPermission = await Geolocator.checkPermission();

      if (locationPermission == LocationPermission.deniedForever) {
        _isLoading.value = false;
        return Future.error("Location permission are denied forever");
      } else if (locationPermission == LocationPermission.denied) {
        locationPermission = await Geolocator.requestPermission();
        if (locationPermission == LocationPermission.denied) {
          _isLoading.value = false;
          return Future.error("Location permission is denied");
        }
      }

      // getting the current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high
      );
      
      print('Got position: ${position.latitude}, ${position.longitude}');
      
      // update our variables
      _lattitude.value = position.latitude;
      _longitude.value = position.longitude;

      // calling our weather api
      try {
        final weather = await FetchWeatherAPI().processData(
          position.latitude, 
          position.longitude
        );
        weatherData.value = weather;
      } catch (e) {
        print('Error fetching weather: $e');
        throw Exception('Failed to fetch weather data: $e');
      } finally {
        _isLoading.value = false;
      }
    } catch (e) {
      _isLoading.value = false;
      print("Error in getLocation: $e");
      rethrow;
    }
  }

  
}
