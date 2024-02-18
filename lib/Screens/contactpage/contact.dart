import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Login/components/login_form.dart';
import 'package:flutter_auth/Screens/contactpage/components/contactUsTopImage.dart';
import 'package:flutter_auth/constants.dart';

class contactpage extends StatefulWidget {
  const contactpage({Key? key}) : super(key: key);

  @override
  __contactpagState createState() => __contactpagState();
}

class __contactpagState extends State<contactpage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          ContactUsTopImage(),
          Container(
              height: 280,
              width: 300,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.transparent),
              child: Center(
                  child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 15),
                    child: Text(
                      "Call Us on : 0598677382",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15),
                    child: Text(
                      "And Don't Hestitate to contact Us Here :",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  Container(
                    // color: Colors.amber,
                    //height: 130,
                    margin: EdgeInsets.only(top: 15),
                    child: TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                          // fillColor: Colors.white,
                          hintText: "  Your Email",
                          hintStyle: TextStyle(fontSize: 15),
                          focusedErrorBorder: InputBorder.none),
                    ),
                  ),
                  Container(
                    // color: Colors.amber,
                    //height: 130,
                    margin: EdgeInsets.only(top: 15),
                    child: TextField(
                      controller: messageController,
                      decoration: InputDecoration(
                        hintText: "  Type Your Message",
                        hintStyle: TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15),
                    height: 50,
                    child: ElevatedButton(
                        child:
                            Text("Send", style: TextStyle(color: Colors.white)),
                        onPressed: () {
                          services.sendEmail(
                              emailController.text, messageController.text);
                        }),
                  )
                ],
              ))),
        ],
      )),
    );
  }
}
