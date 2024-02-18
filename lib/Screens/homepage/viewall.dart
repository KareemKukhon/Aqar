import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Login/components/login_form.dart';
import 'package:flutter_auth/Screens/homepage/description.dart';
import 'package:flutter_auth/data/ItemDescription.dart';
import 'package:flutter_auth/data/Property.dart';
import 'package:flutter_auth/data/SignUpData.dart';
import 'package:flutter_auth/data/addProptoSaved.dart';
import 'package:flutter_auth/data/recom_data.dart';
import 'package:flutter_auth/Screens/homepage/recom_listView.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/data/savedProperty.dart';
import 'package:flutter_auth/services/services.dart';
import 'package:provider/provider.dart';

class VerticalListView extends StatefulWidget {
  @override
  _VerticalListViewState createState() => _VerticalListViewState();
}

class _VerticalListViewState extends State<VerticalListView> {
  List<PropertyModel> items = [];

  @override
  void initState() {
    super.initState();
    List<Map<String, dynamic>> propertyList = ItemDescription();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Provider.of<Services>(context, listen: false)
            .getRecommendedProperty(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(); // Loading indicator while waiting
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List<PropertyModel> propertyList =
                Provider.of<Services>(context).recoPropertyList;
            items = propertyList;
            User? user = Provider.of<Services>(context).userRes;
            return Scaffold(
              appBar: AppBar(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(
                        20), // Adjust the radius to make it circular
                  ),
                ),
                backgroundColor: kPrimaryColor,
                iconTheme: IconThemeData(color: Colors.white),
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
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            item.selectedCity!,
                                            style: const TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "${item.selectedPrice}",
                                                style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(" JOD")
                                            ],
                                          ),
                                        ],
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
                                                item.rentOrBuy!,
                                                style: const TextStyle(
                                                    fontSize: 14),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                            child: GestureDetector(
                                                onTap: () {
                                                  SavedPropertyModel
                                                      savedPropertyModel =
                                                      SavedPropertyModel(
                                                          property:
                                                              propertyList[
                                                                  index],
                                                          user: user);
                                                  services.savedProperty(
                                                      savedPropertyModel);
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
                                                    Icons.bookmark,
                                                    color: kPrimaryLightColor,
                                                    size: 25,
                                                  ),
                                                )))
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
}
