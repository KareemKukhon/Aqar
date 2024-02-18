import 'dart:convert';

import 'package:flutter/widgets.dart';

class logindata {
  String? email;
  String? password;
  logindata({
    this.email,
    this.password,
  });



  logindata copyWith({
    ValueGetter<String?>? email,
    ValueGetter<String?>? password,
  }) {
    return logindata(
      email: email?.call() ?? this.email,
      password: password?.call() ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
    };
  }

  factory logindata.fromMap(Map<String, dynamic> map) {
    return logindata(
      email: map['email'],
      password: map['password'],
    );
  }

  String toJson() => json.encode(toMap());

  factory logindata.fromJson(String source) => logindata.fromMap(json.decode(source));

  @override
  String toString() => 'logindata(email: $email, password: $password)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is logindata &&
      other.email == email &&
      other.password == password;
  }

  @override
  int get hashCode => email.hashCode ^ password.hashCode;
}
