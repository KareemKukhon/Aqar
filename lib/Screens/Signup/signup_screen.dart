import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Signup/components/sign_up_top_image.dart';
import 'package:flutter_auth/Screens/Signup/components/signup_form.dart';
import 'package:flutter_auth/responsive.dart';
import '../../components/background.dart';

bool flag = false;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Background(
      child: Align(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Responsive(
                mobile: MobileLoginScreen(),
                desktop: SingleChildScrollView(
                  child: Row(
                    children: [
                      Expanded(
                        child: SignUpScreenTopImage(),
                      ),
                      SizedBox(
                        width: 80,
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(child: SignUpForm()),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 80,
                      ),
                    ],
                  ),
                )),
          )),
    );
  }
}

class MobileLoginScreen extends StatefulWidget {
  const MobileLoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  _MobileLoginScreenState createState() => _MobileLoginScreenState();
}

class _MobileLoginScreenState extends State<MobileLoginScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SignUpScreenTopImage(),
        Row(
          children: [
            Spacer(),
            Expanded(
              flex: 8,
              child: SignUpForm(),
            ),
            Spacer(),
          ],
        ),
      ],
    ));
  }
}
