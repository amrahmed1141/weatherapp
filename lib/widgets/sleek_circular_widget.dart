import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:weatherapp/model/weather_data_current.dart';

class SleekCircular extends StatelessWidget {
  final WeatherDataCurrent currentWeatherData;
  const SleekCircular({super.key, required this.currentWeatherData});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Comfort Level',
          style: TextStyle(color: Colors.yellow, fontSize: 16),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          margin:
              const EdgeInsets.only(left: 20, right: 20, top: 1, bottom: 10),
          child: SizedBox(
              height: 180,
              child: Column(
                children: [
                  Center(
                    child: SleekCircularSlider(
                      min: 0,
                      max: 100,
                      initialValue:
                          currentWeatherData.current.humidity!.toDouble(),
                      appearance: CircularSliderAppearance(
                        animationEnabled: true,
                        customColors: CustomSliderColors(
                          progressBarColor: Colors.amber,
                        ),
                        size: 150,
                        infoProperties: InfoProperties(
                          bottomLabelText: 'Humidity',
                          bottomLabelStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                          mainLabelStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                          modifier: (double value) {
                            return '${value.round()}%';
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ],
    );
  }
}
