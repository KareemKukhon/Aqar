import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_auth/data/SignUpData.dart';

class AppointmentModel {
  User? user2;
  DateTime? start;
  DateTime? end;
  User? user1;
  AppointmentModel({
    this.user2,
    required this.start,
    required this.end,
    this.user1,
  });

  AppointmentModel copyWith({
    ValueGetter<User?>? user2,
    ValueGetter<DateTime?>? start,
    ValueGetter<DateTime?>? end,
    ValueGetter<User?>? user1,
  }) {
    return AppointmentModel(
      user2: user2?.call() ?? this.user2,
      start: start?.call() ?? this.start,
      end: end?.call() ?? this.end,
      user1: user1?.call() ?? this.user1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user2': user2?.toMap(),
      'start': start?.toIso8601String(),
      'end': end?.toIso8601String(),
      'user1': user1?.toMap(),
    };
  }

  factory AppointmentModel.fromMap(Map<String, dynamic> map) {
    return AppointmentModel(
      user2: map['user2'] != null ? User.fromMap(map['user2']) : null,
      start: DateTime.parse(map['start'].toString()),
      end: DateTime.parse(map['end'].toString()),
      user1: map['user1'] != null ? User.fromMap(map['user1']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AppointmentModel.fromJson(String source) =>
      AppointmentModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AppointmentModel(user2: $user2, start: $start, end: $end, user1: $user1)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppointmentModel &&
        other.user2 == user2 &&
        other.start == start &&
        other.end == end &&
        other.user1 == user1;
  }

  @override
  int get hashCode {
    return user2.hashCode ^ start.hashCode ^ end.hashCode ^ user1.hashCode;
  }
}

class AppointmentsList {
  List<AppointmentModel> appointments;
  AppointmentsList(this.appointments);

  void convData() {
    List<AppointmentModel> data = appointments;
    printAppointments(data);
  }

  void printAppointments(List<AppointmentModel> appointments) {
    for (var bookingData in appointments) {
      print('User: ${bookingData.user1}');
      print('Start time: ${bookingData.start}');
      print('End time: ${bookingData.end}');
      print('------------------------');
    }
  }

  // List<BookingData> createBookingList() {
  //   List<BookingData> data = appointments;
  //   return data;
  // }
}
