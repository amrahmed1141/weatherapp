import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/model/weather_data_daily.dart';

class DailyWeatherWidget extends StatelessWidget {
  final WeatherDataDaily? weatherDataDaily;
  const DailyWeatherWidget({super.key, this.weatherDataDaily});

  String getDailyFormate(final day) {
    final DateTime date = DateTime.fromMillisecondsSinceEpoch(day * 1000);
    String d = DateFormat('EEEE').format(date);
    return d;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      height: 400,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(children: [
        const SizedBox(
          height: 10,
        ),
        Text(
          'Next Days',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        const SizedBox(
          height: 10,
        ),
        DailyDetailsWidget()
      ]),
    );
  }

  Widget DailyDetailsWidget() {
    return SizedBox(
      height: 300,
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: weatherDataDaily!.daily.length > 7
              ? 7
              : weatherDataDaily!.daily.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Container(
                  height: 60,
                  padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          getDailyFormate(weatherDataDaily!.daily[index].dt),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        Image.asset(
                          'assets/weather/${weatherDataDaily!.daily[index].weather![0].icon}.png',
                          height: 40,
                          width: 40,
                        ),
                        Text(
                          '${weatherDataDaily!.daily[index].temp!.max}°C',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ]),
                ),
                Divider(
                  color: Colors.white.withOpacity(0.2),
                  endIndent: 20,
                  indent: 20,
                ),
              ],
            );
          }),
    );
  }
}
