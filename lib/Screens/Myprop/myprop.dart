import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Signup/components/sign_up_top_image.dart';
import 'package:flutter_auth/Screens/Signup/components/signup_form.dart';
import 'package:flutter_auth/Screens/homepage/description.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/data/ItemDescription.dart';
import 'package:flutter_auth/data/Property.dart';
import 'package:flutter_auth/data/removeFromSaved.dart';
import 'package:flutter_auth/data/soldOrRented.dart';
import 'package:flutter_auth/responsive.dart';
import 'package:flutter_auth/services/services.dart';
import 'package:google_maps_flutter_platform_interface/src/types/location.dart';
import 'package:provider/provider.dart';
import '../../components/background.dart';

bool flag = false;

class Myproperties extends StatefulWidget {
  const Myproperties({Key? key}) : super(key: key);

  @override
  _MypropertiesState createState() => _MypropertiesState();
}

class _MypropertiesState extends State<Myproperties> {
  List<PropertyModel> items = [];

  @override
  void initState() {
    super.initState();
    // List<Map<String, dynamic>> propertyList = ItemDescription();
    // items = List.generate(propertyList.length, (index) {
    //   return PropertyItem(
    //     id: propertyList[index]['id'],
    //     owner: propertyList[index]['owner'],
    //     imagePath: propertyList[index]['url'],
    //     type: propertyList[index]['type'],
    //     status: propertyList[index]['status'],
    //     bedroom: propertyList[index]['BedRoom'],
    //     bathroom: propertyList[index]['BathRoom'],
    //     description: propertyList[index]['Description'],
    //     garage: propertyList[index]['garage'],
    //     homepic0: propertyList[index]['homepic0'],
    //     homepic1: propertyList[index]['homepic1'],
    //     homepic2: propertyList[index]['homepic2'],
    //     homepic3: propertyList[index]['homepic3'],
    //     location: propertyList[index]['location'],
    //     city: propertyList[index]['city'],
    //     area: propertyList[index]['area'],
    //   );
    // });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future:
            Provider.of<Services>(context, listen: false).fetchUserProperties(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child:
                    CircularProgressIndicator()); // Loading indicator while waiting
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            items = Provider.of<Services>(context).userPropertyList;
            return Scaffold(
              appBar: AppBar(
                title: Text("My Own Proparites"),
              ),
              body: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          final item =
                              items[index]; // Get the item from the list

                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return ProductItemScreen(item);
                                  },
                                ),
                              );
                            },
                            child: Card(
                              color: Colors.white,
                              margin: const EdgeInsets.all(8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                width: 400,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(5.0),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image.network(
                                          item.image != null
                                              ? "http://192.168.68.51:8083${item.image!}"
                                              : "https://feb.kuleuven.be/drc/LEER/visiting-scholars-1/image-not-available.jpg/image",
                                          width:
                                              MediaQuery.sizeOf(context).width,
                                          height: MediaQuery.sizeOf(context)
                                                  .height *
                                              0.25,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        item.selectedCity ?? "",
                                        style: const TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                item.rentOrBuy ?? "",
                                                style: const TextStyle(
                                                    fontSize: 14),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                            child: GestureDetector(
                                                onTap: () {
                                                  _showCustomDialog(
                                                      context, item);
                                                },
                                                child: Container(
                                                  width:
                                                      MediaQuery.sizeOf(context)
                                                              .width *
                                                          0.1,
                                                  height:
                                                      MediaQuery.sizeOf(context)
                                                              .width *
                                                          0.1,
                                                  decoration: BoxDecoration(
                                                      color: kPrimaryColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  margin: EdgeInsets.only(
                                                      right: 20),
                                                  child: Icon(
                                                    Icons.remove,
                                                    color: kPrimaryLightColor,
                                                    size: 25,
                                                  ),
                                                ))),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          // flex: 1,
                                          child: (item.propType != "2")
                                              ? Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Container(
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        left: 2,
                                                                        top: 5),
                                                                child: Text(
                                                                  item.selectedBed
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      color:
                                                                          kPrimaryColor),
                                                                ),
                                                              ),
                                                              Container(
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            5),
                                                                child:
                                                                    ImageIcon(
                                                                  AssetImage(
                                                                      'assets/images/bed.png'),
                                                                  size: 25.0,
                                                                  color:
                                                                      kPrimaryColor,
                                                                ),
                                                              ),
                                                              Container(
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        left: 7,
                                                                        top: 5),
                                                                child: Text(
                                                                  item.selectedBath
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      color:
                                                                          kPrimaryColor),
                                                                ),
                                                              ),
                                                              Container(
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            2),
                                                                child: Icon(
                                                                  Icons.bathtub,
                                                                  color:
                                                                      kPrimaryColor,
                                                                ),
                                                              ),
                                                              Container(
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        left: 7,
                                                                        top: 5),
                                                                child: Text(
                                                                  item.selectedGarage
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      color:
                                                                          kPrimaryColor),
                                                                ),
                                                              ),
                                                              Container(
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        left: 2,
                                                                        top: 2),
                                                                child: Icon(
                                                                  Icons
                                                                      .directions_car,
                                                                  color:
                                                                      kPrimaryColor,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              : Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Text("Area : "),
                                                              Container(
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        left: 2,
                                                                        top: 5),
                                                                child: Text(
                                                                  item.selectedArea
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      color:
                                                                          kPrimaryColor),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        });
  }

  Future<void> _showCustomDialog(
      BuildContext context, PropertyModel property) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Property Action'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child:
                        Text('The property has been successfully sold/rented'),
                  ),
                  Container(
                      child:
                          // Consumer<DeleteProp>(builder: (context, data, child) {
                          GestureDetector(
                              onTap: () {
                                Provider.of<Services>(context, listen: false)
                                    .deleteProperty(property, true);
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                width: MediaQuery.sizeOf(context).width * 0.1,
                                height: MediaQuery.sizeOf(context).width * 0.1,
                                decoration: BoxDecoration(
                                    color: kPrimaryColor,
                                    borderRadius: BorderRadius.circular(20)),
                                margin: EdgeInsets.only(right: 20),
                                child: Icon(
                                  Icons.check,
                                  color: kPrimaryLightColor,
                                  size: 25,
                                ),
                              ))
                      // }),
                      ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text('Delete The Property'),
                  ),
                  Container(
                      child:
                          // Provider<DeleteProp>(
                          //   create: (context) {
                          //     return DeleteProp();
                          //   },
                          //   child:
                          //       Consumer<DeleteProp>(builder: (context, data, child) {
                          GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                                Provider.of<Services>(context, listen: false)
                                    .deleteProperty(property, false);
                              },
                              child: Container(
                                width: MediaQuery.sizeOf(context).width * 0.1,
                                height: MediaQuery.sizeOf(context).width * 0.1,
                                decoration: BoxDecoration(
                                    color: kPrimaryColor,
                                    borderRadius: BorderRadius.circular(20)),
                                margin: EdgeInsets.only(right: 20),
                                child: Icon(
                                  Icons.close,
                                  color: kPrimaryLightColor,
                                  size: 25,
                                ),
                              ))
                      //   }),
                      // ),
                      )
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
