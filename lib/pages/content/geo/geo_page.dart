import 'package:fb_auth_riverpod/config/router/router_names.dart';
import 'package:fb_auth_riverpod/pages/content/geo/geo_provider.dart';
import 'package:fb_auth_riverpod/pages/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../models/location.dart';
import '../../../models/search_location.dart';
import '../../../services/geo/location.dart';

class GeoLocationPage extends ConsumerWidget {
  const GeoLocationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initLocations = ref.watch(openLocateProvider);
    final location = ref.watch(geoProvider);

    List<SearchLocate> tempLocations = [];

    void getNearbyLocations(Locate currentLocation) {
      initLocations.whenOrNull(
        data: (initLocations) {
          tempLocations = initLocations
              .where((locate) => calcDistance(currentLocation, locate) <= 5.0)
              .map(
                (locate) => SearchLocate(
                  loc: locate,
                  km: calcDistance(currentLocation, locate),
                ),
              )
              .toList();
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Location Information'),
        actions: [
          IconButton(
            onPressed: () => ref.invalidate(geoProvider),
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: location.when(
        skipLoadingOnRefresh: false,
        data: (currentLocation) {
          getNearbyLocations(currentLocation);
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Current Location',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text('Name: ${currentLocation.name}'),
                Text('Latitude: ${currentLocation.lat}'),
                Text('Longitude: ${currentLocation.lng}'),
                const Divider(),
                const Text(
                  'Nearby Locations (within 5km)',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: tempLocations.length,
                    itemBuilder: (context, index) {
                      final location = tempLocations[index];
                      return Card(
                        child: ListTile(
                          title: Text(location.loc!.name),
                          subtitle: Text(
                            '거리: ${location.km.toStringAsFixed(2)} km',
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
        error: (error, _) => Center(child: Text('Error: $error')),
        loading: () => const Center(child: CustomLoader()),
      ),
    );
  }
}
