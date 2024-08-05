import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gypsy/constraints/constraints.dart';
import 'package:gypsy/screen/payment/payment.dart';
import 'package:location/location.dart' as loc;

class CurrentLocationScreen extends StatefulWidget {
  const CurrentLocationScreen({Key? key}) : super(key: key);

  @override
  _CurrentLocationScreenState createState() => _CurrentLocationScreenState();
}

class _CurrentLocationScreenState extends State<CurrentLocationScreen> {
  loc.LocationData? currentPosition;
  loc.Location location = loc.Location();
  LatLng curLocation = LatLng(23.0525, 72.5667);
  LatLng destLocation = LatLng(23.0525, 72.5667);
  final Completer<GoogleMapController> _controller = Completer();
  String address = '';

  static const CameraPosition initialCameraPosition = CameraPosition(
      target: LatLng(37.42796133580664, -122.085749655962), zoom: 14);

  Set<Marker> markers = {};

  @override
  void initState() {
    getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User current location"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          GoogleMap(
            markers: markers,
            initialCameraPosition: initialCameraPosition,
            zoomControlsEnabled: true,
            mapType: MapType.normal,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            onCameraMove: (CameraPosition? position) {
              if (destLocation != position!.target) {
                setState(() {
                  destLocation = position.target;
                });
              }
            },
            onCameraIdle: () {
              getAddressFromLatLong(
                  destLocation.latitude, destLocation.longitude);
            },
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(bottom: 35),
              child: Image(
                height: 45,
                width: 45,
                image: NetworkImage(
                    "https://png.pngtree.com/png-vector/20220912/ourmid/pngtree-vector-push-pin-paper-png-image_6172879.png"),
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => CheckoutPage()));
        },
        child: Icon(Icons.navigate_before),
      ),
    );
  }

  void getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error("Location permission denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied');
    }

    currentPosition = await location.getLocation();
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(currentPosition!.latitude!, currentPosition!.longitude!),
        zoom: 14)));

    setState(() {
      destLocation =
          LatLng(currentPosition!.latitude!, currentPosition!.longitude!);
    });
  }

  Future<void> getAddressFromLatLong(double latitude, double longitude) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latitude, longitude);
    setState(() {
      Placemark place = placemarks[0];
      print("The place is: -->$place");
      address =
          '${place.subLocality}, ${place.thoroughfare}, ${place.locality}';
      getUserPickedLocation = address;
    });
  }
}
