import 'dart:io';
import 'package:buttons_panel/buttons_panel.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Welcome/welcome_screen.dart';
import 'package:flutter_auth/data/Property.dart';
import 'package:flutter_auth/data/SignUpData.dart';
import 'package:flutter_auth/services/services.dart';
import 'package:flutter_auth/Screens/paypal/paypal.dart';
import 'package:flutter_auth/pickLocation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_auth/constants.dart';
import 'package:get/get.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:flutter_auth/data/Cities.dart';
import 'package:provider/provider.dart';

class AddPageForm extends StatefulWidget {
  @override
  _AddPageFormState createState() => _AddPageFormState();
}

class _AddPageFormState extends State<AddPageForm> {
  Services service = new Services();
  PropertyModel? propertyData;
  int currentIndex = 0;
  int prop_type = 0;
  bool selectedRorB = true;
  bool _isVisible = false;
  File? image;
  final Imagepicker = ImagePicker();
  final ImagePicker imagesPicker = ImagePicker();
  List<XFile> ImageFileList = [];
  final List<String> time = [
    'Month',
    '6 Months',
    'Year',
  ];
  final List<String> chaletTime = [
    '12 Hour',
    '24 Hour',
  ];
  uploadImages() async {
    final List<XFile> selectedImages = await imagesPicker.pickMultiImage();
    // print("$selectedImages");
    if (selectedImages.isNotEmpty) {
      ImageFileList.addAll(selectedImages);
      // print("$ImageFileList");
    }
    setState(() {});
  }

  uploadImage() async {
    var pickedImage = await Imagepicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        image = File(pickedImage.path);
        // print("$image");
      });
    } else {}
  }

  final List<DropdownMenuItem<String>> cityItems = cities().map((city) {
    return DropdownMenuItem<String>(
      value: city,
      child: Text(city.tr, style: TextStyle(fontSize: 20)),
    );
  }).toList();
  String? selectedtime;
  String? selectedCity;
  String? selectedStreet;

  String? selectedArea;
  double? selectedPrice;
  String? selectedBed;
  String? selectedBath;
  String? selectedGarage;

  String? selectedDescription;
  LatLng? selectedLocation;

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<Services>(context).userRes;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                "Add New Property",
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
              textOff: 'Sale',
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ButtonsPanel(
                  currentIndex: prop_type,
                  borderRadius: BorderRadius.circular(15),
                  backgroundColor: Colors.black.withOpacity(0.05),
                  selectedItemBackgroundColor: Theme.of(context).primaryColor,
                  selectedIconThemeData:
                      const IconThemeData(color: Colors.white),
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  selectedTextStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  unselectedTextStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  onTap: (value) => setState(
                    () => prop_type = value,
                  ),
                  children: const [
                    Text("Home"),
                    Text("Apartment"),
                    Text("Land"),
                    Text("Chalet"),
                    //Text("other")
                  ],
                ),
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
                  'Select City',
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
                  height: MediaQuery.sizeOf(context).height * 0.06,
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
                padding: EdgeInsets.symmetric(horizontal: 9),
                child: TextButton(
                  onPressed: () async {
                    pickPicFlag = 1;
                    // Call pickLocation and wait for the result
                    selectedLocation = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => pickLocationScreen()),
                    );
                    print("gkkkkkkkkkkkkkkkkkkkkkkkkkgg");
                    // Handle the selected location
                    if (selectedLocation != null) {
                      // Do something with the selected location
                      print("Selected Location: $selectedLocation");

                      // Assuming you want to update the city based on the selected location
                      // You might need to implement your own logic her
                    } else {
                      print("gkkkkkkkkkkkkkkkkkkkkkkkkkgg");
                    }
                  },
                  child: Center(
                    child: Container(
                      //color: Colors.white,
                      child: Row(
                        children: [
                          Text(
                            'Location'.tr,
                            style: TextStyle(
                                color: Color.fromARGB(255, 117, 117, 117),
                                fontSize: 17),
                          ),
                        ],
                      ),
                    ),
                  ),
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
                    if (value != "") {
                      setState(() {
                        selectedArea = (value);
                      });
                    }
                  },
                  style: TextStyle(fontSize: 16),
                  keyboardType: TextInputType.number,
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
                  "Property Price",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              )),
          Visibility(
            visible: selectedRorB,
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: DropdownButtonHideUnderline(
                child: DropdownButton2<String>(
                  isExpanded: true,
                  hint: Text(
                    'Duration of renting the property',
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                  items: (prop_type == 3)
                      ? chaletTime
                          .map((String item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ))
                          .toList()
                      : time
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
                    hintText: 'Price (JOD)',
                    filled: true,
                    fillColor: Colors.white,
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                  onChanged: (value) {
                    setState(() {
                      selectedPrice = double.parse(value);
                    });
                  },
                  style: TextStyle(fontSize: 16),
                  keyboardType: TextInputType.number,
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
                  "Property Description",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              )),
          Offstage(
            offstage: !(prop_type == 0 || prop_type == 1 || prop_type == 3),
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
                          enabled: prop_type == 0 ||
                              prop_type == 1 ||
                              prop_type == 3,
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
                          enabled: prop_type == 0 ||
                              prop_type == 1 ||
                              prop_type == 3,
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
                          enabled: prop_type == 0 ||
                              prop_type == 1 ||
                              prop_type == 3,
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
                              selectedGarage = value;
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
            width: MediaQuery.sizeOf(context).width * 0.84,
            height: MediaQuery.sizeOf(context).height * 0.25,
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
                    hintText: 'Description',
                    //hintStyle: TextStyle(color: ),
                    filled: true,
                    fillColor: Colors.white,
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                  onChanged: (value) {
                    setState(() {
                      selectedDescription = value;
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
                  "Property Pictures",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              )),
          Padding(
              padding: const EdgeInsets.only(top: 0),
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.sizeOf(context).width * 0.5,

                    //margin: EdgeInsets.only(left: 10),
                    alignment: Alignment.topCenter,
                    //color: Colors.amber,
                    child: Text(
                      "Property Basic Image",
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.15,
                  ),
                  Container(
                    //color: Colors.blue,
                    width: 55,
                    child: MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              10.0), // Adjust the radius as needed
                          // You can also use other border properties like side to control border width and color
                        ),
                        onPressed: uploadImage,
                        color: kPrimaryColor,
                        child: Container(
                          //color: Colors.amber,
                          padding: EdgeInsets.only(right: 30),
                          child: Icon(
                            Icons.image,
                            color: Colors.white,
                          ),
                        )),
                  ),
                ],
              )),
          Padding(
              padding: const EdgeInsets.only(top: 0),
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.sizeOf(context).width * 0.55,
                    //color: kPrimaryColor,
                    margin: EdgeInsets.only(left: 35),
                    alignment: Alignment.topCenter,
                    //color: Colors.amber,
                    child: Text(
                      "Property Images (Select 4 Please)",
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.025,
                  ),
                  Container(
                    //color: Colors.blue,
                    width: 55,
                    child: MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              10.0), // Adjust the radius as needed
                          // You can also use other border properties like side to control border width and color
                        ),
                        onPressed: uploadImages,
                        color: kPrimaryColor,
                        child: Container(
                          //color: Colors.amber,
                          padding: EdgeInsets.only(right: 30),
                          child: Icon(
                            Icons.image,
                            color: Colors.white,
                          ),
                        )),
                  )
                ],
              )),
          SizedBox(
            height: 10,
          ),
          Visibility(
            visible: _isVisible,
            child: Text(
              'fill'.tr.toUpperCase(),
              style: TextStyle(
                  color: Colors.red, fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
          Provider<PropertyModel>(
            create: (context) {
              return PropertyModel();
            },
            child: Container(
              width: MediaQuery.sizeOf(context).width * 0.5,
              padding: const EdgeInsets.only(top: 10),
              child: Consumer<PropertyModel>(builder: (context, data, child) {
                return ElevatedButton(
                  onPressed: () async {
                    if (selectedRorB) {
                      if (selectedCity == "" ||
                          selectedStreet == "" ||
                          selectedArea == "" ||
                          selectedtime == "" ||
                          selectedPrice == "" ||
                          selectedBed == "" ||
                          selectedBath == "" ||
                          selectedGarage == "" ||
                          selectedDescription == "" ||
                          image == "" ||
                          ImageFileList.length == 0) {
                        if (mounted)
                          setState(() {
                            _isVisible = true;
                          });
                      } else {
                        if (mounted)
                          setState(() {
                            _isVisible = false;
                          });
                        propertyData = PropertyModel(
                            owner: user,
                            rentOrBuy: "Rent",
                            propType: prop_type.toString(),
                            selectedCity: selectedCity,
                            selectedStreet: selectedStreet,
                            selectedArea: (selectedArea!),
                            selectedTime: selectedtime,
                            selectedPrice: (selectedPrice!),
                            selectedBed: (selectedBed),
                            selectedBath: (selectedBath),
                            selectedGarage: (selectedGarage),
                            selectedDescription: selectedDescription,
                            latitude: selectedLocation?.latitude,
                            longitude: selectedLocation?.longitude,
                            // file: await image!.readAsBytes() as String,
                            imageFileList: []
                            // await Future.wait(
                            //   ImageFileList.map((file) async => await file.readAsBytes() as String),
                            // ),
                            );

                        Map<String, dynamic> propertyDataMap =
                            propertyData!.toMap();

                        // service.saveProperty(
                        //     image!, propertyDataMap, ImageFileList);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return CheckoutPage(
                                  image: image,
                                  propertyData: propertyData!,
                                  imageFileList: ImageFileList);
                            },
                          ),
                        );
                      }
                    } else {
                      if (selectedCity == "" ||
                          selectedStreet == "" ||
                          selectedArea == "" ||
                          selectedPrice == "" ||
                          selectedBed == "" ||
                          selectedBath == "" ||
                          selectedGarage == "" ||
                          selectedDescription == "" ||
                          image == "" ||
                          ImageFileList.length == 0) {
                        if (mounted)
                          setState(() {
                            _isVisible = true;
                          });
                      } else {
                        if (mounted)
                          setState(() {
                            _isVisible = false;
                          });
                        // print("user = " + user.toString());
                        propertyData = PropertyModel(
                            owner: user,
                            rentOrBuy: "Sale",
                            propType: prop_type.toString(),
                            selectedCity: selectedCity,
                            selectedStreet: selectedStreet,
                            selectedArea: (selectedArea!),
                            selectedTime: selectedtime,
                            selectedPrice: (selectedPrice!),
                            selectedBed: (selectedBed),
                            selectedBath: (selectedBath),
                            selectedGarage: (selectedGarage),
                            selectedDescription: selectedDescription,
                            // file: await image!.readAsBytes() as String,
                            imageFileList: []
                            // await Future.wait(
                            //   ImageFileList.map((file) async => await file.readAsBytes() as String),
                            // ),
                            );

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return CheckoutPage(
                                  image: image,
                                  propertyData: propertyData!,
                                  imageFileList: ImageFileList);
                            },
                          ),
                        );
                      }
                    }
                  },
                  child: Text(
                    "Add Proparety",
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
