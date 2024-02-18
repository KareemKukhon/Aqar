import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/chat/chat.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/data/SignUpData.dart';
import 'package:flutter_auth/data/usersInTheChat.dart';
import 'package:flutter_auth/services/services.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;





class chatspage extends StatefulWidget {
  const chatspage({Key? key}) : super(key: key);

  @override
  __contactpagState createState() => __contactpagState();
}

class __contactpagState extends State<chatspage> {
  List<ChatUser> _elements = [];

  @override
  void initState() {
    super.initState();
    _elements = users();
  }

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<Services>(context).userRes;
    IO.Socket socket = Provider.of<Services>(context).socket;
    // log(user!.contacts.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chats',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: kPrimaryColor,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: ListView.builder(
        itemCount: user!.contacts?.length,
        itemBuilder: (BuildContext context, int index) {
          return Consumer<Services>(builder: (context, services, child) {
            return GestureDetector(
              onTap: () async {
                services.findUserByEmail(user.contacts![index].email ?? "");
                await Future.delayed(Duration(milliseconds: 200));
                User? contact = services.contact;
                // log(contact.toString());

                // socket.emit('userDetails', {user, contact});
                // await Future.delayed(Duration(milliseconds: 300));

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return Basic(owner: contact);
                    },
                  ),
                );
                // print('Card clicked: ${user!.contacts?[index].name}');
              },
              child: Card(
                color: kPrimaryLightColor,
                margin: const EdgeInsets.all(8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Container(
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  ClipOval(
                                    child: Material(
                                      color: Colors.transparent,
                                      child: Ink.image(
                                        image:
                                            AssetImage(_elements[index].image!),
                                        fit: BoxFit.cover,
                                        width: 50,
                                        height: 50,
                                        child: InkWell(),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    user!.contacts?[index].name ?? "user1",
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                              // Add any additional styling or widgets here
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            margin: EdgeInsets.only(right: 10, top: 15),
                            child: Icon(Icons.arrow_forward),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          });
        },
      ),
    );
  }
}
