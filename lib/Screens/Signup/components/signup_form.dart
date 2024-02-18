import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Login/components/login_form.dart';
import 'package:flutter_auth/components/forget_password.dart';
import 'package:flutter_auth/data/SignUpData.dart';
import 'package:flutter_auth/pickLocation.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../../components/already_have_an_account_acheck.dart';
import '../../../constants.dart';
import '../../Login/login_screen.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  String? gender = 'male';
  String? city;
  String FirstName = "", LastName = "", password = "", email = "", phone = "";
  bool _isVisible = false;
  File? image;
  final Imagepicker = ImagePicker();
  LatLng? selectedLocation;
  uploadImage() async {
    var pickedImage = await Imagepicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        image = File(pickedImage.path);
        print("$image");
      });
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              //color: Colors.red,
              child: Form(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              textInputAction: TextInputAction.done,
                              obscureText: false,
                              cursorColor: kPrimaryColor,
                              decoration: InputDecoration(
                                hintText: "FirstName".tr,
                                prefixIcon: const Padding(
                                  padding: EdgeInsets.all(defaultPadding),
                                  child: Icon(Icons.person),
                                ),
                              ),
                              onChanged: (text) {
                                if (mounted)
                                  setState(() {
                                    FirstName = text;
                                  });
                              },
                            ),
                          ),
                          const SizedBox(
                              width:
                                  16), // Adjust the width as needed for spacing between fields
                          Expanded(
                            child: TextFormField(
                              textInputAction: TextInputAction.done,
                              obscureText: false,
                              cursorColor: kPrimaryColor,
                              decoration: InputDecoration(
                                hintText: "LastName".tr,
                                prefixIcon: const Padding(
                                  padding: EdgeInsets.all(defaultPadding),
                                  child: Icon(Icons.person_add_alt_1),
                                ),
                              ),
                              onChanged: (text) {
                                if (mounted)
                                  setState(() {
                                    LastName = text;
                                  });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Container(
                        //width: 400,
                        height: 55,
                        decoration: BoxDecoration(
                          color: kPrimaryLightColor, // Red color
                          borderRadius:
                              BorderRadius.circular(30), // Rounded corners
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                "   Personal Photo".tr,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(right: 20, bottom: 10),
                              //color: Colors.blue,
                              padding: EdgeInsets.only(top: 10),
                              width: 55,
                              child: MaterialButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        10.0), // Adjust the radius as needed
                                    // You can also use other border properties like side to control border width and color
                                  ),
                                  onPressed: uploadImage,
                                  color: kPrimaryColor,
                                  child: Container(
                                    //color: Colors.amber,
                                    padding: EdgeInsets.only(right: 30),
                                    child: Icon(
                                      Icons.image,
                                      color: Colors.white,
                                    ),
                                  )),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Container(
                        //width: 400,
                        height: 55,
                        decoration: BoxDecoration(
                          color: kPrimaryLightColor, // Red color
                          borderRadius:
                              BorderRadius.circular(30), // Rounded corners
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Radio(
                                      value: "male",
                                      groupValue: gender,
                                      activeColor: kPrimaryColor,
                                      onChanged: (value) {
                                        if (mounted)
                                          setState(() {
                                            gender = value as String?;
                                          });
                                      },
                                    ),
                                    Icon(
                                      Icons.male,
                                      color: kPrimaryColor,
                                      size: 30,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                  width:
                                      16), // Adjust the width as needed for spacing between fields
                              Expanded(
                                child: Row(
                                  children: [
                                    Radio(
                                      value: "female",
                                      groupValue: gender,
                                      activeColor: kPrimaryColor,
                                      onChanged: (value) {
                                        if (mounted)
                                          setState(() {
                                            gender = value as String?;
                                          });
                                      },
                                    ),
                                    Icon(
                                      Icons.female,
                                      color: kPrimaryColor,
                                      size: 30,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        cursorColor: kPrimaryColor,
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText: "email".tr,
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(defaultPadding),
                            child: Icon(Icons.email),
                          ),
                        ),
                        onChanged: (text) {
                          if (mounted)
                            setState(() {
                              email = text;
                            });
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: TextFormField(
                        textInputAction: TextInputAction.done,
                        obscureText: false,
                        cursorColor: kPrimaryColor,
                        decoration: InputDecoration(
                          hintText: "phone".tr,
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(defaultPadding),
                            child: Icon(Icons.phone),
                          ),
                        ),
                        onChanged: (text) {
                          if (mounted)
                            setState(() {
                              phone = text;
                            });
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Center(
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
                              fillColor: kPrimaryLightColor,
                              filled: true,
                            ),
                            dropdownColor: kPrimaryLightColor,
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
                                  'City'.tr,
                                  style: TextStyle(
                                      color:
                                          Color.fromARGB(255, 117, 117, 117)),
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
                              'Nablus',
                              'Hebron',
                              'Bethlehem',
                              'Ramallah',
                              'Jenin', // Ensure 'Jenin' appears only once
                              'Jerusalem',
                              'Gaza',
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
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: TextFormField(
                        textInputAction: TextInputAction.done,
                        obscureText: true,
                        cursorColor: kPrimaryColor,
                        decoration: InputDecoration(
                          hintText: "password".tr,
                          prefixIcon: const Padding(
                            padding: EdgeInsets.all(defaultPadding),
                            child: Icon(Icons.lock),
                          ),
                        ),
                        onChanged: (text) {
                          if (mounted)
                            setState(() {
                              password = text;
                            });
                        },
                      ),
                    ),
                    Provider<User>(
                      create: (context) {
                        return User();
                      },
                      child: Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: Consumer<User>(builder: (context, data, child) {
                          return ElevatedButton(
                            onPressed: () async {
                              if (FirstName == "" ||
                                  LastName == "" ||
                                  gender == "" ||
                                  phone == "" ||
                                  city == null ||
                                  email == "" ||
                                  password == "") {
                                if (mounted)
                                  setState(() {
                                    _isVisible = true;
                                  });
                              } else {
                                if (mounted)
                                  setState(() {
                                    _isVisible = false;
                                  });

                                // Create a UserModel with the user data
                                final user = User(
                                    firstName: FirstName,
                                    lastName: LastName,
                                    gender: gender!,
                                    email: email,
                                    phone: phone,
                                    city: city!,
                                    password: password,
                                    visitedCities: [],
                                    contacts: []);

                                // Call the registerUser function to send the user data to the backend
                                // services.confirmEmail(user);
                                // forgetPassword(
                                // press: () {

                                String code = await services.confirmEmail(
                                    user, user.email);
                                showForgetPasswordDialog(context, user, code, image);
                                // },
                                // );
                              }
                            },
                            child: Text(
                              "SignUp".tr.toUpperCase(),
                              style: TextStyle(color: Colors.white),
                            ),
                          );
                        }),
                      ),
                    ),
                    Visibility(
                      visible: _isVisible,
                      child: Text(
                        'fill'.tr.toUpperCase(),
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: defaultPadding),
                    AlreadyHaveAnAccountCheck(
                      login: false,
                      press: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return LoginScreen();
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
