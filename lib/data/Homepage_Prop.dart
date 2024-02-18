import 'dart:convert';

import 'package:flutter/widgets.dart';

class HomePageProp {
  final dynamic id;
  final String? imagePath;
  final String? cityName;
  String? price;
  final String? status;
  final dynamic bedroom;
  final dynamic bathroom;
  final dynamic garage;
  final String? location;

  HomePageProp({
    required this.id,
    required this.imagePath,
    required this.cityName,
    this.price,
    required this.status,
    required this.bedroom,
    required this.bathroom,
    required this.garage,
    required this.location,
  });

  HomePageProp copyWith({
    dynamic? id,
    ValueGetter<String?>? imagePath,
    ValueGetter<String?>? cityName,
    ValueGetter<String?>? price,
    ValueGetter<String?>? status,
    dynamic? bedroom,
    dynamic? bathroom,
    dynamic? garage,
    ValueGetter<String?>? location,
  }) {
    return HomePageProp(
      id: id ?? this.id,
      imagePath: imagePath != null ? imagePath() : this.imagePath,
      cityName: cityName != null ? cityName() : this.cityName,
      price: price != null ? price() : this.price,
      status: status != null ? status() : this.status,
      bedroom: bedroom ?? this.bedroom,
      bathroom: bathroom ?? this.bathroom,
      garage: garage ?? this.garage,
      location: location != null ? location() : this.location,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'imagePath': imagePath,
      'cityName': cityName,
      'price': price,
      'status': status,
      'bedroom': bedroom,
      'bathroom': bathroom,
      'garage': garage,
      'location': location,
    };
  }

  factory HomePageProp.fromMap(Map<String, dynamic> map) {
    return HomePageProp(
      id: map['id'] ?? null,
      imagePath: map['imagePath'],
      cityName: map['cityName'],
      price: map['price'],
      status: map['status'],
      bedroom: map['bedroom'] ?? null,
      bathroom: map['bathroom'] ?? null,
      garage: map['garage'] ?? null,
      location: map['location'],
    );
  }

  String toJson() => json.encode(toMap());

  factory HomePageProp.fromJson(String source) => HomePageProp.fromMap(json.decode(source));

  @override
  String toString() {
    return 'HomePageProp(id: $id, imagePath: $imagePath, cityName: $cityName, price: $price, status: $status, bedroom: $bedroom, bathroom: $bathroom, garage: $garage, location: $location)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is HomePageProp &&
      other.id == id &&
      other.imagePath == imagePath &&
      other.cityName == cityName &&
      other.price == price &&
      other.status == status &&
      other.bedroom == bedroom &&
      other.bathroom == bathroom &&
      other.garage == garage &&
      other.location == location;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      imagePath.hashCode ^
      cityName.hashCode ^
      price.hashCode ^
      status.hashCode ^
      bedroom.hashCode ^
      bathroom.hashCode ^
      garage.hashCode ^
      location.hashCode;
  }
}

List<Map<String, dynamic>> HomePage_Prop() {
  // Create a list to store property records.
  List<Map<String, dynamic>> properties = [
    {
      "id": 1,
      "url": "assets/images/house1.jpg",
      "cityName": "Gaza",
      "status": "for sale",
      "BedRoom": 3,
      "BathRoom": 2,
      "garage": 2,
      "location": 2.2,
    },
    {
      "id": 2,
      "url": "assets/images/house2.jpg",
      "cityName": "Nablus",
      "status": "for rent",
      "BedRoom": 3,
      "BathRoom": 2,
      "garage": 2,
      "location": 3.3,
    },
    {
      "id": 3,
      "url": "assets/images/house3.jpg",
      "cityName": "Ramallah",
      "status": "for sale",
      "BedRoom": 3,
      "BathRoom": 2,
      "garage": 2,
      "location": 2.2,
    },
    {
      "id": 4,
      "url": "assets/images/house4.jpg",
      "cityName": "Tullkarm",
      "status": "for rent",
      "BedRoom": 3,
      "BathRoom": 2,
      "garage": 2,
      "location": 422,
    },
    {
      "id": 5,
      "url": "assets/images/house4.jpg",
      "cityName": "Tullkarm",
      "status": "for rent",
      "BedRoom": 3,
      "BathRoom": 2,
      "garage": 2,
      "location": 422,
    },
    {
      "id": 6,
      "url": "assets/images/house4.jpg",
      "cityName": "Tullkarm",
      "status": "for rent",
      "BedRoom": 3,
      "BathRoom": 2,
      "garage": 2,
      "location": 422,
    },
    {
      "id": 7,
      "url": "assets/images/house4.jpg",
      "cityName": "Tullkarm",
      "status": "for rent",
      "BedRoom": 3,
      "BathRoom": 2,
      "garage": 2,
      "location": 422,
    },
    {
      "id": 8,
      "url": "assets/images/house4.jpg",
      "cityName": "Tullkarm",
      "status": "for rent",
      "BedRoom": 3,
      "BathRoom": 2,
      "garage": 2,
      "location": 422,
    },
    {
      "id": 9,
      "url": "assets/images/house4.jpg",
      "cityName": "Tullkarm",
      "status": "for rent",
      "BedRoom": 3,
      "BathRoom": 2,
      "garage": 2,
      "location": 422,
    },
    {
      "id": 10,
      "url": "assets/images/house4.jpg",
      "cityName": "fggfgfg",
      "status": "for rent",
      "BedRoom": 3,
      "BathRoom": 2,
      "garage": 2,
      "location": 422,
    },
    // Add more property records as needed.
  ];

  // Ensure that the 'location' field is always a double.
  properties.forEach((property) {
    property["location"] = property["location"].toDouble();
    //print(property["location"]);
  });

  return properties;
}
