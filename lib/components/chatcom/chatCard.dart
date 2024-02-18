import 'dart:developer';

import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/homepage/chatbotProp.dart';
import 'package:flutter_auth/Screens/homepage/description.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/data/Property.dart';
import 'package:flutter_auth/data/messageModel.dart';
import 'package:flutter_auth/services/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
// import 'package:shanti/Provider/AppProvider.dart';
// import 'package:shanti/models/MessageModel.dart';

class MessageCard extends StatelessWidget {
  MessageCard({
    Key? key,
    this.property,
    required this.message,
    // required this.url,
  }) : super(key: key);
  final ChatModel message;
  List<PropertyModel>? property = [];
  List<PropertyModel> items = [];
  // final String url;

  @override
  Widget build(BuildContext context) {
    bool isPropEmpty = message.isPropEmpty ?? true;
    List<PropertyModel> propertyList = property ?? [];
    // propertyList.sort((a, b) => propertyList.indexOf(b).compareTo(propertyList.indexOf(a)));
    items = propertyList.reversed.toList();
    // log(property.toString());
    return Consumer<Services>(builder: (context, provider, x) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Container(
              child: Row(
                mainAxisAlignment: message.isSender
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.start,
                children: [
                  if (!message.isSender) ...[
                    CircleAvatar(
                      radius: 12,
                      backgroundImage: AssetImage("assets/images/home1.jpg"),
                    ),
                    const SizedBox(width: 10),
                  ],
                  Flexible(
                    child: Container(
                      // color: MediaQuery.of(context).platformBrightness == Brightness.dark
                      //     ? Colors.white
                      //     : Colors.black,
                      padding: EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color:
                            Colors.blue.withOpacity(message.isSender ? 1 : 0.1),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        message.message!,
                        style: TextStyle(
                          color: message.isSender
                              ? Colors.white
                              : Theme.of(context).textTheme.bodyLarge!.color,
                        ),
                      ),
                    ),
                  ),
                  if (message.isSender) ...[
                    const SizedBox(width: 10),
                    CircleAvatar(
                      radius: 12,
                      backgroundImage: AssetImage("assets/images/home1.jpg"),
                    ),
                  ],
                ],
              ),
            ),
          ),
          if (property != null &&
              !message.isSender &&
              !isPropEmpty &&
              message.location != null) ...[
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return ChatbotProp(propertyList: property??[]);
                    },
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    if (!message.isSender) ...[
                      CircleAvatar(
                        radius: 12,
                        backgroundImage: AssetImage("assets/images/home1.jpg"),
                      ),
                      const SizedBox(width: 10),
                    ],
                    Flexible(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(
                          "click here",
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodyLarge!.color,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
          if (property != null &&
              !message.isSender &&
              isPropEmpty &&
              message.location != null) ...[
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if (!message.isSender) ...[
                    CircleAvatar(
                      radius: 12,
                      backgroundImage: AssetImage("assets/images/home1.jpg"),
                    ),
                    const SizedBox(width: 10),
                  ],
                  Flexible(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        "unfortunately, the property not found.",
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyLarge!.color,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]
        ],
      );
    });
  }
}
