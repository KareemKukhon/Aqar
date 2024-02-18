import 'dart:developer';

import 'package:booking_calendar/booking_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Login/components/login_form.dart';
import 'package:flutter_auth/services/services.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:flutter_auth/Screens/profilepage/Calendar.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/data/Appointments.dart';
import 'package:flutter_auth/data/SignUpData.dart';
import 'package:provider/provider.dart';

class Book extends StatefulWidget {
  User? sender;
  User? reciepnt;

  Book({
    Key? key,
    this.sender,
    this.reciepnt,
  }) : super(key: key);

  @override
  _BookState createState() => _BookState();
}

class _BookState extends State<Book> {
  final now = DateTime.now();
  late BookingService mockBookingService;
  List<AppointmentModel> appointments = [];

  @override
  void initState() {
    super.initState();
    Services services = new Services();
    mockBookingService = BookingService(
      serviceName: 'Mock Service',
      serviceDuration: 30,
      bookingEnd: DateTime(now.year, now.month, now.day, 18, 0),
      bookingStart: DateTime(now.year, now.month, now.day, 12, 0),
    );
  }

  Stream<List<dynamic>> getBookingStreamMock({
    required DateTime end,
    required DateTime start,
  }) async* {
    String? eUser1 = widget.sender!
        .email; // Assuming widget.user1 and widget.user2 are the user IDs
    String? eUser2 = widget.reciepnt!.email;
    List<AppointmentModel> appointments =
        await services.getAppointments(eUser1, eUser2);
    yield convertStreamResult(streamResult: appointments);
    //     log("messageeee: " + appointments.toString());
    // yield appointments;
  }

  List<AppointmentModel> converted = [];

  Future<dynamic> uploadBookingMock({
    required BookingService newBooking,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    AppointmentModel bookingData = AppointmentModel(
      user1: widget.sender,
      user2: widget.reciepnt,
      start: newBooking.bookingStart,
      end: newBooking.bookingEnd,
    );
    log(newBooking.bookingEnd.toString());
    print(bookingData);
    converted.add(bookingData);
    // services.createAppointment(bookingData);
    // log(bookingData.toString());
    var data = {
      "Appointment": bookingData.toMap(),
      "email": bookingData.user2!.email
    };
    Provider.of<Services>(context, listen: false)
        .socket
        .emit("sendNotification", data);
    AppointmentsList appointmentsList = AppointmentsList(converted);
    appointmentsList.convData();
  }

  List<DateTimeRange> convertStreamResultMock({
    required dynamic streamResult,
  }) {
    return converted
        .map((bookingData) => DateTimeRange(
              start: bookingData.start!,
              end: bookingData.end!,
            ))
        .toList();
  }

  List<DateTimeRange> convertStreamResult({
    required List<AppointmentModel> streamResult,
  }) {
    return streamResult.map((appointment) {
      return DateTimeRange(
        start: appointment.start!,
        end: appointment.end!,
      );
    }).toList();
  }

  List<DateTimeRange> generatePauseSlots(List<AppointmentModel> appointments) {
    String? eUser1 = widget.sender!
        .email; // Assuming widget.user1 and widget.user2 are the user IDs
    String? eUser2 = widget.reciepnt!.email;

    return convertStreamResult(streamResult: appointments);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Provider.of<Services>(context, listen: false)
            .getAppointments(widget.sender!.email, widget.reciepnt!.email),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(); // Loading indicator while waiting
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            appointments = Provider.of<Services>(context).appointments;
            return Scaffold(
              appBar: AppBar(
                iconTheme: IconThemeData(color: Colors.white),
                backgroundColor: kPrimaryColor,
              ),
              body: Center(
                child: BookingCalendar(
                  bookingService: mockBookingService,
                  convertStreamResultToDateTimeRanges: convertStreamResultMock,
                  getBookingStream: getBookingStreamMock,
                  uploadBooking: uploadBookingMock,
                  bookedSlotColor: Colors.red,
                  pauseSlots: generatePauseSlots(appointments),
                  pauseSlotText: 'Not Available',
                  hideBreakTime: false,
                  loadingWidget: const Text('Fetching data...'),
                  uploadingWidget: const CircularProgressIndicator(),
                  locale: 'hu_HU',
                  startingDayOfWeek: StartingDayOfWeek.tuesday,
                  availableSlotColor: kPrimaryColor,
                  bookingButtonColor: kPrimaryColor,
                  selectedSlotColor: Colors.red.shade100,
                  wholeDayIsBookedWidget:
                      const Text('Sorry, for this day everything is booked'),
                ),
              ),
            );
          }
        });
  }
}
