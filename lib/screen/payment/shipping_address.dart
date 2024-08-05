import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gypsy/model/user.dart';
import 'package:gypsy/repository/user_repository.dart';
import 'package:gypsy/response/user_response.dart';

class ShippingInfo extends StatefulWidget {
  const ShippingInfo({key});

  @override
  State<ShippingInfo> createState() => ShippingInfoState();
}

class ShippingInfoState extends State<ShippingInfo> {
  String location = '';
  String address = '';

  Future<Position> getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<void> getAddressFromLatLong(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    setState(() {
      Placemark place = placemarks[0];
      print("The place is: -->$place");
      address =
          '${place.subLocality}, ${place.thoroughfare}, ${place.locality}';
      // getCurrentLocation = address;
    });
  }

  void setAddress() async {
    final Position position = await getGeoLocationPosition();
    setState(() {
      getAddressFromLatLong(position);
    });
  }

  @override
  void initState() {
    setAddress();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: 27,
                      color: Color(0XFFFC6011),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: const BoxDecoration(),
                          child: const Text(
                            'Shipping Address',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(address,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                            textAlign: TextAlign.left

                            // controller: _shippingAddressController,
                            ),
                      ],
                    ),
                  ],
                ),
                const Divider(),
                const SizedBox(
                  height: 10.0,
                ),
                ////
                getShippingInfo(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  locationInfo() {
    if (address.isEmpty) {
      return 'Locating you..';
    } else {
      return address;
    }
  }

  FutureBuilder<UserResponse?> getShippingInfo() {
    return FutureBuilder<UserResponse?>(
        future: UserRepository().getUserProfile(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            User? userInfo = snapshot.data!.data!;
            return Row(
              children: [
                const Icon(
                  Icons.phone,
                  size: 25,
                  color: Color(0XFFFC6011),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: const BoxDecoration(),
                      child: const Text(
                        'Phone Number',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                        userInfo.phoneNumber!.isEmpty
                            ? 'null'
                            : userInfo.phoneNumber!,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                        textAlign: TextAlign.left

                        // controller: _shippingAddressController,
                        ),
                  ],
                ),
              ],
            );
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}
