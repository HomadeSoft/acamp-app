import 'package:campings_app/app/constants/app.strings.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class MapsService with ChangeNotifier {
  String finalAddress = Strings.searchingAddress;
  String? countryName;
  String mainAddress = Strings.messageSelectAddress;

  double intialLat = 0.00;
  double intialLong = 0.00;

  Future<LatLng> updateLocation() async {
    if (intialLat == 0.00 && intialLong == 0.00) {
      return getCurrentLocation();
    } else {
      return LatLng(intialLat, intialLong);
    }
  }

  Future<LatLng> getCurrentLocation() async {
    LocationPermission permission;
    bool serviceEnabled;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error(Strings.messageLocationServicesDisabled);
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error(Strings.messageLocationPermissionDenied);
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          Strings.messageLocationPermissionPermanentlyDenied);
    }

    var positionData = await GeolocatorPlatform.instance.getCurrentPosition();
    intialLat = positionData.latitude;
    intialLong = positionData.longitude;
    var address = await GeocodingPlatform.instance.placemarkFromCoordinates(
        positionData.latitude, positionData.longitude);
    String mainAddress = address.first.toString();
    finalAddress = mainAddress;
    notifyListeners();
    return LatLng(positionData.latitude, positionData.longitude);
  }
}
