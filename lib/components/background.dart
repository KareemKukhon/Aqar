import 'package:flutter/material.dart';
import 'package:flutter_auth/constants.dart';
import 'package:get/get.dart';
import '../locale/locale_controller.dart';

class Background extends StatefulWidget {
  final Widget child;
  const Background({
    Key? key,
    required this.child,
    this.topImage = "assets/images/main_top.png",
    this.bottomImage = "assets/images/login_bottom.png",
  }) : super(key: key);

  final String topImage, bottomImage;

  @override
  _BackgroundState createState() => _BackgroundState();
}

class _BackgroundState extends State<Background> {
  MylocalController Controllerlang = Get.find();
  void toggleLanguage() {
    if (mounted)
      setState(() {
        isEnglish = !isEnglish;
        buttonText = isEnglish
            ? 'English'
            : 'العربية'; // Toggle between English and Arabic
        if (buttonText == 'English') {
          Controllerlang.changeLang("en");
        } else {
          Controllerlang.changeLang("ar");
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        // color: Colors.red,
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: <Widget>[
            Positioned(
              bottom: 0,
              right: 0,
              child: Image.asset(widget.bottomImage, width: 120),
            ),
            // Background image at the bottom

            // Main content
            SafeArea(
              child: widget.child,
            ),
            // Button on top
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Positioned(
                  top: 30,
                  right: 20,
                  child: ElevatedButton(
                    onPressed: () {
                      toggleLanguage();
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(100, 50),
                    ),
                    child: Text(
                      buttonText,
                      style: TextStyle(fontSize: 15.0, color: Colors.white),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  child: Image.asset(
                    widget.topImage,
                    width: 120,
                  ),
                ),
              ],
            ),
            // Bottom image at the very top
          ],
        ),
      ),
    );
  }
}
