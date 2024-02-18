import 'dart:convert';

import 'package:flutter_auth/data/SignUpData.dart';
import 'package:provider/provider.dart';

class ChatModel {
  String? id; // Replace with the actual type of your ID property
  User? sender;
  User? recipient;
  String message;
  DateTime timestamp;
  String? location;
  bool? isPropEmpty;
  bool read;
  late bool isSender;
  ChatModel(
      {this.id,
      this.sender,
      this.recipient,
      required this.message,
      required this.timestamp,
      this.location,
      this.read = false,
      this.isPropEmpty ,
      this.isSender = false});

  ChatModel copyWith({
    String? id,
    User? sender,
    User? recipient,
    String? message,
    DateTime? timestamp,
    bool? read,
  }) {
    return ChatModel(
      id: id ?? this.id,
      sender: sender ?? this.sender,
      recipient: recipient ?? this.recipient,
      message: message ?? this.message,
      timestamp: timestamp ?? this.timestamp,
      read: read ?? this.read,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'sender': sender != null ? sender!.toMap() : null,
      'recipient': recipient != null ? recipient!.toMap() : null,
      'message': message,
      'timestamp': timestamp.millisecondsSinceEpoch,
      'read': read,
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map, String email) {
    return ChatModel(
        id: map['id'] ?? '',
        sender: User.fromMap(map['sender']),
        recipient: User.fromMap(map['recipient']),
        message: map['message'] ?? '',
        timestamp: DateTime.now(),
        read: map['read'] ?? false,
        isSender: map['sender']['email'] == email);
  }

  String toJson() => json.encode(toMap());

  // factory ChatModel.fromJson(String source) => ChatModel.fromMap(json.decode(source), );

  @override
  String toString() {
    return 'ChatModel(id: $id, sender: $sender, recipient: $recipient, message: $message, timestamp: $timestamp, read: $read)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChatModel &&
        other.id == id &&
        other.sender == sender &&
        other.recipient == recipient &&
        other.message == message &&
        other.timestamp == timestamp &&
        other.read == read;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        sender.hashCode ^
        recipient.hashCode ^
        message.hashCode ^
        timestamp.hashCode ^
        read.hashCode;
  }
}
