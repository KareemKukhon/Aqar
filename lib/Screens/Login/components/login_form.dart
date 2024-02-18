import 'dart:developer';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/navbar/bottom_bar.dart';
import 'package:flutter_auth/components/forget_password.dart';
import 'package:flutter_auth/data/LoginData.dart';
import 'package:flutter_auth/data/SignUpData.dart';
import 'package:flutter_auth/services/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../components/already_have_an_account_acheck.dart';
import '../../../constants.dart';
import '../../Signup/signup_screen.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  String email = "";
  String password = "";
  bool _isVisible = false;
  Services services = new Services();

  getToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    log("token: " + token.toString());
  }

  @override
  void initState() {
    getToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Provider.of<Services>(context, listen: false).fetchDataFromServer();
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            // color: Colors.red,
            child: Form(
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    cursorColor: kPrimaryColor,
                    onSaved: (email) {},
                    decoration: InputDecoration(
                      hintText: "email".tr,
                      prefixIcon: const Padding(
                        padding: EdgeInsets.all(defaultPadding),
                        child: Icon(Icons.person),
                      ),
                    ),
                    onChanged: (text) {
                      if (mounted)
                        setState(() {
                          email = text;
                        });
                    },
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: defaultPadding),
                    child: TextFormField(
                      textInputAction: TextInputAction.done,
                      obscureText: true,
                      cursorColor: kPrimaryColor,
                      decoration: InputDecoration(
                        hintText: "password".tr,
                        prefixIcon: Padding(
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
                  const SizedBox(height: defaultPadding),
                  Provider<logindata>(
                    create: (context) {
                      return logindata();
                    },
                    child: Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      child:
                          Consumer<logindata>(builder: (context, data, child) {
                        return ElevatedButton(
                          onPressed: () async {
                            if (email == "" || password == "") {
                              if (mounted)
                                setState(() {
                                  _isVisible = true;
                                });
                            } else {
                              if (mounted)
                                setState(() {
                                  _isVisible = false;
                                });
                              final user = logindata(
                                email: email,
                                password: password,
                              );

                              final loggedUser = await Provider.of<Services>(
                                      context,
                                      listen: false)
                                  .login(email, password);
                              // print(loggedUser);
                              if (loggedUser != null) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return BottomBar();
                                    },
                                  ),
                                );
                                // print("hellow world");
                              }
                            }
                          },
                          child: Text(
                            "Login".tr.toUpperCase(),
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      }),
                    ),
                  ),
                  //const SizedBox(height: defaultPadding),
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
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return SignUpScreen();
                          },
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: defaultPadding),
                  // forgetPassword(
                  //   press: () {
                  //     showEnterEmailDialog(context);
                  //   },
                  // ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

Services services = new Services();
User? userData;
void showEnterEmailDialog(BuildContext context, User user) {
  TextEditingController emailController = TextEditingController();
  List<TextEditingController> controllers =
      List.generate(6, (index) => TextEditingController());
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Column(
          children: [
            Center(
              child: Text(
                'forget'.tr,
                style: TextStyle(color: kPrimaryColor),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                'EnterEmail'.tr,
                style: TextStyle(fontSize: 10, color: Colors.grey),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Image.asset('assets/images/mail1.png'),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: TextFormField(
                controller: emailController,
                textInputAction: TextInputAction.done,
                // obscureText: true,
                cursorColor: kPrimaryColor,
                decoration: InputDecoration(
                  hintText: "email".tr,
                  prefixIcon: const Padding(
                    padding: EdgeInsets.all(defaultPadding),
                    child: Icon(Icons.email_sharp),
                  ),
                ),
              ),
            )
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              // Close the dialog
              Navigator.of(context).pop();
            },
            child: Text(
              'Cancel'.tr,
              style: TextStyle(color: kPrimaryColor),
            ),
          ),
          TextButton(
            onPressed: () {
              userData = user;
              services.confirmEmail(user, emailController.text);
              // showForgetPasswordDialog(context, user);
            },
            child: Text(
              'continue'.tr,
              style: TextStyle(color: kPrimaryColor),
            ),
          ),
        ],
      );
    },
  );
}

void showForgetPasswordDialog(
    BuildContext context, User user, String useCode, File? imageFile) {
  // Services services = new Services();
  List<TextEditingController> controllers =
      List.generate(6, (index) => TextEditingController());
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Column(
          children: [
            Center(
              child: Text(
                'Verification'.tr,
                style: TextStyle(color: kPrimaryColor),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                'code'.tr,
                style: TextStyle(fontSize: 10, color: Colors.grey),
              ),
            ),
            Center(
              child: Image.asset('assets/images/password.jpg'),
            )
          ],
        ),
        content: Row(
          children: [
            for (int i = 0; i < 6; i++)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(4.6),
                  child: TextField(
                    style: TextStyle(color: Colors.black),
                    cursorColor: kPrimaryColor,
                    controller: controllers[i],
                    keyboardType: TextInputType.number,
                    maxLength: 1, // Limit input to 1 character
                    textAlign: TextAlign.center,
                    // Center-align the text
                    decoration: InputDecoration(
                        // hintText: '0',
                        ),
                  ),
                ),
              ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              // Close the dialog
              Navigator.of(context).pop();
            },
            child: Text(
              'Previous'.tr,
              style: TextStyle(color: kPrimaryColor),
            ),
          ),
          TextButton(
            onPressed: () {
              String code = "";
              controllers.forEach((controller) {
                code += controller.text;
              });
              if (useCode == code.toString())
                services.registerUser(code, user, imageFile);
              print("code = " + code.toString());
              Navigator.of(context).pop();
              // Perform password reset logic here
              // You can add your password reset functionality
              // and then close the dialog.
              // Navigator.of(context).pop();
            },
            child: Text(
              'Verify'.tr,
              style: TextStyle(color: kPrimaryColor),
            ),
          ),
        ],
      );
    },
  );
}
