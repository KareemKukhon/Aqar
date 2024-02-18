import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Login/login_screen.dart';
import 'package:flutter_auth/Screens/profilepage/Calendar.dart';
import 'package:flutter_auth/Screens/profilepage/editProfile.dart';
import 'package:flutter_auth/Screens/profilepage/utils/user_preferences.dart';
import 'package:flutter_auth/Screens/profilepage/widget/profile_widget.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/data/SignUpData.dart';
import 'package:flutter_auth/services/services.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: profilepage(),
    );
  }
}

class profilepage extends StatefulWidget {
  const profilepage({Key? key}) : super(key: key);

  @override
  _ContactPageState createState() => _ContactPageState();
}

buttonArrow(BuildContext context) {
  return Container(
      //
      //color: Colors.amber,
      padding: EdgeInsets.only(right: MediaQuery.sizeOf(context).width * 0.85),
      child: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ));
}

class _ContactPageState extends State<profilepage> {
  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<Services>(context).userRes;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: ListView(
              children: [
                buttonArrow(context),
                const SizedBox(height: 24),
                ProfileWidget(
                  imagePath: user!.image != null
                      ? "http://192.168.68.51:8083${user.image}"
                      : null,
                  onClicked: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return ProfilePage();
                        },
                      ),
                    );
                  },
                ),
                const SizedBox(height: 24),
                buildName(user),
                const SizedBox(height: 24),
                buildAbout(user),
                const SizedBox(height: 24),
                buttonWid(user),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildName(User user) => Column(
        children: [
          Container(
            padding:
                EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.3),
            child: Row(
              children: [
                Text(
                  user.firstName ?? "",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  user.lastName ?? "",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            user.email ?? "",
            style: TextStyle(color: Colors.grey),
          ),
        ],
      );

  Widget buildAbout(User user) => Container(
        padding: EdgeInsets.symmetric(horizontal: 45),
        // ignore: prefer_const_constructors
        child: Card(
          color: Color(0xFFc781d0).withOpacity(0.1),
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'About me',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Text(
                      "City : ",
                      style: TextStyle(
                          fontSize: 20, height: 1.4, color: Colors.white),
                    ),
                    Text(
                      user.city ?? "",
                      style: TextStyle(
                          fontSize: 20, height: 1.4, color: Colors.white),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Gender : ",
                      style: TextStyle(
                          fontSize: 20, height: 2, color: Colors.white),
                    ),
                    Text(
                      user.gender ?? "",
                      style: TextStyle(
                          fontSize: 20, height: 2, color: Colors.white),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Phone : ",
                      style: TextStyle(
                          fontSize: 20, height: 2, color: Colors.white),
                    ),
                    Text(
                      user.phone.toString(),
                      style: TextStyle(
                          fontSize: 20, height: 2, color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
  Widget buttonWid(User user) => Container(
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.symmetric(horizontal: 48),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return Calendar();
                },
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            primary: Color(0xffa379bc).withOpacity(0.9),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  10.0), // Set your desired border radius here
            ),
          ),
          child: const Text(
            "Appointment Schedule",
            style: TextStyle(fontSize: 17, color: Colors.white),
          ),
        ),
      );
}
