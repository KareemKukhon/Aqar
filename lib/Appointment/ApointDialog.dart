import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/data/Appointments.dart';
import 'package:flutter_auth/data/SignUpData.dart';
import 'package:flutter_auth/services/services.dart';

class AppointmentDialog extends StatelessWidget {
  final String name;
  final String date;
  final String time;
  DateTime? DT;
  User? sender;
  User? reciever;

  AppointmentDialog({
    Key? key,
    required this.name,
    required this.date,
    required this.time,
    this.DT,
    required this.sender,
    required this.reciever,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: kPrimaryLightColor,
      title: Text('$name would like to book an appointment'),
      content: Text('on $date at $time'),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(true);
            AppointmentModel appointmentModel = new AppointmentModel(
              user1: sender,
              user2: reciever,
                start: DT, end: DT?.add(const Duration(minutes: 30)));
            Provider.of<Services>(context, listen: false)
                .createAppointment(appointmentModel);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: kPrimaryLightColor,
          ),
          child: const Text(
            'Accept',
            style: TextStyle(color: kPrimaryColor),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: kPrimaryLightColor,
          ),
          child: const Text(
            'Decline',
            style: TextStyle(color: kPrimaryColor),
          ),
        ),
      ],
    );
  }
}
