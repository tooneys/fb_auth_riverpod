import 'package:fb_auth_riverpod/models/location.dart';
import 'package:fb_auth_riverpod/services/geo/location_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'geo_provider.g.dart';

@riverpod
FutureOr<Locate> geo(GeoRef ref) {
  return ref.watch(locationProvider).getCurrentLocation();
}

@riverpod
FutureOr<List<Locate>> openLocate(OpenLocateRef ref) {
  return ref.watch(locationProvider).getOpenLocations();
}
