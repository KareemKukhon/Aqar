import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Signup/signup_screen.dart';
import 'package:flutter_auth/Screens/addpage/add.dart';
import 'package:flutter_auth/Screens/addpage/components/addPage.dart';
import 'package:flutter_auth/Screens/navbar/bottom_bar.dart';
import 'package:flutter_auth/Screens/profilepage/editProfile.dart';
import 'package:flutter_auth/constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter_auth/main.dart';

class pickLocationScreen extends StatefulWidget {
  @override
  _pickLocationScreenState createState() => _pickLocationScreenState();
}

class _pickLocationScreenState extends State<pickLocationScreen> {
  GoogleMapController? _mapController;
  TextEditingController _searchController = TextEditingController();
  Marker? _searchedMarker;
  LatLng _manualMarkerPosition = LatLng(0, 0);

  // Variable to store the selected location
  LatLng? _selectedLocation;

  @override
  Widget build(BuildContext context) {
    Set<Marker> markers = {};
    if (_searchedMarker != null) {
      markers.add(_searchedMarker!);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Google Maps with Search'),
        actions: [
          IconButton(
            icon: Icon(Icons.done),
            onPressed: () {
              // Save the last selected location to the variable
              setState(() {
                _selectedLocation = _manualMarkerPosition;
              });
              // Do anything else you need with the selected location

              print("Selected Location (Done): $_selectedLocation");
              Navigator.pop(context, _selectedLocation);
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (controller) => _mapController = controller,
            initialCameraPosition: CameraPosition(
              target: LatLng(0, 0), // Default position
              zoom: 15,
            ),
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            markers: markers,
          ),
          Positioned(
            top: 10,
            left: 10,
            right: 10,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search for a location',
                      fillColor: Colors.white,
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(10),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {
                          searchLocation();
                        },
                      ),
                    ),
                  ),
                  Container(
                    width: 250,
                    child: ElevatedButton(
                      onPressed: () {
                        // You can use _manualMarkerPosition.latitude and _manualMarkerPosition.longitude
                        // for the selected location from manual drag-and-drop
                        print(
                            "Selected Location (Manual): $_manualMarkerPosition");
                      },
                      child: Text('Use Manual Marker Location' , style: TextStyle(color: Colors.white),),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> searchLocation() async {
    String address = _searchController.text;
    print(address);
    try {
      List<Location> locations = await locationFromAddress(address);

      if (locations != null && locations.isNotEmpty) {
        Location location = locations[0];
        LatLng searchedLatLng = LatLng(location.latitude, location.longitude);

        // Update the camera position
        _mapController!.animateCamera(CameraUpdate.newLatLng(searchedLatLng));

        // Update the manual marker position
        setState(() {
          _manualMarkerPosition = searchedLatLng;
          _searchedMarker = Marker(
            markerId: MarkerId('searched_location'),
            position: searchedLatLng,
            draggable: true,
            onDragEnd: (newPosition) {
              setState(() {
                _manualMarkerPosition = newPosition;
              });
            },
            infoWindow: InfoWindow(
              title: 'Searched Location',
              snippet: address,
            ),
          );
        });
        print("-----------------------------");
        print(searchedLatLng);
        print("-----------------------------");
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
