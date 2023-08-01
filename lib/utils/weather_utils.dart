import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import '../models/weather.dart';
import 'package:http/http.dart' as http;

class WeatherUtils {
  static String _apikey = "c408b820470d408984293434220304";

  static Future<Position> determineCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  static Future<Weather> getCurrentPositioWeather() async {
    return getWeatherInfo(await determineCurrentPosition());
  }

  static Future<Weather> getWeatherInfo(Position position) async {
    var path =
        "https://api.weatherapi.com/v1/forecast.json?key=$_apikey&q=${position.latitude},${position.longitude}&days=1&aqi=no&alerts=no&lang=fr";
    print(path);
    var url = Uri.parse(path);

    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      return Weather.fromJson(jsonResponse);
    } else {
      return Future.error(
          'Request failed with status: ${response.statusCode}.');
    }
  }
}
