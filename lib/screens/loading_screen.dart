import 'package:flutter/material.dart';
import 'package:clima_app/screens/location_screen.dart';
import 'package:clima_app/services/weather.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  void getData() async {
    WeatherModel weathermodel = WeatherModel();
    var weatherData = await weathermodel.getWeatherData();

    // Navigating to another page taking the data from this page
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(inputFromLoadingScreen: weatherData);
    }));
  }

  // works once the widget is created with run/hot restart
  @override
  void initState() {
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
