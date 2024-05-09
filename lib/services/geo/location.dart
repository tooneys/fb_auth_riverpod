import 'package:fb_auth_riverpod/models/location.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import '../../repositories/handle_exception.dart';

class LocationService {
  Future<Locate> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    try {
      final position = await Geolocator.getCurrentPosition();
      return Locate(
        name: 'Current',
        lat: position.latitude,
        lng: position.longitude,
      );
    } catch (e) {
      throw handleException(e);
    }
  }

  Future<List<Locate>> getOpenLocations() async {
    const initLocations = [
      Locate(name: '대륭포스트타워5차', lat: 37.4811, lng: 126.8865),
      Locate(name: '애슐리퀸즈 가산점', lat: 37.4769, lng: 126.8868),
      Locate(name: '철산역 7호선', lat: 37.4764, lng: 126.8685),
      Locate(name: '유플래닛데시앙', lat: 37.4194, lng: 126.8813),
      Locate(name: '광명KTX역', lat: 37.4165, lng: 126.8848),
    ];
    return initLocations;
  }
}

double calcDistance(Locate loc1, Locate loc2) {
  const distance = Distance();
  final double km = distance.distance(
        LatLng(loc1.lat, loc1.lng),
        LatLng(loc2.lat, loc2.lng),
      ) /
      1000.00;
  return km;
}
