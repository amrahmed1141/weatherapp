import 'package:flutter/material.dart';
import 'package:weatherapp/model/weather_data_current.dart';

class CurrentWeatherwidget extends StatelessWidget {
  const CurrentWeatherwidget({super.key, required this.currentWeatherData});
  final WeatherDataCurrent currentWeatherData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// temp area
        tempArea(),
        const SizedBox(
          height: 20,
        ),
        /// temp details , wind speed , humidity
        tempDetails(),
      ],
    );
  }

  Widget tempArea() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.asset(
            'assets/weather/${currentWeatherData.current.weather![0].icon}.png',
          ),
          Container(
            width: 1.5,
            height: 50,
            color: Colors.white,
          ),
          Text.rich(
            TextSpan(
              text: '${currentWeatherData.current.temp?.round()}' + '°C',
              style: const TextStyle(color: Colors.white, fontSize: 50),
              children: [
                TextSpan(
                  text: '${currentWeatherData.current.weather![0].main}',
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget tempDetails() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                padding:  const EdgeInsets.all(8.0),
                child: Image.asset(
                  'assets/icons/windspeed.png',
                  height: 50,
                  width: 50,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text('${currentWeatherData.current.windSpeed}'+' km/h',
                style: const TextStyle(color: Colors.white, fontSize: 14)),
          ],
        ),
        Column(
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                padding:  const EdgeInsets.all(8.0),
                child: Image.asset(
                  'assets/icons/clouds.png',
                  height: 50,
                  width: 50,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text('${currentWeatherData.current.clouds}'+' %',
                style: const TextStyle(color: Colors.white, fontSize: 14)),
          ],
        ),
        Column(
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                padding:  const EdgeInsets.all(8.0),
                child: Image.asset(
                  'assets/icons/humidity.png',
                  height: 50,
                  width: 50,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text('${currentWeatherData.current.humidity}'+' %',
                style: const TextStyle(color: Colors.white, fontSize: 14)),
          ],
        ),
      ],
    );
  }
}
