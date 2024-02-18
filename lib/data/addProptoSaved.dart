import 'dart:io';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class addToSaved {
  void createJsonData(
    final dynamic id,
    final String owner,
    final String imagePath,
    final String type,
    final String status,
    final dynamic bedroom,
    final dynamic bathroom,
    final dynamic garage,
    final String description,
    final String city,
    final LatLng location,
    final String homepic0,
    final String homepic1,
    final String homepic2,
    final String homepic3,
  ) {
    Map<String, dynamic> saveProp = {
      "id": id,
      "owner": owner,
      "imagePath": imagePath,
      "type": type,
      "status": status,
      "homepic0": homepic0,
      "homepic1": homepic1,
      "homepic2": homepic2,
      "homepic3": homepic3,
      "BedRoom": bedroom,
      "BathRoom": bathroom,
      "garage": garage,
      "Description": description,
      "location": location,
      "city": city
    };
    print(saveProp);
  }
}
