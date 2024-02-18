import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/addpage/components/addPage.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: addpage(),
    );
  }
}

class addpage extends StatefulWidget {
  const addpage({Key? key}) : super(key: key);

  @override
  _addpageState createState() => _addpageState();
}

class _addpageState extends State<addpage> {
  
   @override
  Widget build(BuildContext context) {
    return  Scaffold(
      //backgroundColor: Colors.pink,
     body: AddPageForm(),
    );
  }
}

