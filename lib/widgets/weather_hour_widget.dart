import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/model/weather_data_hourly.dart';

class WeatherHourWidget extends StatelessWidget {
  final WeatherDataHourly? weatherDataHourly;
  const WeatherHourWidget({super.key, this.weatherDataHourly});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        const Text(
          'Today',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        hourWeatherDetails(),
      ],
    );
  }

  Widget hourWeatherDetails() {
    if (weatherDataHourly == null) {
      return Container(
        height: 150,
        child: const Center(
          child: Text(
            'Hourly forecast not available',
            style: TextStyle(color: Colors.white70),
          ),
        ),
      );
    }

    return Container(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: weatherDataHourly!.hourly.length > 12
            ? 12
            : weatherDataHourly!.hourly.length,
        itemBuilder: (context, index) {
          final hourly = weatherDataHourly!.hourly[index];
          return Container(
            height: 100,
            width: 100,
            margin: const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: HoursWeatherList(
              temp: hourly.temp?.round() ?? 0,
              timeStemp: hourly.dt ?? 0,
              weatherIcon: hourly.weather?.first.icon ?? '',
            ),
          );
        },
      ),
    );
  }
}

class HoursWeatherList extends StatelessWidget {
  const HoursWeatherList({
    super.key,
    required this.temp,
    required this.timeStemp,
    required this.weatherIcon,
  });

  final int temp;
  final int timeStemp;
  final String weatherIcon;

  String getFormattedTime(int timeStemp) {
    final DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(timeStemp * 1000);
    String t = DateFormat('jm').format(dateTime);
    return t;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 5,),
        Text(
          temp.toString()+'°C',
          style: const TextStyle(color: Colors.white),
        ),
        const SizedBox(height: 20,),
        Image.asset(
          'assets/weather/$weatherIcon.png',
          height: 50,
          width: 50,
        ),
        const SizedBox(height: 20,),
        Text(
          getFormattedTime(timeStemp),
          style: TextStyle(
            color: Colors.white,
          ),
        )
      ],
    );
  }
}
