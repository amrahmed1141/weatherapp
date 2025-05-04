import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/controller/global_controller.dart';

class HeaderWidget extends StatefulWidget {
  const HeaderWidget({super.key});

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  String city = '';
  String date = DateFormat('yMMMMd').format(DateTime.now()).toString();

  final GlobalController globalController = Get.put(GlobalController());

  @override
  void initState() {
    getGeoCode(globalController.getLattitude().value,
        globalController.getLongitude().value);
    super.initState();
    // Initialize your state here
  }

  void getGeoCode(lan, lon) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lan, lon);
    Placemark place = placemarks[0];
    setState(() {
      city = place.locality!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          alignment: Alignment.topLeft,
          child: Text(
            city,
            style: const TextStyle(
                color: Colors.white, fontSize: 35, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 10),
          alignment: Alignment.topLeft,
          child: Text(
            date,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ],
    );
  }
}
