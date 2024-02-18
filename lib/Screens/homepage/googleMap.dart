import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_auth/constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';

class MapScreen extends StatefulWidget {
  final LatLng propertyLocation;

  MapScreen({required this.propertyLocation});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  Set<Marker> markers = Set();
  Set<Marker> myMarker = {};
  Set<Polyline> polylines = Set();
  List<LatLng> polylineCoordinates = [];
  late LatLng currentLocation = LatLng(32, 35);
  StreamSubscription<Position>? ps;
  var lat;
  var lang;

  @override
  void initState() {
    _getCurrentLocation();
    super.initState();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;
    }

    // Request location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return;
      }
    }
    ps = Geolocator.getPositionStream().listen((Position position) {
      lat = position.latitude;
      lang = position.longitude;
      log("lat: " + lat.toString());
      log("lang: " + lang.toString());
      currentLocation = LatLng(lat, lang);
      changeMarker(lat, lang);
      log("hi");
    });
  }

  changeMarker(newlat, newlong) {
    myMarker.remove(Marker(markerId: MarkerId("2")));
    LatLng point = LatLng(newlat, newlong);
    addMarker(point, "2");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor.withOpacity(0.5),
        iconTheme: IconThemeData(color: Colors.white),
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back),
        //   onPressed: () {
        //     Navigator.of(context).pop();
        //   },
        // ),
        title: Text(
          "Map screen",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: CameraPosition(
          target: LatLng(0, 0),
          zoom: 15,
        ),
        onMapCreated: (GoogleMapController controller) {
          mapController = controller;
          if (currentLocation != null) {
            log("message");
            searchLocation(widget.propertyLocation);
            // drawPolyline(currentLocation, widget.propertyLocation);
          }
        },
        markers: myMarker,
        polylines: polylines,
      ),
    );
  }

  Future<void> searchLocation(LatLng propertyLocation) async {
    if (currentLocation != null && propertyLocation != null) {
      mapController.moveCamera(
        CameraUpdate.newLatLngBounds(
          LatLngBounds(
            southwest: LatLng(
              currentLocation.latitude < propertyLocation.latitude
                  ? currentLocation.latitude
                  : propertyLocation.latitude,
              currentLocation.longitude < propertyLocation.longitude
                  ? currentLocation.longitude
                  : propertyLocation.longitude,
            ),
            northeast: LatLng(
              currentLocation.latitude > propertyLocation.latitude
                  ? currentLocation.latitude
                  : propertyLocation.latitude,
              currentLocation.longitude > propertyLocation.longitude
                  ? currentLocation.longitude
                  : propertyLocation.longitude,
            ),
          ),
          100.0,
        ),
      );
      await addMarker(propertyLocation, "1");
      log("${"currentLocation" + currentLocation.toString()}propertyLocation" +
          propertyLocation.toString());
          
      // await drawPolyline(currentLocation, propertyLocation);
      setState(() {
            
          });
    } else {
      print("----------------------");
      print(
          "No locations found for the addresses: $currentLocation, $propertyLocation");
      print("----------------------");
    }
  }

  Future <void> addMarker(LatLng position, String id) async {
    final marker = Marker(
      markerId: MarkerId(id),
      position: position,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta),
    );

    setState(() {
      myMarker.add(marker);
      
    });
  }

//   Future<void> drawPolyline(LatLng origin, LatLng destination) async {
//  polylineCoordinates.clear();
//     PolylinePoints polylinePoints = PolylinePoints();
    
//     PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
//       'AIzaSyBKOYQRXpICtJ-06H5vexrDk421y9ohKkw', // Replace with your API key
//       PointLatLng(origin.latitude, origin.longitude),
//       PointLatLng(destination.latitude, destination.longitude),
//       travelMode: TravelMode.driving,
//     );
//     if (result.points.isNotEmpty) {
//       result.points.forEach((PointLatLng point) {
//         polylineCoordinates.add(LatLng(point.latitude, point.longitude));
//       });

//       Polyline polyline = Polyline(
//         polylineId: PolylineId('polyline'),
//         color: kPrimaryColor,
//         width: 5,
//         points: polylineCoordinates,
//       );

//       setState(() {
//         log("polylineCoordinates" + polylineCoordinates.toString());
//         polylines.add(polyline);
//       });
//     }
//   }

  @override
  void dispose() {
    ps?.cancel(); // Cancel the stream subscription
    super.dispose();
  }
}
