import 'package:flutter/material.dart';
import 'package:clima_app/utilities/constants.dart';
import 'package:clima_app/services/weather.dart';
import 'package:clima_app/screens/city_screen.dart';

class LocationScreen extends StatefulWidget {
  final inputFromLoadingScreen;
  LocationScreen({this.inputFromLoadingScreen});

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  int temperature = 0;
  String? cityName;
  String? weatherIcon;
  String? weatherMessage;
  WeatherModel weatherModel = WeatherModel();

  @override
  void initState() {
    //linking to parent LocationScreen stateful widget with widget keyword
    updateUI(widget.inputFromLoadingScreen);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      temperature = (weatherData['current']['temp']).round();
      cityName = weatherData['timezone'];
      int weatherID = weatherData['current']['weather'][0][
          'id']; //lives only in updateUI and used for weatherIcon which is global

      // getting weather icon
      weatherIcon = weatherModel.getWeatherIcon(weatherID);

      // get weather message
      weatherMessage = weatherModel.getWeatherMessage(temperature);
    });
  }

  // json weather data is different based on city search, hence I created another method
  void updateUIbasedonCityData(dynamic weatherData) {
    setState(() {
      temperature = (weatherData['main']['temp']).round();
      cityName = weatherData['name'];
      int weatherID = weatherData['weather'][0]['id'];
      //lives only in updateUI and used for weatherIcon which is global

      // getting weather icon
      weatherIcon = weatherModel.getWeatherIcon(weatherID);

      // get weather message
      weatherMessage = weatherModel.getWeatherMessage(temperature);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  //Getting current location weather anytime, after searching for another city and then getting back to current
                  TextButton(
                    onPressed: () async {
                      var weatherData = await weatherModel.getWeatherData();
                      updateUI(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      var cityNameCaptured = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return CityScreen();
                          },
                        ),
                      );

                      if (cityNameCaptured != null) {
                        //testing
                        print(cityNameCaptured);

                        var weatherCityData =
                            await weatherModel.getCityData(cityNameCaptured);
                        updateUIbasedonCityData(weatherCityData);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      '$weatherIcon',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "$weatherMessage in $cityName!",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
