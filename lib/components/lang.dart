import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../locale/locale_controller.dart';

class TransButton extends StatefulWidget {
  final Widget child;

  const TransButton({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  _TransButtonState createState() => _TransButtonState();
}

class _TransButtonState extends State<TransButton> {
  MylocalController Controllerlang = Get.find();

  String buttonText = 'English'; // Initialize buttonText to 'English'
  bool isEnglish = true; // Initialize isEnglish to true

  void toggleLanguage() {
    setState(() {
      isEnglish = !isEnglish;
      buttonText = isEnglish ? 'English' : 'العربية';
      if (isEnglish) {
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
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: <Widget>[
            SafeArea(
              child: widget.child,
            ),
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Positioned(
                  top: 30,
                  right: isEnglish ? 20 : null,
                  left: isEnglish ? null : 20,
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
