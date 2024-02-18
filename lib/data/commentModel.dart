import 'dart:convert';

import 'package:flutter/widgets.dart';

class CommentModel {
  String? id;
  String? name;
  String? pic;
  String? message;
  DateTime? date;
  
  CommentModel({
    this.id,
    this.name,
    this.pic,
    this.message,
    this.date,
  });

  CommentModel copyWith({
    ValueGetter<String?>? id,
    ValueGetter<String?>? name,
    ValueGetter<String?>? pic,
    ValueGetter<String?>? message,
    ValueGetter<DateTime?>? date,
  }) {
    return CommentModel(
      id: id?.call() ?? this.id,
      name: name?.call() ?? this.name,
      pic: pic?.call() ?? this.pic,
      message: message?.call() ?? this.message,
      date: date?.call() ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'pic': pic,
      'message': message,
      'date': date?.millisecondsSinceEpoch,
    };
  }

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      id: map['id'],
      name: map['name'],
      pic: map['pic'],
      message: map['message'],
      date: map['date'] != null ? DateTime.parse(map['date']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CommentModel.fromJson(String source) =>
      CommentModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CommentModel(id: $id, name: $name, pic: $pic, message: $message, date: $date)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CommentModel &&
        other.id == id &&
        other.name == name &&
        other.pic == pic &&
        other.message == message &&
        other.date == date;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        pic.hashCode ^
        message.hashCode ^
        date.hashCode;
  }
}
