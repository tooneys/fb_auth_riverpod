import 'package:fb_auth_riverpod/models/location.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import '../../repositories/handle_exception.dart';

class Location {
  Future<Locate> getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    try {
      Position position = await Geolocator.getCurrentPosition();

      return Locate(
        name: 'Currnet',
        lat: position.latitude,
        lng: position.longitude,
      );
    } catch (e) {
      print('error : $e');
      throw handleException(e);
    }
  }

  Future<List<Locate>> getOpenLocate() async {
    final initLocate = [
      const Locate(name: '대륭포스트타워5차', lat: 37.4811, lng: 126.8865),
      const Locate(name: '애슐리퀸즈 가산점', lat: 37.4769, lng: 126.8868),
      const Locate(name: '철산역 7호선', lat: 37.4764, lng: 126.8685),
      const Locate(name: '유플래닛데시앙', lat: 37.4194, lng: 126.8813),
      const Locate(name: '광명KTX역', lat: 37.4165, lng: 126.8848),
    ];

    return initLocate;
  }
}

double calcDistance(Locate loc1, Locate loc2) {
  Distance distance = const Distance();
  final double km = distance.distance(
        LatLng(loc1.lat, loc1.lng),
        LatLng(loc2.lat, loc2.lng),
      ) /
      1000.00;

  return km;
}
