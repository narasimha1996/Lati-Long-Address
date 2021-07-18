// @dart=2.9

import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:geolocator/geolocator.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:geocoder/geocoder.dart';

void main() {
  runApp(MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: Currentlocation()));
}

class Currentlocation extends StatefulWidget {
  @override
  _CurrentlocationState createState() => _CurrentlocationState();
}

class _CurrentlocationState extends State<Currentlocation> {
  // ignore: unused_field
  String _coordinates = "";
  String straddress = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Geolocation"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_coordinates),
            SizedBox(
              height: 20,
            ),
            Text(straddress),

            // ignore: deprecated_member_use
            FlatButton(
              child: Text("Get GeoLocation"),
              onPressed: () {
                GetCurrentLocation();
              },
            ),
          ],
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  void GetCurrentLocation() async {
    // ignore: unused_local_variable
    final location = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _coordinates = "${location.latitude} ,${location.longitude}";
    });
    convertCoordinatesToAddress(
        Coordinates(location.latitude, location.longitude));
  }

  // ignore: non_constant_identifier_names

  convertCoordinatesToAddress(Coordinates cords) async {
    // ignore: unused_local_variable
    var addresses = await Geocoder.local.findAddressesFromCoordinates(cords);
    // ignore: unused_local_variable
    var first = addresses.first;
    setState(() {
      straddress = first.addressLine;
    });
  }
}
