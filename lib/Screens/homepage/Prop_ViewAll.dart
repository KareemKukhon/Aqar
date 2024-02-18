import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Login/components/login_form.dart';
import 'package:flutter_auth/Screens/homepage/description.dart';
import 'package:flutter_auth/data/Homepage_Prop.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/data/Property.dart';
import 'package:flutter_auth/data/SignUpData.dart';
import 'package:flutter_auth/data/savedProperty.dart';
import 'package:flutter_auth/services/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class VerticalListViewProp extends StatefulWidget {
  @override
  _VerticalListViewPropState createState() => _VerticalListViewPropState();
}

class _VerticalListViewPropState extends State<VerticalListViewProp> {
  List<HomePageProp> items = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future:
            Provider.of<Services>(context, listen: false).fetchDataFromServer(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(); // Loading indicator while waiting
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List<PropertyModel> propertyList =
                Provider.of<Services>(context).propertyList;
            User? user = Provider.of<Services>(context).userRes;
            items = List.generate(propertyList.length, (index) {
              int ind = propertyList.length - index - 1;
              print(propertyList[index].image.toString());
              return HomePageProp(
                id: propertyList[index].id,
                price: propertyList[ind].selectedPrice.toString(),
                imagePath: propertyList[ind].image,
                cityName: propertyList[ind].selectedCity!,
                status: propertyList[ind].rentOrBuy!,
                bedroom: propertyList[ind].selectedBed,
                location: propertyList[ind].selectedStreet!,
                bathroom: propertyList[ind].selectedBath,
                garage: propertyList[ind].selectedGarage,
              );
            });
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
                          int ind = propertyList.length - index - 1;
                          final property = propertyList[ind];
                          final item =
                              items[index]; // Get the item from the list

                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return ProductItemScreen(propertyList[ind]);
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
                                          item.imagePath != null
                                              ? "http://192.168.68.51:8083${item.imagePath!}"
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
                                            item.cityName ?? "",
                                            style: const TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "${item.price}",
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
                                                item.status ?? "",
                                                style: const TextStyle(
                                                    fontSize: 14),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            margin: EdgeInsets.only(right: 20),
                                            alignment: Alignment.topRight,
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
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  color: kPrimaryColor,
                                                ),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    SavedPropertyModel
                                                        savedPropertyModel =
                                                        SavedPropertyModel(
                                                            property: property,
                                                            user: user);
                                                    services.savedProperty(
                                                        savedPropertyModel);
                                                  },
                                                  child: const Icon(
                                                    Icons.bookmark,
                                                    color: kPrimaryLightColor,
                                                  ),
                                                )),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          // flex: 1,
                                          child: (property.propType != "2")
                                              ? Padding(
                                                  //افحص اذا ارض لازم نعرض مساحتها بدل عدد الغرف
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
                                                                  item.bedroom
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
                                                                  item.bathroom
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
                                                                  item.garage
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
                                                              Text("Area:"),
                                                              Container(
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        left: 2,
                                                                        top: 5),
                                                                child: Text(
                                                                  property
                                                                      .selectedArea
                                                                      .toString(), //اعرض المساحة للارض
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
