import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'location.dart';

part 'location_provider.g.dart';

@riverpod
LocationService location(LocationRef ref) {
  print('[locationProvider] initialized');

  ref.onDispose(() {
    print('[locationProvider] disposed');
  });
  return LocationService();
}
