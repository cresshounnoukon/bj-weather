import 'package:flutter/material.dart';

import '../models/weather.dart';

class WeatherItemComponent extends StatelessWidget {
  final Hour? hourWeather;
    WeatherItemComponent({super.key, this.hourWeather});

  @override
  Widget build(BuildContext context) {
    return Container(

      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),

      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Theme.of(context).primaryColor)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("${hourWeather?.time?.split(' ')[1]}",
              style: TextStyle(color: Colors.black, fontSize: 18)),

          Image.network("https:${hourWeather?.condition?.icon}"),

          Text("${hourWeather?.cloud}° C",
              style: TextStyle(color: Colors.black, fontSize: 18)),
        ],
      ),
    );
  }
}
