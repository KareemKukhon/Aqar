import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_auth/data/SignUpData.dart';

class PropertyModel {
  String? id;
  User? owner;
  String? rentOrBuy;
  String? propType;
  String? selectedCity;
  String? selectedStreet;
  String? selectedArea;
  String? selectedTime;
  double? selectedPrice;
  String? selectedBed;
  String? selectedBath;
  String? selectedGarage;
  String? selectedDescription;
  DateTime? start;
  DateTime? end;
  double? price;
  String? image;
  double? latitude;
  double? longitude;
  List<String>? imageFileList;
  PropertyModel({
    // this.files,
    this.id,
    this.owner,
    this.rentOrBuy,
    this.propType,
    this.selectedCity,
    this.selectedStreet,
    this.selectedArea,
    this.selectedTime,
    this.selectedPrice,
    this.selectedBed,
    this.selectedBath,
    this.selectedGarage,
    this.selectedDescription,
    this.start,
    this.end,
    this.price,
    this.image,
    this.latitude,
    this.longitude,
    this.imageFileList,
  });

  PropertyModel copyWith({
    ValueGetter<String?>? id,
    ValueGetter<User?>? owner,
    ValueGetter<String?>? rentOrBuy,
    ValueGetter<String?>? propType,
    ValueGetter<String?>? selectedCity,
    ValueGetter<String?>? selectedStreet,
    ValueGetter<String?>? selectedArea,
    ValueGetter<String?>? selectedTime,
    ValueGetter<double?>? selectedPrice,
    ValueGetter<String?>? selectedBed,
    ValueGetter<String?>? selectedBath,
    ValueGetter<String?>? selectedGarage,
    ValueGetter<String?>? selectedDescription,
    ValueGetter<DateTime?>? start,
    ValueGetter<DateTime?>? end,
    ValueGetter<double?>? price,
    ValueGetter<String?>? image,
    ValueGetter<double?>? latitude,
    ValueGetter<double?>? longitude,
    ValueGetter<List<String>?>? imageFileList,
  }) {
    return PropertyModel(
      id: id != null ? id() : this.id,
      owner: owner != null ? owner() : this.owner,
      rentOrBuy: rentOrBuy != null ? rentOrBuy() : this.rentOrBuy,
      propType: propType != null ? propType() : this.propType,
      selectedCity: selectedCity != null ? selectedCity() : this.selectedCity,
      selectedStreet:
          selectedStreet != null ? selectedStreet() : this.selectedStreet,
      selectedArea: selectedArea != null ? selectedArea() : this.selectedArea,
      selectedTime: selectedTime != null ? selectedTime() : this.selectedTime,
      selectedPrice:
          selectedPrice != null ? selectedPrice() : this.selectedPrice,
      selectedBed: selectedBed != null ? selectedBed() : this.selectedBed,
      selectedBath: selectedBath != null ? selectedBath() : this.selectedBath,
      selectedGarage:
          selectedGarage != null ? selectedGarage() : this.selectedGarage,
      selectedDescription: selectedDescription != null
          ? selectedDescription()
          : this.selectedDescription,
      start: start != null ? start() : this.start,
      end: end != null ? end() : this.end,
      price: price != null ? price() : this.price,
      image: image != null ? image() : this.image,
      latitude: latitude != null ? latitude() : this.latitude,
      longitude: longitude != null ? longitude() : this.longitude,
      imageFileList:
          imageFileList != null ? imageFileList() : this.imageFileList,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'owner': owner?.toMap(),
      'rentOrBuy': rentOrBuy,
      'propType': propType,
      'selectedCity': selectedCity,
      'selectedStreet': selectedStreet,
      'selectedArea': selectedArea,
      'selectedTime': selectedTime,
      'selectedPrice': selectedPrice,
      'selectedBed': selectedBed,
      'selectedBath': selectedBath,
      'selectedGarage': selectedGarage,
      'selectedDescription': selectedDescription,
      'start': start?.toIso8601String(),
      'end': end?.toIso8601String(),
      'price': price,
      'image': image,
      'latitude': latitude,
      'longitude': longitude,
      'imageFileList': imageFileList,
    };
  }

  factory PropertyModel.fromMap(Map<String, dynamic> map) {
    return PropertyModel(
      id: map['id'],
      owner: map['owner'] != null ? User.fromMap(map['owner']) : null,
      rentOrBuy: map['rentOrBuy'],
      propType: map['propType'],
      selectedCity: map['selectedCity'],
      selectedStreet: map['selectedStreet'],
      selectedArea: map['selectedArea'],
      selectedTime: map['selectedTime'],
      selectedPrice: map['selectedPrice']?.toDouble(),
      selectedBed: map['selectedBed'],
      selectedBath: map['selectedBath'],
      selectedGarage: map['selectedGarage'],
      selectedDescription: map['selectedDescription'],
      start: map['start'] != null ? DateTime.parse(map['start']) : null,
      end: map['end'] != null ? DateTime.parse(map['end']) : null,
      price: map['price']?.toDouble(),
      image: map['image'],
      latitude: map['latitude']?.toDouble(),
      longitude: map['longitude']?.toDouble(),
      imageFileList: List<String>.from(map['imageFileList']),
    );
  }

  String toJson() => json.encode(toMap());

  factory PropertyModel.fromJson(String source) =>
      PropertyModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PropertyModel(id: $id, owner: $owner, rentOrBuy: $rentOrBuy, propType: $propType, selectedCity: $selectedCity, selectedStreet: $selectedStreet, selectedArea: $selectedArea, selectedTime: $selectedTime, selectedPrice: $selectedPrice, selectedBed: $selectedBed, selectedBath: $selectedBath, selectedGarage: $selectedGarage, selectedDescription: $selectedDescription, start: $start, end: $end, price: $price, image: $image, latitude: $latitude, longitude: $longitude, imageFileList: $imageFileList)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PropertyModel &&
        other.id == id &&
        other.owner == owner &&
        other.rentOrBuy == rentOrBuy &&
        other.propType == propType &&
        other.selectedCity == selectedCity &&
        other.selectedStreet == selectedStreet &&
        other.selectedArea == selectedArea &&
        other.selectedTime == selectedTime &&
        other.selectedPrice == selectedPrice &&
        other.selectedBed == selectedBed &&
        other.selectedBath == selectedBath &&
        other.selectedGarage == selectedGarage &&
        other.selectedDescription == selectedDescription &&
        other.start == start &&
        other.end == end &&
        other.price == price &&
        other.image == image &&
        other.latitude == latitude &&
        other.longitude == longitude &&
        listEquals(other.imageFileList, imageFileList);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        owner.hashCode ^
        rentOrBuy.hashCode ^
        propType.hashCode ^
        selectedCity.hashCode ^
        selectedStreet.hashCode ^
        selectedArea.hashCode ^
        selectedTime.hashCode ^
        selectedPrice.hashCode ^
        selectedBed.hashCode ^
        selectedBath.hashCode ^
        selectedGarage.hashCode ^
        selectedDescription.hashCode ^
        start.hashCode ^
        end.hashCode ^
        price.hashCode ^
        image.hashCode ^
        latitude.hashCode ^
        longitude.hashCode ^
        imageFileList.hashCode;
  }
}
