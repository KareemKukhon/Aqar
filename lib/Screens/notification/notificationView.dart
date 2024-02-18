import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_auth/Appointment/ApointDialog.dart';
import 'package:flutter_auth/Screens/Welcome/welcome_screen.dart';
import 'package:flutter_auth/Screens/chat/chat.dart';
import 'package:flutter_auth/Screens/chatspage/chatspage.dart';
import 'package:flutter_auth/Screens/homepage/description.dart';
import 'package:flutter_auth/Screens/navbar/bottom_bar.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/data/NotificationData.dart';
import 'package:flutter_auth/data/SignUpData.dart';
import 'package:flutter_auth/services/services.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({Key? key}) : super(key: key);

  @override
  _NotificationViewState createState() => _NotificationViewState();
}

buttonArrow(BuildContext context) {
  return Row(
    children: [
      Container(
          child: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      )),
      Text("Notifications", style: TextStyle(fontSize: 30)),
    ],
  );
}

class _NotificationViewState extends State<NotificationView> {
  List<Notification_Description> notis = [];

  @override
  void initState() {
    super.initState();
  }

  notif_cards(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
        itemCount: notis.length,
        itemBuilder: (context, index) {
          return Container(
            height: 100,
            child: NotificationCard(
              senderName: notis[index].sender,
              message: notis[index].body.toString(),
              title: notis[index].title,
              date:
                  '${notis[index].date?.day}/${notis[index].date?.month}/${notis[index].date?.year}',
              time: '${notis[index].date?.hour}:${notis[index].date?.minute}',
              DT: notis[index].date,
              recieverName: notis[index].recipient,
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<Services>(context).userRes;
    return FutureBuilder(
        future: Provider.of<Services>(context, listen: false)
            .getNotification(user!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child:
                    CircularProgressIndicator()); // Loading indicator while waiting
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            notis = Provider.of<Services>(context).notifications;
            return Scaffold(
              body: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/background.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: ListView(
                      children: [
                        buttonArrow(context),
                        const SizedBox(height: 24),
                        notif_cards(context)
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        });
  }
}

class NotificationCard extends StatelessWidget {
  final User? senderName;
  User? recieverName;
  final String message;
  String? title;
  String? date;
  String? time;
  DateTime? DT;

  NotificationCard({
    Key? key,
    required this.senderName,
    this.recieverName,
    required this.message,
    this.title,
    this.date,
    this.time,
    this.DT,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          print("Card Tapped");
          if (title == "new Appointment")
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return AppointmentDialog(
                    name: '${senderName?.firstName} ${senderName?.lastName}',
                    date: date ?? "",
                    time: time.toString(),
                    DT: DT,
                    sender: senderName,
                    reciever: recieverName,
                  );
                },
              ),
            );
          else
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return Basic(owner: senderName);
                },
              ),
            );
        },
        child: Card(
            child: Container(
          color:
              Color(0xFFc781d0).withOpacity(0.1).withAlpha((0.1 * 255).toInt()),
          child: Row(
            children: [
              SenderImage(
                image: senderName!.image,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    MessageText(
                      text: senderName!.firstName.toString(),
                      fontWeight: FontWeight.bold,
                    ),
                    MessageText(text: message),
                  ],
                ),
              ),
            ],
          ),
        )));
  }
}

class SenderImage extends StatelessWidget {
  String? image;
  SenderImage({
    Key? key,
    this.image,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 70,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: image != null
              ? DecorationImage(
                  image: NetworkImage("http://192.168.68.51:8083${image}"),
                  fit: BoxFit.cover,
                )
              : DecorationImage(
                  image: AssetImage("assets/images/userAvatar.png"),
                  fit: BoxFit.cover,
                )),
    );
  }
}

class MessageText extends StatelessWidget {
  final String text;
  final FontWeight fontWeight;

  const MessageText({
    Key? key,
    required this.text,
    this.fontWeight = FontWeight.normal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double textSize = 16;
    return Container(
      margin: EdgeInsets.only(right: 50, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Center(
          Text(
            text,
            style: TextStyle(
              fontSize: textSize,
              color: Colors.black,
              fontWeight: fontWeight,
            ),
          ),
          // ),
        ],
      ),
    );
  }
}
