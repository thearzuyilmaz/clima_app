import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherData {
  final String dataUrl;
  WeatherData(this.dataUrl);

  Future getDecodedWeatherData() async {
    var url = Uri.parse(dataUrl);

    // Send an HTTP GET request
    http.Response response = await http.get(url);
    String data = response.body;
    var decodedData = jsonDecode(data); //decoding json

    return decodedData;
  }
}

// ------ Sample data calling format --------

// double temp = decodedData['current']['temp'];
// String description = decodedData['current']['weather'][0]['description'];
