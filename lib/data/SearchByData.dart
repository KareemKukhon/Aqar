import 'dart:convert';

import 'package:flutter/widgets.dart';

class SearchBy {
  String? rentOrBuy;
  String? propType;
  String? selectedCity;
  String? selectedStreet;
  double? selectedArea;
  String? selectedBed;
  String? selectedBath;
  String? selectedGarage;
  double? lowerPrice;
  double? upperPrice;
  SearchBy({
    this.rentOrBuy,
    this.propType,
    this.selectedCity,
    this.selectedStreet,
    this.selectedArea,
    this.selectedBed,
    this.selectedBath,
    this.selectedGarage,
    this.lowerPrice,
    this.upperPrice,
  });
  

  SearchBy copyWith({
    ValueGetter<String?>? rentOrBuy,
    ValueGetter<String?>? propType,
    ValueGetter<String?>? selectedCity,
    ValueGetter<String?>? selectedStreet,
    ValueGetter<double?>? selectedArea,
    ValueGetter<String?>? selectedBed,
    ValueGetter<String?>? selectedBath,
    ValueGetter<String?>? selectedGarage,
    ValueGetter<double?>? lowerPrice,
    ValueGetter<double?>? upperPrice,
  }) {
    return SearchBy(
      rentOrBuy: rentOrBuy?.call() ?? this.rentOrBuy,
      propType: propType?.call() ?? this.propType,
      selectedCity: selectedCity?.call() ?? this.selectedCity,
      selectedStreet: selectedStreet?.call() ?? this.selectedStreet,
      selectedArea: selectedArea?.call() ?? this.selectedArea,
      selectedBed: selectedBed?.call() ?? this.selectedBed,
      selectedBath: selectedBath?.call() ?? this.selectedBath,
      selectedGarage: selectedGarage?.call() ?? this.selectedGarage,
      lowerPrice: lowerPrice?.call() ?? this.lowerPrice,
      upperPrice: upperPrice?.call() ?? this.upperPrice,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'rentOrBuy': rentOrBuy,
      'propType': propType,
      'selectedCity': selectedCity,
      'selectedStreet': selectedStreet,
      'selectedArea': selectedArea,
      'selectedBed': selectedBed,
      'selectedBath': selectedBath,
      'selectedGarage': selectedGarage,
      'lowerPrice': lowerPrice,
      'upperPrice': upperPrice,
    };
  }

  factory SearchBy.fromMap(Map<String, dynamic> map) {
    return SearchBy(
      rentOrBuy: map['rentOrBuy'],
      propType: map['propType'],
      selectedCity: map['selectedCity'],
      selectedStreet: map['selectedStreet'],
      selectedArea: map['selectedArea']?.toDouble(),
      selectedBed: map['selectedBed'],
      selectedBath: map['selectedBath'],
      selectedGarage: map['selectedGarage'],
      lowerPrice: map['lowerPrice']?.toDouble(),
      upperPrice: map['upperPrice']?.toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory SearchBy.fromJson(String source) => SearchBy.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SearchBy(rentOrBuy: $rentOrBuy, propType: $propType, selectedCity: $selectedCity, selectedStreet: $selectedStreet, selectedArea: $selectedArea, selectedBed: $selectedBed, selectedBath: $selectedBath, selectedGarage: $selectedGarage, lowerPrice: $lowerPrice, upperPrice: $upperPrice)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is SearchBy &&
      other.rentOrBuy == rentOrBuy &&
      other.propType == propType &&
      other.selectedCity == selectedCity &&
      other.selectedStreet == selectedStreet &&
      other.selectedArea == selectedArea &&
      other.selectedBed == selectedBed &&
      other.selectedBath == selectedBath &&
      other.selectedGarage == selectedGarage &&
      other.lowerPrice == lowerPrice &&
      other.upperPrice == upperPrice;
  }

  @override
  int get hashCode {
    return rentOrBuy.hashCode ^
      propType.hashCode ^
      selectedCity.hashCode ^
      selectedStreet.hashCode ^
      selectedArea.hashCode ^
      selectedBed.hashCode ^
      selectedBath.hashCode ^
      selectedGarage.hashCode ^
      lowerPrice.hashCode ^
      upperPrice.hashCode;
  }
}
