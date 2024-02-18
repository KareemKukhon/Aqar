import 'package:flutter/material.dart';
import 'package:flutter_auth/constants.dart';
import 'package:get/get.dart';

class forgetPassword extends StatelessWidget {
 final bool login;
  final Function? press;
  const forgetPassword({
    Key? key,
    this.login = true,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return 
    Container(
     
      padding: EdgeInsets.only(bottom: 10),
      child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        
        GestureDetector(
          onTap: press as void Function()?,
          child: Text(
            'Forget'.tr,
            style: const TextStyle(
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
        
      ],
    ),
    );
    
  }
}
