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

class Basic extends StatefulWidget {
  final User? owner;

  Basic({required this.owner});

  @override
  State<Basic> createState() => _BasicState();
}

class _BasicState extends State<Basic>
    with AutomaticKeepAliveClientMixin<Basic> {
  bool flag = false;
  @override
  void initState() {
    super.initState();

    log("=========================================");
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    if (!flag) {
      User? user = Provider.of<Services>(context).userRes;
      IO.Socket socket = Provider.of<Services>(context).socket;
      socket.emit('userDetails', {user, widget.owner});
      flag = true;
      Provider.of<Services>(context, listen: false).toggleInChat(widget.owner);

      return FutureBuilder(
          future: Future.delayed(Duration(milliseconds: 300)),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child:
                      CircularProgressIndicator()); // Loading indicator while waiting
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              log("chat.dart");
              final ScrollController _scrollController =
                  Provider.of<Services>(context).scrollController;
              WidgetsBinding.instance!.addPostFrameCallback((_) {
                log("!!!!!!!!!!!!!!!!!");
                if (mounted) {
                  log("======================");
                  _scrollController.animateTo(
                    _scrollController.position.maxScrollExtent,
                    duration: Duration(milliseconds: 200),
                    curve: Curves.easeOut,
                  );
                }
              });
              return Scaffold(
                  appBar: AppBar(
                    backgroundColor: kPrimaryColor,
                    title: Text(
                      "${widget.owner?.firstName}",
                      style: TextStyle(color: Colors.white),
                    ),
                    iconTheme: IconThemeData(color: Colors.white),
                    leading: IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        Provider.of<Services>(context, listen: false)
                            .clearBuffer();
                        Provider.of<Services>(context, listen: false)
                            .toggleInChat(null);
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
                            child: Column(children: [
                              ...provider.messages
                                  .map((e) => MessageCard(
                                        message: e,
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Expanded(
                                        child: TextField(
                                          controller:
                                              provider.messageController,
                                          decoration: InputDecoration(
                                            hintText: "Type message",
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(
                                                  20.0), // Adjust the radius as needed
                                              borderSide: BorderSide(
                                                color: Colors
                                                    .transparent, // Add your desired border color here
                                                width:
                                                    1.0, // Customize the border width
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          ChatModel c = ChatModel(
                                              sender: provider.userRes!,
                                              recipient: widget.owner!,
                                              message: provider
                                                  .messageController.text,
                                              isSender: true,
                                              timestamp: DateTime.now());
                                          provider.sendMessage(c);
                                          provider.addMessage(c);
                                          provider.addContacts(ContactsModel(
                                              email: widget.owner?.email,
                                              name: widget.owner?.firstName));
                                          provider.messageController.clear();
                                          provider.emitMessage();
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
          });
    } else {
      log("chat.dart");
      final ScrollController _scrollController =
          Provider.of<Services>(context).scrollController;
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        log("!!!!!!!!!!!!!!!!!");
        if (mounted) {
          log("======================");
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 200),
            curve: Curves.easeOut,
          );
        }
      });
      return Scaffold(
          appBar: AppBar(
            backgroundColor: kPrimaryColor,
            title: Text(
              "${widget.owner?.firstName}",
              style: TextStyle(color: Colors.white),
            ),
            iconTheme: IconThemeData(color: Colors.white),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                flag = false;
                Provider.of<Services>(context, listen: false).clearBuffer();
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
                      ...provider.messages
                          .map((e) => MessageCard(
                                message: e,
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
                                        width:
                                            1.0, // Customize the border width
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  ChatModel c = ChatModel(
                                      sender: provider.userRes!,
                                      recipient: widget.owner!,
                                      message: provider.messageController.text,
                                      isSender: true,
                                      timestamp: DateTime.now());
                                  provider.sendMessage(c);
                                  provider.addMessage(c);
                                  provider.addContacts(ContactsModel(
                                      email: widget.owner?.email,
                                      name: widget.owner?.firstName));
                                  provider.messageController.clear();
                                  provider.emitMessage();
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
  }

  @override
  void dispose() {
    super.dispose();

    // Cancel your timers or animations here
  }
}
