import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/searchpage/components/searchPage.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: searchpage(),
    );
  }
}

class searchpage extends StatefulWidget {
  const searchpage({Key? key}) : super(key: key);

  @override
  _searchpageState createState() => _searchpageState();
}

class _searchpageState extends State<searchpage> {
  
   @override
  Widget build(BuildContext context) {
    return  Scaffold(
      //backgroundColor: Colors.blue,
      body: SearchPageForm(),
    );
  }
}

