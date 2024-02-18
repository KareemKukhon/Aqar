import 'package:google_maps_flutter/google_maps_flutter.dart';

class User {
  final dynamic id;
  final String imagePath;
  final String firstName;
  final String lastName;
  final String email;
  final String gender;
  final String city;
  final int phone;
  final LatLng location;

  const User({
    required this.id,
    required this.imagePath,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.gender,
    required this.city,
    required this.phone,
    required this.location,
  });
}

List<Map<String, dynamic>> userInformation() {
  // Create a list to store user records.
  List<Map<String, dynamic>> users = [
    {
      "id": 1,
      "imagePath": "assets/images/house2.jpg",
      "firstName": "Yaqeen",
      "lastName": "Yaseen",
      "email": "yaqeen@example.com",
      "gender": "Male",
      "city": "Nablus",
      "phone": 1234567890,
      "location": LatLng(32.2280665, 35.2370416),
    },
    {
      "id": 2,
      "imagePath": "assets/images/house1.jpg",
      "firstName": "Another",
      "lastName": "User",
      "email": "another@example.com",
      "gender": "Female",
      "city": "Ramallah",
      "phone": 9876543210,
      "location": LatLng(32.2280665, 35.2370416),
    },
    // Add more user records as needed.
  ];

  return users;
}