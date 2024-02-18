import 'package:flutter/material.dart';
import 'package:flutter_auth/responsive.dart';
import 'package:get/get.dart';
//import 'package:lottie/lottie.dart';

import '../../../constants.dart';

class LoginScreenTopImage extends StatelessWidget {
  const LoginScreenTopImage({
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
              "welcomeBack".tr.toUpperCase(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: defaultPadding * 2),
            Row(
              children: [
                const Spacer(),
                Expanded(
                  flex: 8,
                  child: Image.asset('assets/images/signuphome.png'),
                ),
                const Spacer(),
              ],
            ),
            const SizedBox(height: defaultPadding * 2),
          ],
        ),
        desktop: Column(
          children: [
            Text(
              "welcomeBack".tr.toUpperCase(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: defaultPadding * 2),
            Row(
              children: [
                const Spacer(),
                Expanded(
                  flex: 8,
                  child: Image.asset('assets/images/signuphome.png'),
                ),
                const Spacer(),
              ],
            ),
            const SizedBox(height: defaultPadding * 2),
          ],
        ),
      ),
    ));
  }
}
