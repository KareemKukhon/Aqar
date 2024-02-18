
import 'package:flutter_auth/data/user.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class UserPreferences {
  static const myUser = User(
    id: '1',
    imagePath:
        'https://images.unsplash.com/photo-1554151228-14d9def656e4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=333&q=80',
    email: 'yaqeenyaseen6@gmail.com',
    firstName: 'Yaqeen',
    lastName: 'Yaseen',
    gender: 'Female',
    phone: 0594677382,
    city: "Ramallah",
    location: LatLng(31.8990767, 35.2020754),
  );
}
