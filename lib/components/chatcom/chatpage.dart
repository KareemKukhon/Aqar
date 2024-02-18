// import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/components/chatcom/chatCard.dart';
import 'package:flutter_auth/services/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
// import 'package:shanti/Provider/AppProvider.dart';
// import 'package:shanti/UserInterface/Widgets/MessageCard.dart';

// import '../../models/ChatModel.dart';
// import '../../models/MessageModel.dart';

class MessagesScreen extends StatefulWidget {
  MessagesScreen({
    Key? key,
    // required /.chat,
  }) : super(key: key);
  // Chat chat;

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Services>(builder: (context, provider, x) {
      // provider.messages
          // .sort((a, b) => a.timestamp!.isAfter(b.timestamp!) ? 1 : 0);
      return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Row(
              children: [
                const BackButton(),
                // CircleAvatar(
                //   backgroundImage: NetworkImage(
                //       provider.serverUrl + widget.chat.otherUser!.url!),
                // ),
                 SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      " user1 ",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                )
              ],
            ),
            actions: [],
          ),
          body: Column(children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 20),
                  // child: ListView.builder(
                  //   itemCount: demeChatMessages.length,
                  //   itemBuilder: (context, index) =>
                  //       Message(message: demeChatMessages[index]),
                  // ),
                  child: Column(children: [
                    ...provider.messages!
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
                          children: [
                            Icon(
                              Icons.abc,
                              color: Colors.blue.withOpacity(0.64),
                            ),
                            SizedBox(width: 5),
                            Expanded(
                              child: TextField(
                                controller: provider.messageController,
                                decoration: InputDecoration(
                                  hintText: "Type message",
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                // widget.chat =
                                //     await provider.sendMessage(widget.chat);
                                setState(() {});
                              },
                              child: Icon(
                                Icons.send,
                                color: Colors.blue.withOpacity(0.64),
                              ),
                            ),
                            SizedBox(width: 5),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ]));
    });
  }
}


