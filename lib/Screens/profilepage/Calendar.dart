import 'package:flutter/material.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/data/Appointments.dart';
import 'package:flutter_auth/data/CalendarData.dart';
import 'package:flutter_auth/services/services.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';



class Calendar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointment Schedule'),
      ),
      body: MyCalendar(),
    );
  }
}

class MyCalendar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Provider.of<Services>(context, listen: false).getAppointment(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child:
                    CircularProgressIndicator()); // Loading indicator while waiting
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List<AppointmentModel> Appointments =
                Provider.of<Services>(context).myAppointments;
            return SfCalendar(
              view: CalendarView.week,
              dataSource: _getCalendarDataSource(Appointments),
              appointmentBuilder: _customAppointmentBuilder,
              todayHighlightColor: kPrimaryColor,
              timeSlotViewSettings: const TimeSlotViewSettings(
                  timeIntervalHeight: 100, endHour: 18, startHour: 12),
            );
          }
        });
  }

  List<Appointment> _getAppointments() {
    List<String> appointmentTimes = CalendarData();
    return appointmentTimes.map((time) {
      List<String> timeRange = time.split(' - ');
      String userName = timeRange[0];
      DateTime startTime = DateTime.parse(timeRange[1]);
      DateTime endTime = DateTime.parse(timeRange[2]);

      return Appointment(
        startTime: startTime,
        endTime: endTime,
        subject: userName,
        color: kPrimaryColor,
      );
    }).toList();
  }

  _DataSource _getCalendarDataSource(List<AppointmentModel> Appointments) {
    List<Appointment> appointments = Appointments.map((e) {
      return Appointment(
          startTime: e.start!, endTime: e.end!, color: kPrimaryColor);
    }).toList();
    return _DataSource(appointments);
  }

  Widget _customAppointmentBuilder(
      BuildContext context, CalendarAppointmentDetails details) {
    final Appointment appointment = details.appointments.first;
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.sizeOf(context).width * 0.5,
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: appointment.color,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              appointment.subject, // Displaying the userName in the event
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DataSource extends CalendarDataSource {
  _DataSource(List<Appointment> source) {
    appointments = source;
  }
}
