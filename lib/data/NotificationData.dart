import 'dart:convert';

import 'package:flutter/widgets.dart';

import 'package:flutter_auth/data/Appointments.dart';
import 'package:flutter_auth/data/SignUpData.dart';

class Notification_Description {
  String? id;
  String? title;
  String? body;
  User? sender;
  User? recipient;
  DateTime? date;
  String? time;
  AppointmentModel? appointmentModel;
  Notification_Description({
    this.id,
    this.title,
    this.body,
    this.sender,
    this.recipient,
    this.date,
    this.time,
    this.appointmentModel,
  });

  Notification_Description copyWith({
    ValueGetter<String?>? id,
    ValueGetter<String?>? title,
    ValueGetter<String?>? body,
    ValueGetter<User?>? sender,
    ValueGetter<User?>? recipient,
    ValueGetter<DateTime?>? date,
    ValueGetter<String?>? time,
    ValueGetter<AppointmentModel?>? appointmentModel,
  }) {
    return Notification_Description(
      id: id != null ? id() : this.id,
      title: title != null ? title() : this.title,
      body: body != null ? body() : this.body,
      sender: sender != null ? sender() : this.sender,
      recipient: recipient != null ? recipient() : this.recipient,
      date: date != null ? date() : this.date,
      time: time != null ? time() : this.time,
      appointmentModel:
          appointmentModel != null ? appointmentModel() : this.appointmentModel,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      // 'id': id,
      'title': title,
      'body': body,
      'sender': sender?.toMap(),
      'recipient': recipient?.toMap(),
      'date': date?.millisecondsSinceEpoch,
      'time': time,
      'appointmentModel': appointmentModel?.toMap(),
    };
  }

  factory Notification_Description.fromMap(Map<String, dynamic> map) {
    return Notification_Description(
      id: map['id'],
      title: map['title'],
      body: map['body'],
      sender: map['sender'] != null ? User.fromMap(map['sender']) : null,
      recipient:
          map['recipient'] != null ? User.fromMap(map['recipient']) : null,
      date: map['date'] != null ? DateTime.parse(map['date']) : null,
      time: map['time'],
      appointmentModel: map['appointmentModel'] != null
          ? AppointmentModel.fromMap(map['appointmentModel'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Notification_Description.fromJson(String source) =>
      Notification_Description.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Notification_Description(id: $id, title: $title, body: $body, sender: $sender, recipient: $recipient, date: $date, time: $time, appointmentModel: $appointmentModel)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Notification_Description &&
        other.id == id &&
        other.title == title &&
        other.body == body &&
        other.sender == sender &&
        other.recipient == recipient &&
        other.date == date &&
        other.time == time &&
        other.appointmentModel == appointmentModel;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        body.hashCode ^
        sender.hashCode ^
        recipient.hashCode ^
        date.hashCode ^
        time.hashCode ^
        appointmentModel.hashCode;
  }
}


// List<Map<String, dynamic>> notification_des() {
//   // Create a list to store property records.
//   List<Map<String, dynamic>> properties = [
//     {
//       "id": 1,
//       "title": "New Message",
//       "description": "Kareem Sent You a Message",
//       // "screenName": "chatspage",
//       "date": "2-12-2023",
//       "time": "3:50 PM",
      
//     },
//     {
//       "id": 2,
//       "title": "New Message",
//       "description": "Raya Sent You a Message",
//       // "screenName": "chatspage",
//       "date": "2-12-2023",
//       "time": "3:50 AM",
//     },
//     {
//       "id": 3,
//       "title": "New Message",
//       "description": "Yaqeen Sent You a Message",
//       // "screenName": "chatspage",
//       "date": "2-12-2023",
//       "time": "3:50 PM",
//     },
//     {
//       "id": 4,
//       "title": "New Message",
//       "description": "Hareth Sent You a Message",
//       // "screenName": "chatspage",
//       "date": "2-12-2023",
//       "time": "3:50 AM",
//     },
//     {
//       "id": 5,
//       "title": "New Message",
//       "description": "Yaqeen Sent You a Message",
//       // "screenName": "chatspage",
//       "date": "2-12-2023",
//       "time": "3:50 AM",
//     },
//     {
//       "id": 6,
//       "title": "New Message",
//       "description": "Bsma Sent You a Message",
//       // "screenName": "chatspage",
//       "date": "2-12-2023",
//       "time": "3:50 PM",
//     },
//     {
//       "id": 7,
//       "title": "New Message",
//       "description": "Yaqeen Sent You a Message",
//       // "screenName": "chatspage",
//       "date": "2-12-2023",
//       "time": "3:50 AM",
//     },
//     {
//       "id": 8,
//       "title": "New Proparity is Uploaded",
//       "description": "Owner Name added a new property",
//       // "screenName": "BottomBar",
//       // "propId": 4,
//       "date": "2-12-2023",
//       "time": "3:50 PM",
//     },
//     {
//       "id": 9,
//       "title": "New Message",
//       "description": "Yaqeen Sent You a Message",
//       // "screenName": "chatspage",
//       "date": "2-12-2023",
//       "time": "3:50 PM",
//     },
//     {
//       "id": 10,
//       "title": "New Proparity is Uploaded",
//       "description": "Owner Name added a new property",
//       // "screenName": "BottomBar",
//       // "propId": 3,
//       "date": "2-12-2023",
//       "time": "3:50 AM",
//     },
//     // Add more property records as needed.
//   ];

//   // Ensure that the 'location' field is always a double.

//   return properties;
// }
