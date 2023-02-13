import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';

class PathSearchController {
  PathSearchController._privateConstructor();

  static final PathSearchController instance = PathSearchController._privateConstructor();

  Future<Map<String, double>> getCurrentLocation() async {
    final lastPosition = await Geolocator().getLastKnownPosition();
    Map<String, double> currentLocation = {
      'latitude': lastPosition.latitude,
      'longitude': lastPosition.longitude
    };

    return currentLocation;
  }

  Future<List<Address>> getDestinationCoordinates(String destination) async {
    final addresses = await Geocoder.local.findAddressesFromQuery(destination);

    return addresses;
  }
}
