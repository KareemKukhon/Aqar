import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Welcome/welcome_screen.dart';
import 'package:flutter_auth/Screens/profilepage/utils/user_preferences.dart';
import 'package:flutter_auth/Screens/profilepage/widget/edit_widget.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/data/SignUpData.dart';
import 'package:flutter_auth/data/editProfile.dart';
import 'package:flutter_auth/services/services.dart';
import 'package:get/get.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? image;
  String? firstName;
  String? lastName;
  String? city;
  String? email;
  String? gender;
  String? phone;
  final Imagepicker = ImagePicker();
  // final user = UserPreferences.myUser;

  uploadImage() async {
    var pickedImage = await Imagepicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        image = File(pickedImage.path);
        print("$image");
      });
    } else {}
  }

  buttonArrow(BuildContext context) {
    return Container(
        child: Row(
      children: [
        IconButton(
          icon: const Icon(
            Icons.arrow_back,
            size: 25,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        Container(
          padding: EdgeInsets.only(left: 110),
          child: Text(
            "Edit Profile",
            style: TextStyle(fontSize: 20),
          ),
        ),
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<Services>(context).userRes;
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(top: 50),
                child: Column(
                  children: [
                    buttonArrow(context),
                    SizedBox(
                      height: 20,
                    ),
                    EditProfileWidget(
                      networkFalg: image != null ? false : true,
                      imagePath: image != null
                          ? image!
                          : user!.image != null
                              ? "http://192.168.68.51:8083${user.image}"
                              : null,
                      onClicked: () {
                        uploadImage();
                        setState(() {});
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 450,
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Material(
                                  elevation: 4,
                                  shadowColor: kPrimaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: TextField(
                                    decoration: InputDecoration(
                                        hintText: user!.firstName,
                                        hintStyle: TextStyle(
                                          letterSpacing: 2,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        fillColor: Colors.white30,
                                        filled: true,
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            borderSide: BorderSide.none)),
                                    onChanged: (value) {
                                      setState(() {
                                        firstName = value;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Material(
                                  elevation: 4,
                                  shadowColor: kPrimaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: TextField(
                                    decoration: InputDecoration(
                                        hintText: user!.lastName,
                                        hintStyle: TextStyle(
                                          letterSpacing: 2,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        fillColor: Colors.white30,
                                        filled: true,
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            borderSide: BorderSide.none)),
                                    onChanged: (value) {
                                      setState(() {
                                        lastName = value;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Material(
                              elevation: 4,
                              shadowColor: kPrimaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Container(
                                color: Colors.white,
                                child: DropdownButtonFormField<String>(
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: const BorderSide(
                                        color: Colors.transparent,
                                        width: 3,
                                      ),
                                    ),
                                    fillColor: Colors.transparent,
                                    filled: true,
                                  ),
                                  hint: Row(
                                    children: [
                                      Icon(
                                        Icons
                                            .location_city, // You can use a different icon
                                        color:
                                            kPrimaryColor, // Set icon color to kPrimaryColor
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Text(
                                        user.city ?? "".tr,
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 117, 117, 117)),
                                      ),
                                    ],
                                  ),
                                  value: city,
                                  onChanged: (String? newValue) {
                                    if (mounted)
                                      setState(() {
                                        city = newValue!;
                                      });
                                  },
                                  items: <String>[
                                    'Nablus'.tr,
                                    'Hebron'.tr,
                                    'Bethlehem'.tr,
                                    'Ramallah'.tr,
                                    'Jenin'.tr,
                                    'Jerusalem'.tr,
                                    'Gaza'.tr,
                                  ].map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons
                                                .location_city, // You can use a different icon
                                            color:
                                                kPrimaryColor, // Set icon color to kPrimaryColor
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Text(
                                            value,
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 117, 117, 117)),
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                ),
                              )),
                          Material(
                            elevation: 4,
                            shadowColor: kPrimaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextField(
                              decoration: InputDecoration(
                                  hintText: user.email,
                                  hintStyle: TextStyle(
                                    letterSpacing: 2,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  fillColor: Colors.white30,
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide.none)),
                              onChanged: (value) {
                                setState(() {
                                  email = value;
                                });
                              },
                            ),
                          ),
                          Material(
                              elevation: 4,
                              shadowColor: kPrimaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Container(
                                color: Colors.white,
                                child: DropdownButtonFormField<String>(
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: const BorderSide(
                                        color: Colors.transparent,
                                        width: 3,
                                      ),
                                    ),
                                    fillColor: Colors.transparent,
                                    filled: true,
                                  ),
                                  dropdownColor: kPrimaryLightColor,
                                  hint: Row(
                                    children: [
                                      Text(
                                        user.gender ?? "".tr,
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 117, 117, 117)),
                                      ),
                                    ],
                                  ),
                                  value: gender,
                                  onChanged: (String? newValue) {
                                    if (mounted)
                                      setState(() {
                                        gender = newValue!;
                                      });
                                  },
                                  items: <String>['male'.tr, 'Female'.tr]
                                      .map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Row(
                                        children: [
                                          // Icon(
                                          //   Icons
                                          //       .location_city, // You can use a different icon
                                          //   color: Colors
                                          //       .transparent, // Set icon color to kPrimaryColor
                                          // ),
                                          // SizedBox(
                                          //   width: 15,
                                          // ),
                                          Text(
                                            value,
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 117, 117, 117)),
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                ),
                              )),
                          Material(
                            elevation: 4,
                            shadowColor: kPrimaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextField(
                              decoration: InputDecoration(
                                  hintText: user.phone.toString(),
                                  hintStyle: TextStyle(
                                    letterSpacing: 2,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  fillColor: Colors.white30,
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide.none)),
                              onChanged: (value) {
                                setState(() {
                                  phone = (value);
                                });
                              },
                            ),
                          ),
                          Container(
                            height: 55,
                            width: double.infinity,
                            child: Provider<EditProfile>(
                              create: (context) {
                                return EditProfile();
                              },
                              child: Container(
                                padding: const EdgeInsets.only(top: 10),
                                child: Consumer<EditProfile>(
                                    builder: (context, data, child) {
                                  return ElevatedButton(
                                    onPressed: () {
                                      // data.createJsonData(firstName, lastName,
                                      //     phone, gender, email, image);
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //     builder: (context) {
                                      //       return WelcomeScreen();
                                      //     },
                                      //   ),
                                      // );

                                      if (firstName != null) {
                                        user.firstName = firstName;
                                      }
                                      if (lastName != null)
                                        user.lastName = lastName;
                                      if (phone != null) user.phone = phone;
                                      if (gender != null) user.gender = gender;
                                      if (email != null) user.email = email;
                                      if (city != null) user.city = city;

                                      Provider.of<Services>(context,
                                              listen: false)
                                          .updateUserInfo(user, image);
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      "Save",
                                      style: TextStyle(
                                          fontSize: 17, color: Colors.white),
                                    ),
                                  );
                                }),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
