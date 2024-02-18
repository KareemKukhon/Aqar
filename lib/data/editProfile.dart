import 'dart:io';

class EditProfile {
  void createJsonData(
    String? firstName,
    String? lastName,
    int? phone,
    String? gender,
    String? email,
    File? image,
  ) {
    Map<String, dynamic> userData = {
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'gender': gender,
      'email': email,
      'image': image,
    };
    print(userData);
  }
}
