import 'package:flutter/material.dart';
import 'package:flutter_auth/responsive.dart';
import 'package:get/get.dart';
import '../../../constants.dart';

class ContactUsTopImage extends StatelessWidget {
  const ContactUsTopImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        //color: Colors.amber,

      child: Responsive(
      mobile: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              "We Can Always Help You ",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17
              ),
            ),
            const SizedBox(height: defaultPadding * 2),
            Row(
              children: [
                const Spacer(),
                Expanded(
                  flex: 8,
                  child: Image.asset('assets/images/mail1.png'),
                ),
                const Spacer(),
              ],
            ),
            const SizedBox(height: defaultPadding * 2),
          ],
        ),
      ),
      desktop: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              "We Can Always Help You ",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                 fontSize: 17
              ),
            ),
            const SizedBox(height: defaultPadding * 2),
            Row(
              children: [
                const Spacer(),
                Expanded(
                  flex: 8,
                  child: Image.asset('assets/images/mail1.png'),
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
