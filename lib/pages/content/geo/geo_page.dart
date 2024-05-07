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
    List<SearchLocate> tempLocate = [];

    final initLocate = ref.watch(openLocateProvider);
    final location = ref.watch(geoProvider);

    void aroundLocate(Locate loc) {
      initLocate.whenOrNull(
        data: (initLocate) {
          tempLocate = [
            for (final locate in initLocate)
              if (calcDistance(loc, locate) <= 10.0)
                SearchLocate(
                  loc: locate,
                  km: calcDistance(loc, locate),
                )
          ];
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('위치정보 조회'),
        actions: [
          IconButton(
            onPressed: () {
              ref.invalidate(geoProvider);
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: location.when(
        data: (location) {
          aroundLocate(location);

          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    '현재 위도 경도 표기',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('위치 : ${location.name}'),
                  Text('latitude : ${location.lat}'),
                  Text('longitude : ${location.lng}'),
                  const Divider(),
                  const Text(
                    '10Km 이내의 위치정보 리스트',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: tempLocate.length,
                      itemBuilder: (context, index) {
                        final locate = tempLocate[index];

                        return ListTile(
                          title: Text(locate.loc!.name),
                          subtitle: Text(
                              'lat: ${locate.loc!.lat}, lng: ${locate.loc!.lng}, distance: ${locate.km}Km'),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => context.goNamed(RouterNames.home),
                      child: const Text('홈으로'),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        error: (error, _) => Center(child: Text('error: $error')),
        loading: () => const Center(child: CustomLoader()),
      ),
    );
  }
}
