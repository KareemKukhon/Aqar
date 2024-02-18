import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/homepage/home_prop.dart';
import 'package:flutter_auth/Screens/homepage/recom_listView.dart';
import 'package:flutter_auth/constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: homepage(),
    );
  }
}

class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  _homepageState createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HorizontalListView(),
        Flexible(
          flex: 1,
          child: HomeVerticalListView(),
        )
      ],
    );
  }
}
