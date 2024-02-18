import 'dart:convert';

import 'package:flutter/widgets.dart';

import 'package:flutter_auth/data/Property.dart';
import 'package:flutter_auth/data/SignUpData.dart';

class SavedPropertyModel {
  String? id;
  User? user;
  PropertyModel? property;
  SavedPropertyModel({
    this.id,
    this.user,
    this.property,
  });

  SavedPropertyModel copyWith({
    ValueGetter<String?>? id,
    ValueGetter<User?>? user,
    ValueGetter<PropertyModel?>? property,
  }) {
    return SavedPropertyModel(
      id: id?.call() ?? this.id,
      user: user?.call() ?? this.user,
      property: property?.call() ?? this.property,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      // 'id': id,
      'user': user?.toMap(),
      'property': property?.toMap(),
    };
  }

  factory SavedPropertyModel.fromMap(Map<String, dynamic> map) {
    return SavedPropertyModel(
      id: map['id'],
      user: map['user'] != null ? User.fromMap(map['user']) : null,
      property: map['property'] != null ? PropertyModel.fromMap(map['property']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SavedPropertyModel.fromJson(String source) => SavedPropertyModel.fromMap(json.decode(source));

  @override
  String toString() => 'SavedPropertyModel(id: $id, user: $user, property: $property)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is SavedPropertyModel &&
      other.id == id &&
      other.user == user &&
      other.property == property;
  }

  @override
  int get hashCode => id.hashCode ^ user.hashCode ^ property.hashCode;
}
