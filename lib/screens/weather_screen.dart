import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geolocator_weather/components/weather_item_component.dart';
import '../models/weather.dart';

import '../utils/weather_utils.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  Weather? weather;

  List<Hour>? daysWeathers = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      body:SafeArea(
        child: SingleChildScrollView(
          child:  weather!=null?Column(


            children: <Widget>[
              Column(
                children: [
                  Container(

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        Text(
                          "${weather?.location?.name} ",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w800),
                        ),
                        SizedBox(height: 10,),
                        Image.network(
                            "https:${weather?.current?.condition?.icon}"),
                        SizedBox(height: 10,),
                        Text(
                          "${weather?.current?.feelslikeC}° C",
                          style: const TextStyle(
                            //  color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10,),
                        Text(
                          "${weather?.current?.condition?.text}",
                          style: const TextStyle(
                            //   color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10,),
                        Text(
                          "${weather?.location?.region} ",
                          style: const TextStyle(
                            //   color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    height: 200,
                    margin: EdgeInsets.all(10),
                    child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: daysWeathers!
                          .map((e) => Container(
                        width: MediaQuery.of(context).size.width/4,
                        margin: EdgeInsets.only(right:10),
                            child: WeatherItemComponent(
                        hourWeather: e,
                      ),
                          ))
                          .toList(),
                    ),
                  )
                ],
              )
            ],
          ):Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Weather", style: Theme.of(context).textTheme.headlineLarge,),
                Text("Tap on locate button"),
              ],
            ),
          ),
        ),
      )

     ,
      floatingActionButton: FloatingActionButton(
        //backgroundColor: Color(0xff551560),
        onPressed: () async {
          weather = await WeatherUtils.getCurrentPositioWeather();
          daysWeathers = weather?.forecast!.forecastday![0].hour;
          setState(() {});
        },
        tooltip: 'Increment',
        child: const Icon(Icons.my_location),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  String timeToHour(num millis) {
    var dt = DateTime.fromMillisecondsSinceEpoch(millis.toInt());

    return "${dt.hour} ${dt.second}";
  }
}
