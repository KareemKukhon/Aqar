import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/BookTour/bookTour.dart';
import 'package:flutter_auth/Screens/Comments/comments.dart';
import 'package:flutter_auth/Screens/Login/components/login_form.dart';
import 'package:flutter_auth/Screens/chat/chat.dart';
import 'package:flutter_auth/Screens/homepage/googleMap.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/data/Property.dart';
import 'package:flutter_auth/data/SignUpData.dart';
import 'package:flutter_auth/data/savedProperty.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'package:flutter_auth/services/services.dart';
import 'package:provider/provider.dart';

class ProductItemScreen extends StatefulWidget {
  final PropertyModel property;

  const ProductItemScreen(
    this.property, {
    Key? key,
  }) : super(key: key);

  @override
  State<ProductItemScreen> createState() => _ProductItemScreenState();
}

class _ProductItemScreenState extends State<ProductItemScreen> {
  late PropertyModel items;
  int numOfStars = 5;
  @override
  void initState() {
    super.initState();
    // You should replace this with actual data loading
  }

  @override
  Widget build(BuildContext context) {
    List<PropertyModel> propertyList = Provider.of<Services>(context)
        .propertyList; // Replace with your data source

    items = widget.property;
    // log("id: " + items.id.toString());
    // print(items);
    return SafeArea(
        child: Scaffold(
      backgroundColor: kPrimaryLightColor,
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: MediaQuery.sizeOf(context).height * 0.399,
            //height: 400,
            child: Image.network(
              items.image != null
                  ? "http://192.168.68.51:8083" + items.image!
                  : "https://feb.kuleuven.be/drc/LEER/visiting-scholars-1/image-not-available.jpg/image",
              fit: BoxFit.cover,
            ),
          ),
          buttonArrow(context),
          scroll(context),
        ],
      ),
    ));
  }

  buttonArrow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          clipBehavior: Clip.hardEdge,
          height: 40,
          width: 40,
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            // Remove the color property to make the background transparent
            // borderRadius: BorderRadius.circular(30),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
              ),
              child: const Icon(
                Icons.arrow_back,
                size: 25,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  scroll(BuildContext context) {
    User? user = Provider.of<Services>(context).userRes;

    IO.Socket socket = Provider.of<Services>(context).socket;
    // Provider.of<Services>(context, listen: false).clearBuffer();

    return DraggableScrollableSheet(
        initialChildSize: 0.609,
        maxChildSize: 1.0,
        minChildSize: 0.609,
        builder: (context, scrollController) {
          return Container(
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(
              color: kPrimaryLightColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            ),
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 5,
                          width: 35,
                          color: kPrimaryColor,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 10, bottom: 3),
                    child: Row(children: [
                      Expanded(
                        child: Text(
                          items.selectedCity ?? "",
                          style: TextStyle(fontSize: 40, color: Colors.black),
                        ),
                      ),
                      Text(
                        (items.selectedPrice ?? "0").toString() + " JOD",
                        style: TextStyle(fontSize: 17),
                      )
                    ]),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 10, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                                items.propType == "0"
                                    ? "Home for "
                                    : items.propType == "1"
                                        ? "Apartment for "
                                        : items.propType == "2"
                                            ? "Land for "
                                            : "Chalet for ",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black.withOpacity(0.5))),
                            Text(items.rentOrBuy ?? "",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black.withOpacity(0.5))),
                          ],
                        ),
                        Text(
                          "ِArea: " + items.selectedArea.toString() + "m2" ??
                              "",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black.withOpacity(0.5),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 10, bottom: 25),
                      child: items.propType != "2"
                          ? Row(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(left: 8),
                                        child: ImageIcon(
                                          AssetImage('assets/images/bed.png'),
                                          size: 30.0,
                                          color: kPrimaryColor,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 5),
                                        child: Text(
                                          " " +
                                              items.selectedBed.toString() +
                                              " Bedrooms",
                                          style:
                                              TextStyle(color: kPrimaryColor),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(left: 8),
                                        child: Icon(
                                          Icons.bathtub,
                                          color: kPrimaryColor,
                                        ),
                                      ),
                                      Text(
                                        " " +
                                            items.selectedBath.toString() +
                                            " Bathrooms",
                                        style: TextStyle(color: kPrimaryColor),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(left: 8),
                                        child: Icon(
                                          Icons.garage,
                                          color: kPrimaryColor,
                                        ),
                                      ),
                                      Text(
                                        " " +
                                            items.selectedGarage.toString() +
                                            " Garages",
                                        style: TextStyle(color: kPrimaryColor),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          : Container()),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 10,
                    ),
                    child: Text(
                      "Description",
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: Container(
                      //height: MediaQuery.sizeOf(context).height * 0.25,
                      width: MediaQuery.sizeOf(context).width,
                      //color: Colors.pink,
                      child: ExpandableText(
                        items.selectedDescription ?? "",
                        expandText: 'Read more',
                        collapseText: 'Read less',
                        maxLines: 4, // Show only 3 lines when not expanded
                        linkColor: kPrimaryColor, // Customize the link color
                        //style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10, top: 10),
                    child: Text(
                      "Location",
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                  Container(
                    //height: 200,
                    //width: 400,
                    padding: EdgeInsets.only(
                      left: 0,
                    ),
                    //child: MapScreen(userLocation: "AL ersal street , Ramallah , Palestine",propertyLocation: "Asira Ash Shamaliya, Nablus , Palestine")
                    child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return MapScreen(
                                    propertyLocation: LatLng(
                                        items.latitude ?? 33,
                                        items.longitude ?? 33));
                              },
                            ),
                          );
                        },
                        child: Text(
                          "See Your Location and the proparity Location",
                          style: TextStyle(color: Colors.black),
                        )),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10, top: 10),
                    child: Text(
                      "Comments",
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                  Container(
                    //height: 200,
                    //width: 400,
                    padding: EdgeInsets.only(
                      left: 0,
                    ),
                    child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return Comments(items.id);
                              },
                            ),
                          );
                        },
                        child: Text(
                          "Add a comment or see other people's comments",
                          style: TextStyle(color: Colors.black),
                        )),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10, top: 10),
                    child: Text(
                      "Gallary",
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                      child: Container(
                        height: 100, // Set the desired height here
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: items.imageFileList!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              margin: EdgeInsets.only(left: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                              ),
                              height: 100,
                              width: 100,
                              child: GestureDetector(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                      16.0), // Adjust the radius as needed
                                  child: Image.network(
                                    items.imageFileList![index] == []
                                        ? "https://feb.kuleuven.be/drc/LEER/visiting-scholars-1/image-not-available.jpg/image"
                                        : "http://192.168.68.51:8083" +
                                            items.imageFileList![index],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                onTap: () {
                                  final imageProvider = NetworkImage(items
                                              .imageFileList![index] ==
                                          []
                                      ? "https://feb.kuleuven.be/drc/LEER/visiting-scholars-1/image-not-available.jpg/image"
                                      : "http://192.168.68.51:8083" +
                                          items.imageFileList![index]);
                                  // Image.network().image;
                                  showImageViewer(context, imageProvider,
                                      onViewerDismissed: () {
                                    log("dismissed");
                                  });

                                  // print("hi");
                                },
                              ),
                            );
                          },
                        ),
                      )),
                  Padding(
                      padding: EdgeInsets.only(top: 20, left: 10, right: 10),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Center(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Theme.of(context).primaryColor,
                                  padding: EdgeInsets.all(16.0),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return Book(
                                          sender: user,
                                          reciepnt: items.owner!,
                                        );
                                      },
                                    ),
                                  );
                                },
                                child: Text(
                                  "Book a tour with the owner",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: kPrimaryLightColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: Center(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Theme.of(context).primaryColor,
                                  padding: EdgeInsets.all(16.0),
                                ),
                                onPressed: () {
                                  // Handle the button press action here
                                  SavedPropertyModel savedPropertyModel =
                                      SavedPropertyModel(
                                          property: items, user: user);
                                  services.savedProperty(savedPropertyModel);
                                },
                                child: Icon(
                                  Icons.bookmark,
                                  color: kPrimaryLightColor,
                                  size: 25,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: Center(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Theme.of(context).primaryColor,
                                  padding: EdgeInsets.all(16.0),
                                ),
                                onPressed: () async {
                                  // socket
                                  //     .emit('userDetails', {user, items.owner});
                                  // await Future.delayed(
                                  //     Duration(milliseconds: 200));
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return Basic(owner: items.owner);
                                      },
                                    ),
                                  );
                                },
                                child: Icon(
                                  Icons.chat,
                                  color: kPrimaryLightColor,
                                  size: 25,
                                ),
                              ),
                            ),
                          )
                        ],
                      )),
                  SizedBox(
                    height: 50,
                  )
                ],
              ),
            ),
          );
        });
  }
//    @override
// void dispose() {
//   super.dispose();
//   // Cancel your timers or animations here
// }
}
