import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() => runApp(const LocationScreen());

class LocationScreen extends StatelessWidget {
  const LocationScreen({key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Google Maps Demo',
      debugShowCheckedModeBanner: false,
      home: MapSample(),
    );
  }
}

class MapSample extends StatefulWidget {
  const MapSample({key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  late LatLng _currentPosition;
  final Completer<GoogleMapController> _controller = Completer();

  CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  void initState() {
    // getCurrentLocation();
    super.initState();
  }

  // Future<void> getCurrentLocation() async {
  //   Location location = Location(latitude: null);
  //
  //   bool serviceEnabled;
  //   PermissionStatus permissionStatus;
  //   LocationData locationData;
  //
  //   serviceEnabled = await location.serviceEnabled();
  //   if (!serviceEnabled) {
  //     serviceEnabled = await location.requestService();
  //     if (!serviceEnabled) {
  //       return;
  //     }
  //   }
  //
  //   permissionStatus = await location.hasPermission();
  //   if (permissionStatus == PermissionStatus.denied) {
  //     permissionStatus = await location.requestPermission();
  //     if (permissionStatus != PermissionStatus.granted) {
  //       return;
  //     }
  //   }
  //
  //   locationData = await location.getLocation(); // --> current Location
  //   _currentPosition = LatLng(locationData.latitude!, locationData.longitude!);
  //
  //   _kGooglePlex = CameraPosition(
  //     target: _currentPosition,
  //     zoom: 14.4746,
  //   );
  //
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: _kGooglePlex,
          markers: <Marker>{_setMarker()},
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterFloat,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: _goToTheLake,
          label: const Text('To the lake!'),
          icon: const Icon(Icons.directions_boat),
        ),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }

  Marker _setMarker() {
    LatLng singaDurbarPosition =
        const LatLng(27.69803150917992, 85.32388744895596);
    const double hueRed = 0.0;
    const double hueOrange = 30.0;
    const double hueGreen = 120.0;
    const double hueCyan = 180.0;
    const double hueAzure = 210.0;
    const double hueBlue = 240.0;
    const double hueViolet = 270.0;
    const double hueMagenta = 300.0;
    const double hueRose = 330.0;
    const double hueYellow = 60.0;
    return Marker(
        markerId: const MarkerId("gongabu_branch"),
        icon: BitmapDescriptor.defaultMarkerWithHue(hueGreen),
        position: _currentPosition);
  }
}
