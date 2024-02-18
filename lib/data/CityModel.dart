import 'dart:convert';

import 'package:flutter/widgets.dart';

class CityModel {
  // String? id;
  String? name;
  num? visitCount;
  CityModel({
    // this.id,
    this.name,
    this.visitCount,
  });

  CityModel copyWith({
    // ValueGetter<String?>? id,
    ValueGetter<String?>? name,
    ValueGetter<num?>? visitedCount,
  }) {
    return CityModel(
      // id: id?.call() ?? this.id,
      name: name?.call() ?? this.name,
      visitCount: visitedCount?.call() ?? this.visitCount,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      // 'id': id,
      'name': name,
      'visitCount': visitCount,
    };
  }

  factory CityModel.fromMap(Map<String, dynamic> map) {
    return CityModel(
      // id: map['id'],
      name: map['name'],
      visitCount: map['visitCount'] is String ? num.tryParse(map['visitCount']) : map['visitCount'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CityModel.fromJson(String source) => CityModel.fromMap(json.decode(source));

  @override
  String toString() => 'CityModel( name: $name, visitCount: $visitCount)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is CityModel &&
      // other.id == id &&
      other.name == name &&
      other.visitCount == visitCount;
  }

  @override
  int get hashCode => name.hashCode ^ visitCount.hashCode;
}
