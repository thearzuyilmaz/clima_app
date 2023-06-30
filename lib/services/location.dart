import 'package:geolocator/geolocator.dart';

class Location {
  double? latitude;
  double? longitude;

  // assigning longitude & latitude to the new values based on geolocator data
  Future<void> getCurrentLocation() async {
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

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);

    latitude = position.latitude;
    longitude = position.longitude;

    // converting to 2 decimal double
    // The ! after the nullable variables is the "null assertion operator"
    // and is used to tell the Dart analyzer that we know the value won't be
    // null at that point.
    latitude = double.parse(latitude!.toStringAsFixed(2));
    longitude = double.parse(longitude!.toStringAsFixed(2));

    // print('Data was taken from geolocator package');
    // print('The latitude is $latitude');
    // print('The longitude is $longitude');
  }
}
