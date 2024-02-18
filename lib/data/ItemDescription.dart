import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PropertyItem {
  final dynamic id;
  final String owner;
  final String imagePath;
  final String type;
  final String status;
  final dynamic bedroom;
  final dynamic bathroom;
  final dynamic garage;
  final String description;
  final String city;
  final dynamic area;
  final LatLng location;
  final String homepic0;
  final String homepic1;
  final String homepic2;
  final String homepic3;

  PropertyItem({
    required this.id,
    required this.owner,
    required this.imagePath,
    required this.type,
    required this.status,
    required this.bedroom,
    required this.bathroom,
    required this.garage,
    required this.description,
    required this.location,
    required this.city,
    required this.area,
    required this.homepic0,
    required this.homepic1,
    required this.homepic2,
    required this.homepic3,
    
  });
}
List<Map<String, dynamic>> ItemDescription() {
  // Create a list to store property records.
  List<Map<String, dynamic>> properties = [
    {
      "id": 1,
      "owner" : "Yaqeen",
      "city" : "Nablus",
      "url": "assets/images/house1.jpg",
      "homepic0": "assets/images/homepic0.png",
      "homepic1": "assets/images/homepic1.png",
      "homepic2": "assets/images/homepic2.png",
      "homepic3": "assets/images/homepic3.png",
      "type": "Home",
      "area": 1000,
      "status": "for sale",
      "BedRoom": 3,
      "BathRoom": 2,
      "garage": 2,
      "Description":  "Cozy 3-Bedroom Home for Rent: Discover your ideal retreat in this charming 3-bedroom house, located in a peaceful, family-friendly neighborhood. With a spacious open-concept living area, a well-equipped kitchen, and a private backyard for outdoor enjoyment, this property offers the perfect blend of modern comfort and classic appeal. You'll appreciate the convenience of an attached garage and the pet-friendly environment. This home is also close to schools, parks, shopping, and major transportation routes for added convenience. Don't miss the opportunity to make this house your home. Contact us today to schedule a viewing and secure your new living space.",
      "location": LatLng(31.9218155, 35.1828835),
      
    },
    {
      "id": 2,
      "owner" : "Yaqeen",
      "url": "assets/images/house2.jpg",
      "homepic0": "assets/images/homepic0.png",
      "homepic1": "assets/images/homepic1.png",
      "homepic2": "assets/images/homepic2.png",
      "homepic3": "assets/images/homepic3.png",
      "type": "Land ",
      "area": 1000,
      "status": "for rent",
      "BedRoom": 3,
      "BathRoom": 2,
      "garage": 2,
      "Description":  "Cozy 3-Bedroom Home for Rent: Discover your ideal retreat in this charming 3-bedroom house, located in a peaceful, family-friendly neighborhood. With a spacious open-concept living area, a well-equipped kitchen, and a private backyard for outdoor enjoyment, this property offers the perfect blend of modern comfort and classic appeal. You'll appreciate the convenience of an attached garage and the pet-friendly environment. This home is also close to schools, parks, shopping, and major transportation routes for added convenience. Don't miss the opportunity to make this house your home. Contact us today to schedule a viewing and secure your new living space.",
      "location": LatLng(32.46400359767754, 35.30090110605022),
      "city" : "Nablus"
    },
    {
      "id": 3,
      "owner" : "Yaqeen",
      "url": "assets/images/house2.jpg",
      "homepic0": "assets/images/homepic0.png",
      "homepic1": "assets/images/homepic1.png",
      "homepic2": "assets/images/homepic2.png",
      "homepic3": "assets/images/homepic3.png",
      "type": "Land",
      "area": 1000,
      "status": "for sale",
      "BedRoom": 0,
      "BathRoom": 0,
      "garage": 0,
      "Description":  "Cozy 3-Bedroom Home for Rent: Discover your ideal retreat in this charming 3-bedroom house, located in a peaceful, family-friendly neighborhood. With a spacious open-concept living area, a well-equipped kitchen, and a private backyard for outdoor enjoyment, this property offers the perfect blend of modern comfort and classic appeal. You'll appreciate the convenience of an attached garage and the pet-friendly environment. This home is also close to schools, parks, shopping, and major transportation routes for added convenience. Don't miss the opportunity to make this house your home. Contact us today to schedule a viewing and secure your new living space.",
      "location": LatLng(32.46400359767754, 35.30090110605022),
      "city" : "Nablus"
    },
    {
      "id": 4,
      "owner" : "Yaqeen",
      "url": "assets/images/house1.jpg",
      "homepic0": "assets/images/homepic0.png",
      "homepic1": "assets/images/homepic0.png",
      "homepic2": "assets/images/homepic0.png",
      "homepic3": "assets/images/homepic0.png",
      "type": "Land",
      "area": 1000,
      "status": "for sale",
      "BedRoom": 0,
      "BathRoom": 0,
      "garage": 0,
      "Description":  "Cozy 3-Bedroom Home for Rent: Discover your ideal retreat in this charming 3-bedroom house, located in a peaceful, family-friendly neighborhood. With a spacious open-concept living area, a well-equipped kitchen, and a private backyard for outdoor enjoyment, this property offers the perfect blend of modern comfort and classic appeal. You'll appreciate the convenience of an attached garage and the pet-friendly environment. This home is also close to schools, parks, shopping, and major transportation routes for added convenience. Don't miss the opportunity to make this house your home. Contact us today to schedule a viewing and secure your new living space.",
      "location": LatLng(32.46400359767754, 35.30090110605022),
      "city" : "Nablus"
    },
    // Add more property records as needed.
  ];

  // Ensure that the 'location' field is always a double.
 

  return properties;
}
