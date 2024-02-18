import 'dart:developer';
import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/homepage/home.dart';
import 'package:flutter_auth/Screens/homepage/home_prop.dart';
import 'package:flutter_auth/Screens/navbar/bottom_bar.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/data/Property.dart';
import 'package:flutter_auth/services/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_auth/strip_payment/payment_manager.dart';
import 'package:flutter_auth/strip_payment/strip_keys.dart';
import 'package:flutter_paypal_checkout/flutter_paypal_checkout.dart';

class CheckoutPage extends StatefulWidget {
  File? image;
  PropertyModel propertyData;
  List<XFile> imageFileList;
  CheckoutPage({
    Key? key,
    this.image,
    required this.propertyData,
    required this.imageFileList,
  }) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final List<String> time = [
    'Week',
    'Month',
    '3 Months',
  ];
  String? selectedtime;
  double price = 0;
  Services services = new Services();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "PayPal ",
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: Center(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
                "Choose the period you want to keep your ad on the Aqar application, then pay by clicking the Checkout button. "),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text("Week --> 70 JOD"),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text("Month --> 200 JOD "),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text("3 Months --> 400 JOD "),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 20),
            child: DropdownButtonHideUnderline(
              child: DropdownButton2<String>(
                isExpanded: true,
                hint: Text(
                  'How long should your ad be displayed on Aqar? ',
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).hintColor,
                  ),
                ),
                items: time
                    .map((String item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ))
                    .toList(),
                value: selectedtime,
                onChanged: (String? value) {
                  setState(() {
                    selectedtime = value;
                    if (selectedtime == "Week") {
                      price = 70;
                    } else if (selectedtime == "Month") {
                      price = 200;
                    } else {
                      price = 400;
                    }
                  });
                },
                buttonStyleData: ButtonStyleData(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: Colors.black26,
                    ),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  height: MediaQuery.sizeOf(context).height * 0.060,
                  width: MediaQuery.sizeOf(context).width * 0.85,
                ),
                menuItemStyleData: const MenuItemStyleData(
                  height: 40,
                ),
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              if (selectedtime == "Week") {
                widget.propertyData.start = DateTime.now();
                widget.propertyData.end = DateTime.now().add(Duration(days: 7));
                widget.propertyData.price = price;
              } else if (selectedtime == "Month") {
                widget.propertyData.start = DateTime.now();
                widget.propertyData.end =
                    DateTime.now().add(Duration(days: 30));
                widget.propertyData.price = price;
              } else {
                widget.propertyData.start = DateTime.now();
                widget.propertyData.end =
                    DateTime.now().add(Duration(days: 90));
                widget.propertyData.price = price;
              }
              Map<String, dynamic> propertyDatamap =
                  widget.propertyData.toMap();
              services.saveProperty(
                  widget.image!, propertyDatamap, widget.imageFileList);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return BottomBar();
                  },
                ),
              );
            },
            style: TextButton.styleFrom(
                backgroundColor: kPrimaryColor,
                foregroundColor: Colors.white,
                shape: const RoundedRectangleBorder()),
            child: const Text('Checkout'),
          ),
        ],
      )),
    );
  }

  DateTime addMonths(DateTime date, int monthsToAdd) {
    // Using the add method to add months
    return DateTime(date.year, date.month + monthsToAdd, date.day, date.hour,
        date.minute, date.second, date.millisecond, date.microsecond);
  }
}
