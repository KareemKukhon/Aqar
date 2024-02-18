import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/chat/chatbot.dart';
import 'package:flutter_auth/Screens/homepage/Prop_ViewAll.dart';
import 'package:flutter_auth/Screens/homepage/description.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/data/Homepage_Prop.dart';
import 'package:flutter_auth/data/Property.dart';
import 'package:flutter_auth/data/SignUpData.dart';
import 'package:flutter_auth/services/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class HomeVerticalListView extends StatefulWidget {
  @override
  _HomeVerticalListViewState createState() => _HomeVerticalListViewState();
}

class _HomeVerticalListViewState extends State<HomeVerticalListView> {
  List<PropertyModel> items = [];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:
          Provider.of<Services>(context, listen: false).fetchDataFromServer(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child:
                  CircularProgressIndicator()); // Loading indicator while waiting
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          List<PropertyModel> propertyList =
              Provider.of<Services>(context).propertyList;
          // propertyList.sort((a, b) => propertyList.indexOf(b).compareTo(propertyList.indexOf(a)));
          items = propertyList.reversed.toList();
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return chatbot();
                    },
                  ),
                );
              },
              child: Icon(Icons.contact_support_outlined),
            ),
            body: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "  You May Love".tr,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return VerticalListViewProp();
                            },
                          ),
                        );
                      },
                      child: Text(
                        "ViewAll".tr,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black, // Set your desired color
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: items.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final item = items[index]; // Get the item from the list

                      return Card(
                        color: Colors.white,
                        margin: const EdgeInsets.all(8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Container(
                          width: double.infinity,
                          height: (MediaQuery.of(context).size.width > 450)
                              ? MediaQuery.of(context).size.height * 0.3
                              : MediaQuery.of(context).size.height * 0.2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Provider.of<Services>(context, listen: false)
                                      .updateRecommendedProperty(propertyList[
                                              propertyList.length - index - 1]
                                          .selectedCity!);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return ProductItemScreen(propertyList[
                                            propertyList.length - index - 1]);
                                      },
                                    ),
                                  );
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(
                                    item.image != null
                                        ? "http://192.168.68.51:8083${item.image!}"
                                        : "https://feb.kuleuven.be/drc/LEER/visiting-scholars-1/image-not-available.jpg/image",
                                    width: (MediaQuery.of(context).size.width >
                                            450)
                                        ? MediaQuery.of(context).size.width *
                                            0.4
                                        : MediaQuery.of(context).size.width *
                                            0.4,
                                    height:
                                        (MediaQuery.of(context).size.height >=
                                                600)
                                            ? MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.6
                                            : MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.6,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Expanded(
                                // flex: 1,
                                child: (item.propType != "2")
                                    ? Padding(
                                        //افحص اذا ارض لازم نعرض مساحتها بدل عدد الغرف
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  item.selectedCity ?? "",
                                                  style: const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(height: 5),
                                                Text(
                                                  item.rentOrBuy ?? "",
                                                  style: const TextStyle(
                                                      fontSize: 14),
                                                ),
                                                SizedBox(height: 5),
                                                Row(
                                                  children: [
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          left: 2, top: 5),
                                                      child: Text(
                                                        item.selectedBed
                                                            .toString(),
                                                        style: TextStyle(
                                                            color:
                                                                kPrimaryColor),
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          left: 5),
                                                      child: ImageIcon(
                                                        AssetImage(
                                                            'assets/images/bed.png'),
                                                        size: 25.0,
                                                        color: kPrimaryColor,
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          left: 7, top: 5),
                                                      child: Text(
                                                        item.selectedBath
                                                            .toString(),
                                                        style: TextStyle(
                                                            color:
                                                                kPrimaryColor),
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          left: 2),
                                                      child: Icon(
                                                        Icons.bathtub,
                                                        color: kPrimaryColor,
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          left: 7, top: 5),
                                                      child: Text(
                                                        item.selectedGarage
                                                            .toString(),
                                                        style: TextStyle(
                                                            color:
                                                                kPrimaryColor),
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          left: 2, top: 2),
                                                      child: Icon(
                                                        Icons.directions_car,
                                                        color: kPrimaryColor,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 5),
                                                Text(
                                                  item.selectedPrice
                                                          .toString() +
                                                      " JOD",
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 14),
                                                ),
                                                item.rentOrBuy == "Rent"
                                                    ? Text(
                                                        " per " +
                                                            item.selectedTime
                                                                .toString(),
                                                        style: const TextStyle(
                                                            fontSize: 12),
                                                      )
                                                    : Text("")
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  item.selectedCity ?? "",
                                                  style: const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(height: 5),
                                                Text(
                                                  item.rentOrBuy ?? "",
                                                  style: const TextStyle(
                                                      fontSize: 14),
                                                ),
                                                SizedBox(height: 5),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "Area:",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          left: 2),
                                                      child: Text(
                                                        item.selectedArea
                                                                .toString() +
                                                            " m2", //اعرض المساحة للارض
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                kPrimaryColor),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 5),
                                                Row(
                                                  children: [
                                                    Text(
                                                      item.selectedPrice
                                                              .toString() +
                                                          " JOD",
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 14),
                                                    ),
                                                    SizedBox(height: 5),
                                                    item.rentOrBuy == "Rent"
                                                        ? Text(
                                                            " per " +
                                                                item.selectedTime
                                                                    .toString(),
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        12),
                                                          )
                                                        : Text("")
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                              ),
                              Expanded(
                                flex: 0,
                                child: Container(
                                    //   child: Provider<addToSaved>(
                                    //     create: (context) {
                                    //       return addToSaved();
                                    //     },
                                    //     child: Consumer<addToSaved>(
                                    //         builder: (context, data, child) {
                                    //       return GestureDetector(
                                    //           onTap: () {
                                    //             data.createJsonData(
                                    //                 item.id,
                                    //                 item.owner,
                                    //                 item.imagePath,
                                    //                 item.type,
                                    //                 item.status,
                                    //                 item.bedroom,
                                    //                 item.bathroom,
                                    //                 item.garage,
                                    //                 item.description,
                                    //                 item.city,
                                    //                 item.location,
                                    //                 item.homepic0,
                                    //                 item.homepic1,
                                    //                 item.homepic2,
                                    //                 item.homepic3);
                                    //           },
                                    //           child: Container(
                                    //             width: MediaQuery.sizeOf(context)
                                    //                     .width *
                                    //                 0.1,
                                    //             height: MediaQuery.sizeOf(context)
                                    //                     .width *
                                    //                 0.1,
                                    //             decoration: BoxDecoration(
                                    //                 color: kPrimaryColor,
                                    //                 borderRadius:
                                    //                     BorderRadius.circular(20)),
                                    //             margin: EdgeInsets.only(right: 20),
                                    //             child: Icon(
                                    //               Icons.bookmark,
                                    //               color: kPrimaryLightColor,
                                    //               size: 25,
                                    //             ),
                                    //           ));
                                    //     }),
                                    //   ),
                                    // )
                                    ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
