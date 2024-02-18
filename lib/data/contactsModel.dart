import 'dart:convert';

class ContactsModel {
  String? email;
  String? name;
  ContactsModel({
    this.email,
    this.name,
  });

  ContactsModel copyWith({
    String? email,
    String? name,
  }) {
    return ContactsModel(
      email: email ?? this.email,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
    };
  }

  factory ContactsModel.fromMap(Map<String, dynamic> map) {
    return ContactsModel(
      email: map['email'] ?? '',
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ContactsModel.fromJson(String source) => ContactsModel.fromMap(json.decode(source));

  @override
  String toString() => 'ContactsModel(email: $email, name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ContactsModel &&
      other.email == email &&
      other.name == name;
  }

  @override
  int get hashCode => email.hashCode ^ name.hashCode;
}
