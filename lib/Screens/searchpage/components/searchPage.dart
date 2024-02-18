import 'dart:developer';
import 'dart:io';
import 'package:buttons_panel/buttons_panel.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Welcome/welcome_screen.dart';
import 'package:flutter_auth/Screens/homepage/chatbotProp.dart';
import 'package:flutter_auth/data/Property.dart';
import 'package:flutter_auth/data/SearchByData.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/services/services.dart';
import 'package:get/get.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:flutter_auth/data/Cities.dart';
import 'package:provider/provider.dart';
import 'package:range_slider_flutter/range_slider_flutter.dart';

class SearchPageForm extends StatefulWidget {
  @override
  _SearchPageFormState createState() => _SearchPageFormState();
}

class _SearchPageFormState extends State<SearchPageForm> {
  int currentIndex = 0;
  int _counter = 0;
  double _lowerValue = 100;
  double _upperValue = 300;
  int prop_type = 0;
  bool isSliderUpdating = false;
  final List<DropdownMenuItem<String>> cityItems = cities().map((city) {
    return DropdownMenuItem<String>(
      value: city,
      child: Text(city.tr, style: TextStyle(fontSize: 20)),
    );
  }).toList();
  String? selectedCity;
  String? selectedStreet;
  double? selectedArea;
  String? selectedBed;
  String? selectedBath;
  String? selectedGarage;
  bool selectedRorB = true;
  bool priceFlag = false;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                "Search for a Property",
                style: TextStyle(fontSize: 25),
              ),
            ),
          ),
          Center(
              child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: LiteRollingSwitch(
              value: true,
              width: MediaQuery.sizeOf(context).width * 0.4,
              textOn: 'Rent',
              textOff: 'Buy',
              textSize: 18,
              colorOn: kPrimaryColor,
              colorOff: kPrimaryColor,
              iconOn: Icons.arrow_back,
              iconOff: Icons.arrow_forward,
              textOffColor: Colors.white,
              textOnColor: Colors.white,
              // animationDuration: const Duration(milliseconds: 300),
              onChanged: (bool state) {
                setState(() {
                  selectedRorB = state;
                  print(selectedRorB);
                });
              },
              onDoubleTap: () {},
              onSwipe: () {},
              onTap: () {},
            ),
          )),
          Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(left: 20),
              child: const Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  "Property Type",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              )),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ButtonsPanel(
              currentIndex: prop_type,
              borderRadius: BorderRadius.circular(15),
              backgroundColor: Colors.black.withOpacity(0.05),
              selectedItemBackgroundColor: Theme.of(context).primaryColor,
              selectedIconThemeData: const IconThemeData(color: Colors.white),
              padding: const EdgeInsets.symmetric(horizontal: 32),
              selectedTextStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              unselectedTextStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              onTap: (value) => setState(
                () => prop_type = value,
              ),
              children: const [
                Text("ALL"),
                Text("Home"),
                Text("Apartment"),
                Text("Land"),
                Text("Chalet"),
                //
              ],
            ),
          ),
          Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(left: 20),
              child: const Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  "Property Address",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              )),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: DropdownButtonHideUnderline(
              child: DropdownButton2<String>(
                isExpanded: true,
                hint: Text(
                  'All',
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).hintColor,
                  ),
                ),
                items: cityItems,
                value: selectedCity,
                onChanged: (String? value) {
                  setState(() {
                    selectedCity = value;
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
                  height: MediaQuery.sizeOf(context).height * 0.065,
                  width: MediaQuery.sizeOf(context).width * 0.85,
                ),
                menuItemStyleData: const MenuItemStyleData(
                  height: 40,
                ),
              ),
            ),
          ),
          Container(
            width: MediaQuery.sizeOf(context).width * 0.85,
            height: MediaQuery.sizeOf(context).height * 0.085,
            padding: const EdgeInsets.only(top: 20),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: Colors.black26,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 9),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Street',
                    //hintStyle: TextStyle(color: ),
                    filled: true,
                    fillColor: Colors.white,
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                  onChanged: (value) {
                    // Update the variable when the text changes
                    setState(() {
                      selectedStreet = value;
                    });
                  },
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ),
          Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(left: 20),
              child: const Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  "Property Area",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              )),
          Container(
            width: MediaQuery.sizeOf(context).width * 0.85,
            height: MediaQuery.sizeOf(context).height * 0.085,
            padding: const EdgeInsets.only(top: 20),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: Colors.black26,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 9),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Area (m2)',
                    //hintStyle: TextStyle(color: ),
                    filled: true,
                    fillColor: Colors.white,
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                  onChanged: (value) {
                    setState(() {
                      selectedArea = (value) as double?;
                    });
                  },
                  style: TextStyle(fontSize: 16),
                  keyboardType: TextInputType.number,
                ),
              ),
            ),
          ),
          Offstage(
            offstage: !(prop_type == 1 || prop_type == 2 || prop_type == 4),
            child: Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(left: 20),
                child: const Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    "Property Description",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                )),
          ),
          Offstage(
            offstage: !(prop_type == 1 || prop_type == 2 || prop_type == 4),
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                children: [
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.085,
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: Colors.black26,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 9),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'BedRooms',
                            //hintStyle: TextStyle(color: ),
                            filled: true,
                            fillColor: Colors.white,
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                          onChanged: (value) {
                            setState(() {
                              selectedBed = (value);
                            });
                          },
                          style: TextStyle(fontSize: 15),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: Colors.black26,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 9),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'BathRooms',
                            //hintStyle: TextStyle(color: ),
                            filled: true,
                            fillColor: Colors.white,
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                          onChanged: (value) {
                            setState(() {
                              selectedBath = (value);
                            });
                          },
                          style: TextStyle(fontSize: 15),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: Colors.black26,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 9),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Garage',
                            //hintStyle: TextStyle(color: ),
                            filled: true,
                            fillColor: Colors.white,
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                          onChanged: (value) {
                            setState(() {
                              selectedGarage = (value);
                            });
                          },
                          style: TextStyle(fontSize: 15),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.085,
                  ),
                ],
              ),
            ),
          ),
          Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(left: 20),
              child: const Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  "Property Price Range (1 = 10000 JOD)",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              )),
          Container(
            child: RangeSliderFlutter(
              values: [_lowerValue, _upperValue],
              rangeSlider: true,
              tooltip: RangeSliderFlutterTooltip(
                alwaysShowTooltip:
                    isSliderUpdating, // Only show tooltip when updating
                rightSuffix: Text(" JOD"),
                leftSuffix: Text(" JOD"),
              ),
              min: 0,
              max: 999999,
              textPositionTop: 0,
              handlerHeight: 25,
              handlerWidth: MediaQuery.sizeOf(context).width * 0.2,
              textBackgroundColor: kPrimaryColor,
              trackBar: RangeSliderFlutterTrackBar(
                activeTrackBarHeight: 10,
                inactiveTrackBarHeight: 10,
                activeTrackBar: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: kPrimaryColor,
                ),
                inactiveTrackBar: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey,
                ),
              ),
              fontSize: 15,
              onDragging: (handlerIndex, lowerValue, upperValue) {
                _lowerValue = lowerValue;
                _upperValue = upperValue;
                priceFlag = true;
              },
              onDragCompleted:
                  (int handlerIndex, dynamic lowerValue, dynamic upperValue) {
                setState(() {});
              },
            ),
          ),
          Provider<SearchBy>(
            create: (context) {
              return SearchBy();
            },
            child: Container(
              width: MediaQuery.sizeOf(context).width * 0.5,
              padding: const EdgeInsets.only(top: 10),
              child: Consumer<SearchBy>(builder: (context, data, child) {
                return ElevatedButton(
                  onPressed: () async {
                    if (selectedRorB) {
                      if (priceFlag == false) {
                        _lowerValue = 0;
                        _upperValue = 999990;
                      }
                      SearchBy searchBy = SearchBy(
                          rentOrBuy: "Rent",
                          propType: prop_type != 0
                              ? (prop_type - 1).toString()
                              : "10",
                          selectedCity: selectedCity,
                          selectedStreet: selectedStreet,
                          selectedArea: selectedArea?.toDouble(),
                          selectedBed: selectedBed,
                          selectedBath: selectedBath,
                          selectedGarage: selectedGarage,
                          lowerPrice: _lowerValue,
                          upperPrice: _upperValue);
                      log(selectedCity.toString());
                      List<PropertyModel> properties =
                          await Provider.of<Services>(context, listen: false)
                              .getSearchedProperty(searchBy);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return ChatbotProp(
                              propertyList: properties,
                            );
                          },
                        ),
                      );
                    } else {
                      SearchBy searchBy = SearchBy(
                          rentOrBuy: "Sale",
                          propType: prop_type != 0
                              ? (prop_type - 1).toString()
                              : "10",
                          selectedCity: selectedCity,
                          selectedStreet: selectedStreet,
                          selectedArea: selectedArea?.toDouble(),
                          selectedBed: selectedBed,
                          selectedBath: selectedBath,
                          selectedGarage: selectedGarage,
                          lowerPrice: _lowerValue,
                          upperPrice: _upperValue);
                      List<PropertyModel> properties =
                          await Provider.of<Services>(context, listen: false)
                              .getSearchedProperty(searchBy);
                      log(searchBy.selectedCity.toString());
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return ChatbotProp(
                              propertyList: properties,
                            );
                          },
                        ),
                      );
                    }
                  },
                  child: const Text(
                    "Search",
                    style: TextStyle(fontSize: 17, color: Colors.white),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
