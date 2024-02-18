import 'dart:developer';

import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter_auth/components/chatcom/chatCard.dart';
import 'package:flutter_auth/data/SignUpData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/data/contactsModel.dart';
import 'package:flutter_auth/data/messageModel.dart';
import 'package:flutter_auth/services/services.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class chatbot extends StatefulWidget {
  // final User? owner;

  chatbot({Key? key}) : super(key: key);

  @override
  State<chatbot> createState() => chatbotState();
}

class chatbotState extends State<chatbot> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log("chat.dart");
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: Text(
            "Support",
            style: TextStyle(color: Colors.white),
          ),
          iconTheme: IconThemeData(color: Colors.white),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Consumer<Services>(builder: (context, provider, x) {
          return Column(children: [
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  // child: ListView.builder(
                  //   itemCount: demeChatMessages.length,
                  //   itemBuilder: (context, index) =>
                  //       Message(message: demeChatMessages[index]),
                  // ),
                  child: Column(children: [
                    ...provider.botMessages
                        .map((e) => MessageCard(
                              message: e,
                              property: provider.botPropertyList,
                              //  url: widget.chat.otherUser!.url!
                            ))
                        .toList(),
                  ]),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 4),
                    blurRadius: 32,
                    color: Color(0xFF087949).withOpacity(0.08),
                  ),
                ],
              ),
              child: SafeArea(
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 15,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: TextField(
                                controller: provider.messageController,
                                decoration: InputDecoration(
                                  hintText: "Type message",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        20.0), // Adjust the radius as needed
                                    borderSide: BorderSide(
                                      color: Colors
                                          .transparent, // Add your desired border color here
                                      width: 1.0, // Customize the border width
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                // widget.chat =
                                //     await provider.sendMessage(widget.chat);
                                setState(() {
                                  ChatModel c = ChatModel(
                                      // sender: provider.userRes!,
                                      // recipient: widget.owner!,
                                      message: provider.messageController.text,
                                      isSender: true,
                                      timestamp: DateTime.now());
                                  provider.sendBotMessage(c.message);
                                  provider.addBotMessage(c);
                                  // provider.addContacts(ContactsModel(
                                  //     email: widget.owner?.email,
                                  //     name: widget.owner?.firstName));
                                  provider.messageController.clear();
                                });
                              },
                              child: Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: Icon(
                                  Icons.send,
                                  color: kPrimaryColor,
                                ),
                              ),
                            ),
                            // SizedBox(width: 5),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ]);
        }));
  }

  @override
  void dispose() {
    super.dispose();

    // Cancel your timers or animations here
  }
}
