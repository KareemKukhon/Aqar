import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Login/components/login_form.dart';
import 'package:flutter_auth/Screens/homepage/description.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/data/ItemDescription.dart';
import 'package:flutter_auth/data/SignUpData.dart';
import 'package:flutter_auth/data/addProptoSaved.dart';
import 'package:flutter_auth/data/Property.dart';
import 'package:flutter_auth/data/removeFromSaved.dart';
import 'package:flutter_auth/services/services.dart';
import 'package:provider/provider.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: savepage(),
//     );
//   }
// }

class savepage extends StatefulWidget {
  const savepage({Key? key}) : super(key: key);

  @override
  _savepageState createState() => _savepageState();
}

class _savepageState extends State<savepage> {
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
            Provider.of<Services>(context, listen: false).getSavedProperty(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(); // Loading indicator while waiting
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List<PropertyModel> items =
                Provider.of<Services>(context).savedPropertyList;
            User? user = Provider.of<Services>(context).userRes;
            return Scaffold(
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
                                    return ProductItemScreen(items[index]);
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
                                              ? "http://192.168.68.51:8083" +
                                                  item.image!
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
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  0.1,
                                          height:
                                              MediaQuery.sizeOf(context).width *
                                                  0.1,
                                          decoration: BoxDecoration(
                                              color: kPrimaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          margin: EdgeInsets.only(right: 20),
                                          child: IconButton(
                                            icon: Icon(
                                              Icons.bookmark_remove_sharp,
                                              size: 25,
                                            ),
                                            color: kPrimaryLightColor,
                                            onPressed: () {
                                              setState(() {
                                                services.deleteSavedProperty(
                                                    item, user!.email!);
                                              });
                                            },
                                          ),
                                        )
                                        // );
                                        // }),
                                        // ),
                                        // )
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
                                                                margin:
                                                                    EdgeInsets
                                                                        .only(
                                                                  left: 2,
                                                                ),
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
}
