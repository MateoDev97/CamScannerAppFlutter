import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:qr_reader_app/models/scan_model.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  final Completer<GoogleMapController> mapController =
      Completer<GoogleMapController>();

  MapType mapType = MapType.normal;

  @override
  Widget build(BuildContext context) {
    final ScanModel scan =
        ModalRoute.of(context)?.settings.arguments as ScanModel;

    final CameraPosition startPoint =
        CameraPosition(target: scan.getLatLng(), zoom: 17, tilt: 50);

    Set<Marker> markers = <Marker>{};
    markers.add(Marker(
      markerId: const MarkerId('geo-locarion'),
      position: scan.getLatLng(),
    ));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Map'),
        actions: [
          IconButton(
            onPressed: () async {
              final GoogleMapController controller = await mapController.future;
              await controller
                  .animateCamera(CameraUpdate.newCameraPosition(startPoint));
            },
            icon: const Icon(Icons.location_searching),
          )
        ],
      ),
      body: GoogleMap(
        myLocationButtonEnabled: false,
        markers: markers,
        mapType: mapType,
        initialCameraPosition: startPoint,
        onMapCreated: (GoogleMapController controller) {
          mapController.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          mapType =
              (mapType == MapType.normal) ? MapType.satellite : MapType.normal;
          setState(() {});
        },
        child: const Icon(Icons.layers_rounded),
      ),
    );
  }
}
