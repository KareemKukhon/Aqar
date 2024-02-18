import 'package:flutter/material.dart';
import '../../components/background.dart';
import '../../responsive.dart';
import 'components/login_signup_btn.dart';
import 'components/welcome_image.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const Background(
      child: Align(
        alignment: Alignment.center,
        child: SafeArea(
            child: SingleChildScrollView(
          child: Responsive(
            desktop: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: WelcomeImage(),
                ),
                SizedBox(
                  width: 80,
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(child: LoginAndSignupBtn()),
                    ],
                  ),
                ),
                SizedBox(
                  width: 80,
                ),
              ],
            ),
            mobile: MobileWelcomeScreen(),
          ),
        )),
      ),
    );
  }
}

class MobileWelcomeScreen extends StatefulWidget {
  const MobileWelcomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  _MobileWelcomeScreenState createState() => _MobileWelcomeScreenState();
}

class _MobileWelcomeScreenState extends State<MobileWelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          WelcomeImage(),
          Row(
            children: [
              Spacer(),
              Expanded(
                flex: 8,
                child: LoginAndSignupBtn(),
              ),
              Spacer(),
            ],
          ),
        ],
      ),
    );
  }
}
