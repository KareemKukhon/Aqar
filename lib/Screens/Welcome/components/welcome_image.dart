import 'package:flutter/material.dart';
import 'package:flutter_auth/responsive.dart';
import 'package:get/get.dart';
import 'dart:async';

import '../../../constants.dart';

class WelcomeImage extends StatelessWidget {
  const WelcomeImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        //color: Colors.amber,
        child: SingleChildScrollView(
      child: Responsive(
          mobile: Column(
            children: [
              Text(
                "welcome".tr,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor,
                    fontSize: 30,
                    fontFamily: 'UbuntuMono'),
              ),
              SizedBox(height: defaultPadding * 2),
              Row(
                children: [
                  Spacer(),
                  Expanded(
                    flex: 8,
                    child: BlinkingPhoto(),
                  ),
                  Spacer(),
                ],
              ),
              //SizedBox(height: defaultPadding * 2),
            ],
          ),
          desktop: Column(
            children: [
              Text(
                "welcome".tr,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor,
                    fontSize: 30,
                    fontFamily: 'UbuntuMono'),
              ),
              SizedBox(height: defaultPadding * 2),
              Row(
                children: [
                  Spacer(),
                  Expanded(
                    flex: 3,
                    child: BlinkingPhoto(),
                  ),
                  Spacer(),
                ],
              ),
              //SizedBox(height: defaultPadding * 2),
            ],
          )),
    ));
  }
}

class BlinkingPhoto extends StatefulWidget {
  @override
  _BlinkingPhotoState createState() => _BlinkingPhotoState();
}

class _BlinkingPhotoState extends State<BlinkingPhoto> {
  bool isVisible = true;

  @override
  void initState() {
    super.initState();
    // Start the blinking animation when the widget is initialized
    startBlinking();
  }

  void startBlinking() {
    // Toggle the visibility of the image and box every 500 milliseconds
    Timer.periodic(Duration(milliseconds: 3000), (timer) {
      if (mounted)setState(() {
        isVisible = !isVisible;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: isVisible
          ? Stack(
              alignment:
                  Alignment.bottomLeft, // Align to the left-bottom corner
              children: [
                Image.asset(
                    'assets/images/img3.jpg'), // Replace with your image path
                Positioned(
                  left: 16.0, // Adjust the left margin as needed
                  bottom: 10.0, // Adjust the bottom margin as needed
                  child: Container(
                    width: 200.0, // Adjust width as needed
                    height: 40.0, // Adjust height as needed
                    decoration: BoxDecoration(
                      color: kPrimaryLightColor
                          .withOpacity(0.5), // Semi-transparent black
                      borderRadius:
                          BorderRadius.circular(20.0), // Rounded corners
                    ),
                    child: Center(
                      child: Text(
                        "picstat".tr,
                        style: const TextStyle(
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          : Stack(
              alignment:
                  Alignment.bottomLeft, // Align to the left-bottom corner
              children: [
                Image.asset(
                    'assets/images/img2.jpg'), // Replace with your image path
                Positioned(
                  left: 100.0, // Adjust the left margin as needed
                  bottom: 16.0, // Adjust the bottom margin as needed
                  child: Container(
                    width: 200.0, // Adjust width as needed
                    height: 40.0, // Adjust height as needed
                    decoration: BoxDecoration(
                      color: kPrimaryColor
                          .withOpacity(0.5), // Semi-transparent black
                      borderRadius:
                          BorderRadius.circular(20.0), // Rounded corners
                    ),
                    child: Center(
                      child: Text(
                        "picstat2".tr,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
