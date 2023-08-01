import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'screens/GeolocatorWidget.dart';
import 'screens/weather_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.montserratTextTheme(),
      // primarySwatch: Colors.indigo,
      // brightness: Brightness.dark,
       // colorScheme: ColorScheme.fromSeed(primary: Colors.black, seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: WeatherScreen(),
    );
  }
}
