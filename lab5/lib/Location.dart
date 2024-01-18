import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as l;

class Locations extends StatelessWidget {
  double? longitude;
  double? latitude;
  String country;
  Locations(this.longitude, this.latitude, this.country) {
    Timer(Duration(seconds: 1), () {
      // Code to run after 2 seconds
      print(longitude);
      print(latitude);
    });
  }

  // @override
  // Widget build(BuildContext context) {
  //   return FlutterMap(
  //     options: MapOptions(
  //       // ignore: prefer_const_constructors
  //       center:
  //           l.LatLng(/*latitude ??*/ 42.0041836, /*longitude ??*/ 21.3767336),
  //       zoom: 80,
  //     ),
  //     nonRotatedChildren: [
  //       AttributionWidget.defaultWidget(
  //         source: 'OpenStreetMap contributors',
  //         onSourceTapped: null,
  //       ),
  //     ],
  //     children: [
  //       TileLayer(
  //         //urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
  //         urlTemplate: 'https://www.openstreetmap.org/#map=9/41.6154/21.7514',
  //         userAgentPackageName: 'com.example.app',
  //       ),
  //     ],
  //   );
  // }
  final l.LatLng initialLocation = l.LatLng(42.0041836,
      21.3767336); // Replace with your desired latitude and longitude
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Current location'),
      ),
      body: FlutterMap(
        options: MapOptions(
          center: initialLocation,
          zoom: 13.0,
        ),
        nonRotatedChildren: [
          TileLayer(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
          ),
          MarkerLayer(
            markers: [
              Marker(
                width: 40.0,
                height: 40.0,
                point: initialLocation,
                builder: (ctx) => Container(
                  child: Icon(
                    Icons.location_pin,
                    color: Colors.red,
                    size: 40.0,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
