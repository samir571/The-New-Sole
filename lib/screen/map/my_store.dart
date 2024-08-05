import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyStoreLocation extends StatefulWidget {
  const MyStoreLocation({key});
  static const String route = "/MyStore";

  @override
  State<MyStoreLocation> createState() => _MyStoreLocationState();
}

class _MyStoreLocationState extends State<MyStoreLocation> {
  GoogleMapController? mapController;
  Set<Marker> markers = {};
  LatLng myLocation = const LatLng(27.674961, 85.358988);

  @override
  void initState() {
    markers.add(Marker(
      //add marker on google map
      markerId: MarkerId(myLocation.toString()),
      position: myLocation, //position of marker
      infoWindow: const InfoWindow(
        //popup info
        title: 'The New Sole',
        snippet: 'The New Sole',
      ),
      icon: BitmapDescriptor.defaultMarker, //icon for maker
    ));

    markers.add(Marker(
      //add marker on google map
      markerId: MarkerId(myLocation.toString()),
      position: const LatLng(27.674811, 85.356590),
      //position of marker
      infoWindow: const InfoWindow(
        //popup info
        title: 'PNP',
        snippet: 'PNP',
      ),
      icon: BitmapDescriptor.defaultMarker, //icon for maker
    ));

    markers.add(Marker(
      //add marker on google map
      markerId: MarkerId(myLocation.toString()),
      position: const LatLng(27.677370, 85.359788),
      //position of marker
      infoWindow: const InfoWindow(
        //popup info
        title: 'Drishya Hotel',
        snippet: 'Drishya Hotel',
      ),
      icon: BitmapDescriptor.defaultMarker, //icon for maker
    ));

    markers.add(Marker(
      //add marker on google map
      markerId: MarkerId(myLocation.toString()),
      position: const LatLng(27.672161, 85.366496),
      //position of marker
      infoWindow: const InfoWindow(
        //popup info
        title: 'Big MArt',
        snippet: 'BIg Mart',
      ),
      icon: BitmapDescriptor.defaultMarker, //icon for maker
    ));

    markers.add(Marker(
      //add marker on google map
      markerId: MarkerId(myLocation.toString()),
      position: const LatLng(27.671430, 85.357209),
      //position of marker
      infoWindow: const InfoWindow(
        //popup info
        title: 'Bhatbhateni',
        snippet: 'Bhatbhateni',
      ),
      icon: BitmapDescriptor.defaultMarker, //icon for maker
    ));

    markers.add(Marker(
      //add marker on google map
      markerId: MarkerId(myLocation.toString()),
      position: const LatLng(27.676929, 85.353074),
      //position of marker
      infoWindow: const InfoWindow(
        //popup info
        title: 'Nilesh pani Puri PAsal',
        snippet: 'Special Panipuri',
      ),
      icon: BitmapDescriptor.defaultMarker, //icon for maker
    ));

    markers.add(Marker(
      //add marker on google map
      markerId: MarkerId(myLocation.toString()),
      position: const LatLng(27.691452, 85.403689),
      //position of marker
      infoWindow: const InfoWindow(
        //popup info
        title: 'Chaudhary sweets',
        snippet: 'Authenticate sweets',
      ),
      icon: BitmapDescriptor.defaultMarker, //icon for maker
    ));

    markers.add(Marker(
      //add marker on google map
      markerId: MarkerId(myLocation.toString()),
      position: const LatLng(27.691452, 85.403689),
      //position of marker
      infoWindow: const InfoWindow(
        //popup info
        title: 'Khanal Banquet',
        snippet: 'Best Banquet in town',
      ),
      icon: BitmapDescriptor.defaultMarker, //icon for maker
    ));

    markers.add(Marker(
      //add marker on google map
      markerId: MarkerId(myLocation.toString()),
      position: const LatLng(27.678905, 85.356157),
      //position of marker
      infoWindow: const InfoWindow(
        //popup info
        title: 'Softwarica College',
        snippet: 'Softwarica College',
      ),
      icon: BitmapDescriptor.defaultMarker, //icon for maker
    ));

    markers.add(Marker(
      //add marker on google map
      markerId: MarkerId(myLocation.toString()),
      position: const LatLng(27.720821, 85.153684),
      //position of marker
      infoWindow: const InfoWindow(
        //popup info
        title: 'Gypsy Branch',
        snippet: 'Gypsy Branch',
      ),
      icon: BitmapDescriptor.defaultMarker, //icon for maker
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Gypsy Store'),
          centerTitle: true,
          backgroundColor: const Color(0XFFFC6011),
        ),
        body: GoogleMap(
          zoomGesturesEnabled: true,
          initialCameraPosition: CameraPosition(
            target: myLocation,
            zoom: 14,
          ),
          markers: markers,
          mapType: MapType.normal,
          onMapCreated: (controller) {
            setState(() {
              mapController = controller;
            });
          },
        ));
  }
}
