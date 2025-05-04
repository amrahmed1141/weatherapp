import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:weatherapp/controller/global_controller.dart';
import 'package:weatherapp/widgets/current_weather_widget.dart';
import 'package:weatherapp/widgets/daily_weather_widget.dart';
import 'package:weatherapp/widgets/header_widget.dart';
import 'package:weatherapp/widgets/sleek_circular_widget.dart';
import 'package:weatherapp/widgets/weather_hour_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalController globalController = Get.put(GlobalController());
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.black,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          systemOverlayStyle:
              const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
        ),
        body: Padding(
          padding: const EdgeInsets.all(0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Stack(children: [
              Align(
                alignment: const Alignment(3, -0.3),
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.deepPurple),
                ),
              ),
              Align(
                alignment: const Alignment(-3, -0.3),
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.deepPurple),
                ),
              ),
              Align(
                alignment: const Alignment(0, -1.2),
                child: Container(
                  height: 300,
                  width: 600,
                  decoration: const BoxDecoration(
                      shape: BoxShape.rectangle, color: Color(0xFFFFAB40)),
                ),
              ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                child: Container(
                  decoration: const BoxDecoration(color: Colors.transparent),
                ),
              ),
              SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Obx(() {
                    if (globalController.checkLoading().isTrue) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final weatherData = globalController.getData();
                    if (weatherData == null) {
                      return const Center(
                          child: Text('Failed to load weather data'));
                    }

                    return Center(
                      child: ListView(
                        scrollDirection: Axis.vertical,
                        children: [
                          const HeaderWidget(),
                          CurrentWeatherwidget(
                            currentWeatherData:
                                weatherData.getCurrentWeather()!,
                          ),
                          WeatherHourWidget(
                            weatherDataHourly: weatherData.getHourlyWeather(),
                          ),
                          const SizedBox(height: 15,),
                          DailyWeatherWidget(
                            weatherDataDaily: weatherData.getDailyWeather(),
                          ),
                          Divider( color: Colors.white.withOpacity(0.2)),
                          SleekCircular(currentWeatherData: weatherData.getCurrentWeather()!)
                        ],
                      ),
                    );
                  }))
            ]),
          ),
        ),
      ),
    );
  }
}
