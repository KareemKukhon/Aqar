import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_auth/data/CityModel.dart';
import 'package:flutter_auth/data/contactsModel.dart';

class User {
  String? firstName;
  String? lastName;
  String? gender;
  String? email;
  String? phone;
  String? city;
  String? password;
  List<CityModel>? visitedCities;
  List<ContactsModel>? contacts;
  String? image;
  User({
    this.firstName,
    this.lastName,
    this.gender,
    this.email,
    this.phone,
    this.city,
    this.password,
    this.visitedCities,
    this.contacts,
    this.image,
  });

  User copyWith({
    ValueGetter<String?>? firstName,
    ValueGetter<String?>? lastName,
    ValueGetter<String?>? gender,
    ValueGetter<String?>? email,
    ValueGetter<String?>? phone,
    ValueGetter<String?>? city,
    ValueGetter<String?>? password,
    ValueGetter<List<CityModel>?>? visitedCities,
    ValueGetter<List<ContactsModel>?>? contacts,
    ValueGetter<String?>? image,
  }) {
    return User(
      firstName: firstName?.call() ?? this.firstName,
      lastName: lastName?.call() ?? this.lastName,
      gender: gender?.call() ?? this.gender,
      email: email?.call() ?? this.email,
      phone: phone?.call() ?? this.phone,
      city: city?.call() ?? this.city,
      password: password?.call() ?? this.password,
      visitedCities: visitedCities?.call() ?? this.visitedCities,
      contacts: contacts?.call() ?? this.contacts,
      image: image?.call() ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'gender': gender,
      'email': email,
      'phone': phone,
      'city': city,
      'password': password,
      'visitedCities': visitedCities?.map((x) => x?.toMap())?.toList(),
      'contacts': contacts?.map((x) => x?.toMap())?.toList(),
      'image': image,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      firstName: map['firstName'],
      lastName: map['lastName'],
      gender: map['gender'],
      email: map['email'],
      phone: map['phone'],
      city: map['city'],
      password: map['password'],
      visitedCities: map['visitedCities'] != null
          ? List<CityModel>.from(
              map['visitedCities']?.map((x) => CityModel.fromMap(x)))
          : null,
      contacts: map['contacts'] != null
          ? List<ContactsModel>.from(
              map['contacts']?.map((x) => ContactsModel.fromMap(x)))
          : null,
      image: map['image'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(firstName: $firstName, lastName: $lastName, gender: $gender, email: $email, phone: $phone, city: $city, password: $password, visitedCities: $visitedCities, contacts: $contacts, image: $image)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.gender == gender &&
        other.email == email &&
        other.phone == phone &&
        other.city == city &&
        other.password == password &&
        listEquals(other.visitedCities, visitedCities) &&
        listEquals(other.contacts, contacts) &&
        other.image == image;
  }

  @override
  int get hashCode {
    return firstName.hashCode ^
        lastName.hashCode ^
        gender.hashCode ^
        email.hashCode ^
        phone.hashCode ^
        city.hashCode ^
        password.hashCode ^
        visitedCities.hashCode ^
        contacts.hashCode ^
        image.hashCode;
  }
}
