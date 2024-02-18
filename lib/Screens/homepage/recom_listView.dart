import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'package:flutter_auth/Screens/homepage/description.dart';
import 'package:flutter_auth/Screens/homepage/viewall.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/data/ItemDescription.dart';
import 'package:flutter_auth/data/Property.dart';
import 'package:flutter_auth/data/recom_data.dart';
import 'package:flutter_auth/services/services.dart';

class HorizontalListView extends StatefulWidget {
  @override
  _HorizontalListViewState createState() => _HorizontalListViewState();
}

class _HorizontalListViewState extends State<HorizontalListView> {
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
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Recommendedforyou".tr,
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
                              return VerticalListView();
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
                Container(
                  height: (MediaQuery.of(context).size.width > 450)
                      ? MediaQuery.of(context).size.height * 0.5
                      : MediaQuery.of(context).size.height * 0.3,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return ItemCard(
                        item: items[index],
                      );
                    },
                  ),
                ),
              ],
            );
          }
        });
  }
}

class ItemCard extends StatelessWidget {
  final PropertyModel item;

  ItemCard({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        color: kPrimaryLightColor,
        margin: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
          ),
          width: 200,
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  item.image != null
                      ? "http://192.168.68.51:8083" + item.image!
                      : "https://feb.kuleuven.be/drc/LEER/visiting-scholars-1/image-not-available.jpg/image",
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    margin: EdgeInsets.only(
                        top: (MediaQuery.of(context).size.width > 450)
                            ? MediaQuery.of(context).size.height * 0.3
                            : MediaQuery.of(context).size.height * 0.17),
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          //color: kPrimaryLightColor,
                          child: Text(
                            item.selectedCity!,
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white, // text color
                            ),
                          ),
                        ),
                        Container(
                          //color: kPrimaryLightColor,
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              item.rentOrBuy!,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white, // text color
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
