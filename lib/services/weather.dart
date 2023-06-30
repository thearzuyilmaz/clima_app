import 'package:clima_app/services/networking.dart';
import 'package:clima_app/services/location.dart';

const apiKEY = 'a1f6c70632465a89bbed7e608d30195f';
const openWeatherURL = 'https://api.openweathermap.org/data/2.5/onecall';
const openWeatherCityUrl = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future<dynamic> getCityData(String cityName) async {
    WeatherData weatherDataObject = WeatherData(
        '$openWeatherCityUrl?q=$cityName&appid=$apiKEY&units=metric');

    // returns decoded weather data, as it is a Future type return, await should be used
    var weatherData = await weatherDataObject.getDecodedWeatherData();

    return weatherData;
  }

  Future<dynamic> getWeatherData() async {
    Location location = Location();
    await location.getCurrentLocation(); // getting current longitude & latitude

    // testing
    print(location.latitude);
    print(location.longitude);

    // Weather Data based on current longitude & latitude
    WeatherData weatherDataObject = WeatherData(
        '$openWeatherURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKEY&units=metric');

    // returns decoded weather data, as it is a Future type return, await should be used
    var weatherData = await weatherDataObject.getDecodedWeatherData();

    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getWeatherMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
