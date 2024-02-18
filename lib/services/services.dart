import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/notification/notification_service.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/data/Appointments.dart';
import 'package:flutter_auth/data/LoginData.dart';
import 'package:flutter_auth/data/NotificationData.dart';
import 'package:flutter_auth/data/Property.dart';
import 'package:flutter_auth/data/SearchByData.dart';
import 'package:flutter_auth/data/SignUpData.dart';
import 'package:flutter_auth/data/commentModel.dart';
import 'package:flutter_auth/data/contactsModel.dart';
import 'package:flutter_auth/data/messageModel.dart';
import 'package:flutter_auth/data/savedProperty.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class Services extends ChangeNotifier {
  final Dio dio = Dio(); // Create a Dio instance
  List<PropertyModel> propertyList = [];
  List<PropertyModel> userPropertyList = [];
  List<PropertyModel> savedPropertyList = [];
  List<PropertyModel> recoPropertyList = [];
  List<PropertyModel> searchPropertyList = [];
  List<PropertyModel> botPropertyList = [];
  dynamic? botRes;
  List<ChatModel> messages = [];
  List<ChatModel> botMessages = [];
  List<CommentModel> comments = [];
  List<AppointmentModel> appointments = [];
  List<AppointmentModel> myAppointments = [];
  List<Notification_Description> notifications = [];
  Map<String, Map<String, int>> cityCounts = {};

  User? sender;
  User? contact;
  bool inChat = false;
  final ScrollController scrollController = ScrollController();
  TextEditingController messageController = TextEditingController();
  late dynamic response1;
  User? userRes;
  late IO.Socket socket;

  bool userDetailsSent = false;

  void sendUserDetails(User owner) {
    if (!userDetailsSent) {
      User? user = userRes;
      socket.emit('userDetails', {user, owner});
      userDetailsSent = true;
    }
  }

  addMessage(ChatModel message) {
    messages.add(message);

    log(messages.length.toString());
    // notifyListeners();
  }

  toggleInChat(User? sender) {
    inChat = !inChat;
    this.sender = sender;
  }

  addBotMessage(ChatModel message) {
    botMessages.add(message);
    log(messages.length.toString());
    // notifyListeners();
  }

  clearBuffer() {
    messages = [];
    // notifyListeners();
  }

  emitMessage() {
    messages;

    notifyListeners();
  }

  connection(User user) {
    log("kareemmm..");

    // Connect to the Ts.ED WebSocket server

    socket = IO.io(
        'http://192.168.68.51:8083/socket',
        OptionBuilder().setTransports(['websocket']) // for Flutter or Dart VM
            .build());

    socket.connect();
    socket.on('connect', (_) {
      clearBuffer();
      socket.on(
          'incoming',
          (msg) => {
                // for (int i = 0; i < msg.length(); i++)
                // log("message: incoming"),

                addMessage(ChatModel.fromMap(msg, userRes!.email!)),
                emitMessage()
              });
      socket.on(
          'outgoing',
          (msg) => {
                // for (int i = 0; i < msg.length(); i++)
                // log("message: outgoing"),

                addMessage(ChatModel.fromMap(msg, userRes!.email!)),
                emitMessage()
              });
      socket.on("done", (data) {
        messages;
        notifyListeners();
      });

      socket.on('createNotification', (data1) async {
        // log(data1);
        AppointmentModel data = AppointmentModel.fromMap(data1);
        // print(data.user1.toString());
        Notification_Description notification = Notification_Description(
            body:
                "${data.user1!.firstName ?? ""} has submitted a request to book an appointment with you",
            date: data.start,
            recipient: data.user2!,
            sender: data.user1!,
            title: "new Appointment");
        await addNotification(notification);
        String sender = jsonEncode(data.user1!.toJson());
        String recipient = jsonEncode(data.user2!.toJson());
        NotificationService.showNotification(
            title: "new Appointment",
            body:
                "${data.user1!.firstName ?? ""} has submitted a request to book an appointment with you",
            payload: {
              "navigate": "true",
              "sender": sender,
              "recipient": recipient,
              "flag": "true"
            },
            actionButtons: [
              NotificationActionButton(
                key: 'check',
                label: 'Check it out',
                actionType: ActionType.SilentAction,
                color: kPrimaryColor,
              )
            ]);
      });

      socket.on('chatMessage', (data) async {
        log("chatMessage...");
        log("/////////////////////////////////////////////////////////////");
        ChatModel message = ChatModel.fromMap(data, userRes!.email!);
        if (this.sender != null) {
          log("sender: ${this.sender?.email}message: ${message.sender?.email}");
          if (this.sender!.email == message.sender!.email) {
            addMessage(message);
            log("add message");
            emitMessage();
          } else {
            String sender = jsonEncode(message.sender!.toJson());
            String recipient = jsonEncode(message.recipient!.toJson());
            log("==============================================================");
            Notification_Description notification = Notification_Description(
                body: message.message,
                date: DateTime.now(),
                recipient: message.recipient!,
                sender: message.sender!,
                title: message.sender!.firstName ?? "");
            await addNotification(notification);
            NotificationService.showNotification(
                title: message.sender!.firstName ?? "",
                body: message.message,
                payload: {
                  "navigate": "true",
                  "sender": sender,
                  "recipient": recipient,
                  "flag": "false"
                },
                actionButtons: [
                  NotificationActionButton(
                    key: 'check',
                    label: 'Check it out',
                    actionType: ActionType.SilentAction,
                    color: kPrimaryColor,
                  )
                ]);
          }
          if (inChat) {
            scrollController.animateTo(
              scrollController.position.maxScrollExtent,
              duration: Duration(milliseconds: 500),
              curve: Curves.easeOut,
            );
          }
        } else {
          String sender = jsonEncode(message.sender!.toJson());
          String recipient = jsonEncode(message.recipient!.toJson());
          log(".............................................................");
          Notification_Description notification = Notification_Description(
              body: message.message,
              date: DateTime.now(),
              recipient: message.recipient!,
              sender: message.sender!,
              title: message.sender!.firstName ?? "");
          await addNotification(notification);
          NotificationService.showNotification(
              title: message.sender!.firstName ?? "",
              body: message.message,
              payload: {
                "navigate": "true",
                "sender": sender,
                "recipient": recipient
              },
              actionButtons: [
                NotificationActionButton(
                  key: 'check',
                  label: 'Check it out',
                  actionType: ActionType.SilentAction,
                  color: kPrimaryColor,
                )
              ]);
        }
      });
    });
  }

  // Subscribe to the 'chatMessage' event
  sendMessage(ChatModel chat) {
    Map map = chat.toMap();
    // map.remove('id');
    socket.emit("sendMessage", map);
  }

  emitAppointment(AppointmentModel appointmentModel) {
    var data = {
      "Appointment": appointmentModel.toJson(),
      "email": appointmentModel.user2!.email
    };
    socket.emit("sendNotification", data);
  }

  createAppointment(AppointmentModel appointmentModel) async {
    var url = "http://192.168.68.51:8083/rest/appointments/create";

    String? token = await getToken();

    try {
      dio.post(
        url,
        data: appointmentModel.toJson(),
        options: Options(
          headers: {
            'authorization': token,
            'Content-Type': 'application/json',
          },
        ),
      );
    } catch (e) {
      throw ("network error: " + e.toString());
    }
  }

  reciveMessage() {}
  // notifyListeners();

  findUserByEmail(String email) async {
    final url = 'http://192.168.68.51:8083/rest/rest/findByEmail/${email}';
    String? token = await getToken();
    try {
      final response = await dio.get(
        url,
        options: Options(
          headers: {
            'authorization': token,
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200) {
        contact = User.fromMap(response.data['user']);
        log(contact.toString());
        // notifyListeners();
      } else {}
    } catch (e) {
      throw ('Network Error: $e');
    }
  }

  Future<void> registerUser(String code, User user, File? imageFile) async {
    final url = 'http://192.168.68.51:8083/rest/rest/register/${code}';
    String? token = await getToken();
    FormData formData;
    Response response;
    if (imageFile != null) {
      String fileName = imageFile.path.split('/').last;

      formData = FormData.fromMap({
        "file":
            await MultipartFile.fromFile(imageFile.path, filename: fileName),
        ...user.toMap(),
      });

      try {
        response = await dio.post(
          url,
          data: formData,
          options: Options(
            headers: {
              // 'authorization': token,
              'Content-Type': 'application/json',
            },
          ),
        );
      } catch (e) {
        throw ("network error: " + e.toString());
      }
    } else {
      log(user.toString());
      try {
        response = await dio.post(
          url,
          data: user.toJson(),
          options: Options(
            headers: {
              // 'authorization': token,
              'Content-Type': 'application/json',
            },
          ),
        );
      } catch (e) {
        throw ("network error: $e");
      }
    }
    // try {
    //   final response = await dio.post(
    //     url,
    //     data: user.toJson(),
    //     options: Options(
    //       headers: {
    //         'authorization': token,
    //         'Content-Type': 'application/json',
    //       },
    //     ),
    //   );
    //   if (response.statusCode == 200) {
    //   } else {}
    // } catch (e) {
    //   throw ('Network Error: $e');
    // }
  }

  addContacts(ContactsModel contact) {
    List<ContactsModel> contactsToAdd = [];
    bool flag = false;

    if (userRes!.contacts!.isNotEmpty) {
      for (var con in userRes!.contacts!) {
        if (con.email == contact.email) {
          flag = true;
        }
      }
      if (!flag) {
        contactsToAdd.add(contact);
      }
    } else {
      contactsToAdd.add(contact);
    }

    userRes!.contacts!.addAll(contactsToAdd);
    // notifyListeners();
  }

  Future<String?> login(String email, String password) async {
    // print(response1);
    final url =
        'http://192.168.68.51:8083/rest/rest/login'; // Replace with your actual backend URL

    final user =
        logindata(email: email, password: password); // Create a UserModel
    String? token = await getToken();

    try {
      Response response = await dio.post(
        url,
        data: user.toJson(), // Assuming UserModel has a toJson method
        options: Options(
          responseType: ResponseType.json,
          headers: {
            'authorization': token,
            'Content-Type':
                'application/json', // Set the appropriate content type
          },
        ),
      );

      if (response.data.toString() != "wrong") {
        final responseData = response.toString();

        try {
          // Convert the response data to a User
          // Map<String, dynamic> userData = json.decode(response.data);
          userRes = User.fromMap(response.data['user']);
          String token = response.data['token'].toString();
          storeToken(token);
          await connection(userRes!);
          socket.emit('setUserOnline', userRes);

          // print(userRes);
          notifyListeners();
        } catch (e) {
          throw Exception('Error decoding response data: $e');
        }
        //  else {
        //   print('Empty or null response data');
        // }
        // userRes = User.fromMap(response.data);
        // await fetchDataFromServer();
        // print("response = " + responseData);
        final loggedInUser = (responseData);
        return loggedInUser;
      } else {
        return null;
        // Login failed, you can handle error cases here
        // throw Exception('Login failed');
      }
    } catch (e) {
      // Handle network errors, e.g., connection issues
      throw Exception('Network Error: $e');
    }
  }

  Future<void> storeToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('jwt_token', token);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('jwt_token');
    return token;
  }

  fetchDataFromServer() async {
    const url = "http://192.168.68.51:8083/rest/properties/fetchAll";
    Response response;
    String? token = await getToken();
    try {
      response = await dio.post(url,
          options: Options(headers: {
            'authorization': token,
            'Content-Type': 'application/json',
          }));

      propertyList = (response.data)
          .map((item) {
            // log(item)
            return PropertyModel.fromMap(item);
          })
          .toList()
          .cast<PropertyModel>();
      notifyListeners();
      return propertyList;
    } catch (e) {
      throw ('Network Error: ${e}');
    }
  }

  fetchUserProperties() async {
    var url =
        "http://192.168.68.51:8083/rest/properties/fetchUserProperty/${userRes!.email}";
    Response response;
    String? token = await getToken();
    try {
      response = await dio.post(url,
          options: Options(headers: {
            'authorization': token,
            'Content-Type': 'application/json',
          }));

      userPropertyList = (response.data)
          .map((item) {
            return PropertyModel.fromMap(item);
          })
          .toList()
          .cast<PropertyModel>();
      notifyListeners();
      return userPropertyList;
    } catch (e) {
      throw ('Network Error: $e');
    }
  }

  // late dynamic response1;
  Future<String> confirmEmail(User user, email) async {
    final url = 'http://192.168.68.51:8083/rest/rest/confirmEmail/${email}';
    String? token = await getToken();
    log("email: " + email);
    try {
      response1 = await dio.post(
        url,
        data: user.toJson(),
        options: Options(
          headers: {
            'authorization': token,
            'Content-Type': 'application/json',
          },
        ),
      );
      log(response1.toString());
      // notifyListeners();
      return response1.toString();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<String> sendEmail(String email, String message) async {
    String to = 'kareemkukhon1@gmail.com';
    final url = 'http://192.168.68.51:8083/rest/rest/sendEmail/${email}/$to';
    String? token = await getToken();
    log("email: " + email);
    try {
      response1 = await dio.post(
        url,
        data: jsonEncode({"message": message}),
        options: Options(
          headers: {
            'authorization': token,
            'Content-Type': 'application/json',
          },
        ),
      );
      log(response1.toString());
      // notifyListeners();
      return response1.toString();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> saveProperty(File imageFile, Map<String, dynamic> propertyData,
      List<XFile> ImageFileList) async {
    List<MultipartFile> multipartImageFiles = [];
    print("propertyData = " + propertyData.toString());

    String fileName = imageFile.path.split('/').last;
    print(fileName);
    for (var file in ImageFileList) {
      String fileName = file.path.split('/').last;
      print(fileName);
      MultipartFile multipartFile =
          await MultipartFile.fromFile(file.path, filename: fileName);
      multipartImageFiles.add(multipartFile);
    }

    propertyData.remove('id');
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(imageFile.path, filename: fileName),
      "files": multipartImageFiles.toList(),
      ...propertyData,
    });

    print("formData: ");
    print(formData.toString());
    await dio.post("http://192.168.68.51:8083/rest/properties/save",
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ));
  }

  Future<void> postComment(CommentModel commentModel) async {
    const url = "http://192.168.68.51:8083/rest/comment/postComment";
    String? token = await getToken();

    try {
      dio.post(
        url,
        data: commentModel.toJson(),
        options: Options(
          headers: {
            'authorization': token,
            'Content-Type': 'application/json',
          },
        ),
      );
    } catch (e) {
      throw ("network error: " + e.toString());
    }
  }

  Future<void> getComment(String id) async {
    var url = 'http://192.168.68.51:8083/rest/comment/get/$id';
    String? token = await getToken();

    try {
      Response response = await dio.get(
        url,
        options: Options(
          headers: {
            'authorization': token,
            'Content-Type': 'application/json',
          },
        ),
      );
      comments = response.data
          .map((item) {
            // log(item)
            return CommentModel.fromMap(item);
          })
          .toList()
          .cast<CommentModel>();
      notifyListeners();
    } catch (e) {
      throw ("network error: " + e.toString());
    }
  }

  Future<List<AppointmentModel>> getAppointments(
      String? eUser1, String? eUser2) async {
    var url = "http://192.168.68.51:8083/rest/appointments/get/$eUser1/$eUser2";
    String? token = await getToken();
    try {
      Response response = await dio.get(
        url,
        options: Options(
          headers: {
            'authorization': token,
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.data is List) {
        // Cast each element of the list to Map<String, dynamic>
        List<Map<String, dynamic>> data =
            List<Map<String, dynamic>>.from(response.data);

        appointments = data.map((e) => AppointmentModel.fromMap(e)).toList();
        notifyListeners();
        // log("appointment: " + appointments.toString());
        return appointments;
      } else {
        throw ("Unexpected data type received from the server");
      }
    } catch (e) {
      throw ("network error: " + e.toString());
    }
  }

  Future<List<AppointmentModel>> getAppointment() async {
    String? email = userRes!.email;
    var url = "http://192.168.68.51:8083/rest/appointments/get/$email";
    String? token = await getToken();
    try {
      Response response = await dio.get(
        url,
        options: Options(
          headers: {
            'authorization': token,
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.data is List) {
        // Cast each element of the list to Map<String, dynamic>
        List<Map<String, dynamic>> data =
            List<Map<String, dynamic>>.from(response.data);

        myAppointments = data.map((e) => AppointmentModel.fromMap(e)).toList();
        notifyListeners();
        log("appointment: " + myAppointments.toString());
        return myAppointments;
      } else {
        throw ("Unexpected data type received from the server");
      }
    } catch (e) {
      throw ("network error: " + e.toString());
    }
  }

  Future<void> savedProperty(SavedPropertyModel savedPropertyModel) async {
    var url = "http://192.168.68.51:8083/rest/saveProperty/create";
    String? token = await getToken();

    try {
      dio.post(
        url,
        data: savedPropertyModel.toJson(),
        options: Options(
          headers: {
            'authorization': token,
            'Content-Type': 'application/json',
          },
        ),
      );
    } catch (e) {
      throw ("network error: " + e.toString());
    }
  }

  getSavedProperty() async {
    String email = userRes!.email!;
    var url = "http://192.168.68.51:8083/rest/saveProperty/get/$email";
    String? token = await getToken();

    try {
      Response response = await dio.get(
        url,
        options: Options(
          headers: {
            'authorization': token,
            'Content-Type': 'application/json',
          },
        ),
      );
      savedPropertyList = response.data
          .map((e) {
            return PropertyModel.fromMap(e);
          })
          .toList()
          .cast<PropertyModel>();
      notifyListeners();
      return savedPropertyList;
    } catch (e) {
      throw ("network error: " + e.toString());
    }
  }

  deleteSavedProperty(PropertyModel property, String email) async {
    // String? email = userRes?.email!;
    var url = "http://192.168.68.51:8083/rest/saveProperty/delete/$email";
    String? token = await getToken();

    try {
      await dio.delete(
        url,
        data: property.toJson(),
        options: Options(
          headers: {
            'authorization': token,
            'Content-Type': 'application/json',
          },
        ),
      );
      // savedPropertyList = response.data
      //     .map((e) {
      //       return PropertyModel.fromMap(e);
      //     })
      //     .toList()
      //     .cast<PropertyModel>();
      notifyListeners();
      // return savedPropertyList;
    } catch (e) {
      throw ("network error: " + e.toString());
    }
  }

  Future<void> visitProperty(SavedPropertyModel savedPropertyModel) async {
    var url = "http://192.168.68.51:8083/rest/saveProperty/create";
    String? token = await getToken();

    try {
      dio.post(
        url,
        data: savedPropertyModel.toJson(),
        options: Options(
          headers: {
            'authorization': token,
            'Content-Type': 'application/json',
          },
        ),
      );
    } catch (e) {
      throw ("network error: " + e.toString());
    }
  }

  Future<void> getRecommendedProperty() async {
    String email = userRes!.email!;
    log(email);
    var url =
        "http://192.168.68.51:8083/rest/recommendation/getRecommendedProperties/$email";
    String? token = await getToken();

    try {
      Response response = await dio.post(
        url,
        options: Options(
          headers: {
            'authorization': token,
            'Content-Type': 'application/json',
          },
        ),
      );

      recoPropertyList = response.data
          .map((e) {
            // log(e);
            return PropertyModel.fromMap(e);
          })
          .toList()
          .cast<PropertyModel>();
      log(recoPropertyList.toString());
      notifyListeners();
      // return recoPropertyList;
    } catch (e) {
      throw ("network error: " + e.toString());
    }
  }

  Future<void> updateRecommendedProperty(String city) async {
    String email = userRes!.email!;
    log(email);
    var url = "http://192.168.68.51:8083/rest/recommendation/$email/visit";
    String? token = await getToken();

    try {
      Response response = await dio.post(
        url,
        data: {"cityName": city},
        options: Options(
          headers: {
            'authorization': token,
            'Content-Type': 'application/json',
          },
        ),
      );

      // recoPropertyList = response.data
      //     .map((e) {
      //       // log(e);
      //       return PropertyModel.fromMap(e);
      //     })
      //     .toList()
      //     .cast<PropertyModel>();
      // log(recoPropertyList.toString());
      // notifyListeners();
      // return recoPropertyList;
    } catch (e) {
      throw ("network error: " + e.toString());
    }
  }

  Future<void> sendBotMessage(String message) async {
    String email = userRes!.email!;
    var msg = {"user_message": message};
    log(email);
    var url = "http://192.168.68.51:8083/rest/chatbot/sendMessage";
    String? token = await getToken();

    try {
      Response response = await dio.post(
        url,
        data: msg,
        options: Options(
          headers: {
            'authorization': token,
            'Content-Type': 'application/json',
          },
        ),
      );

      botRes = response.data;
      log(botRes['reply'].toString());
      botPropertyList = botRes['properties']
          .map((e) => PropertyModel.fromMap(e))
          .toList()
          .cast<PropertyModel>();
      if (botPropertyList.length > 0) {
        botMessages.add(ChatModel(
            message: botRes['reply'].toString(),
            timestamp: DateTime.now(),
            location: botRes['location'],
            isPropEmpty: false,
            isSender: false));
      } else {
        botMessages.add(ChatModel(
            message: botRes['reply'].toString(),
            timestamp: DateTime.now(),
            location: botRes['location'],
            isPropEmpty: true,
            isSender: false));
      }

      log(botPropertyList.length.toString());
      notifyListeners();
    } catch (e) {
      throw ("network error: " + e.toString());
    }
  }

  Future<List<PropertyModel>> getSearchedProperty(SearchBy data) async {
    var url = "http://192.168.68.51:8083/rest/search/findProperty";
    String? token = await getToken();
    log(data.toJson());
    try {
      Response response = await dio.post(
        url,
        data: data.toJson(),
        options: Options(
          headers: {
            'authorization': token,
            'Content-Type': 'application/json',
          },
        ),
      );

      searchPropertyList = response.data
          .map((e) {
            // log(e);
            return PropertyModel.fromMap(e);
          })
          .toList()
          .cast<PropertyModel>();
      log(searchPropertyList.toString());
      return searchPropertyList;
    } catch (e) {
      throw ("network error: " + e.toString());
    }
  }

  sendNotification(title, body) async {
    var headers = {
      'Authorization':
          'key=AAAA4AeRja4:APA91bGiIfIvmsJEX5TJFnwQQYxYPdnCBXUW4ZFjeCVZV9uorwVnSglXcqy_ootx3nz9D6z7v648Kk_3JR4Hz_rGvl4NKlZkRv_yHVzlkfuTOHy9VB0UHl3-LLKyy7hlvrlvArRY1VIZ',
      'Content-Type': 'application/json'
    };
    var data = json.encode({
      "to":
          "cPQcJt0SRhOOan7l7faRHs:APA91bEsqGkanhhtDJZl-Y3MGNSWMrGPXRogN-XFsoZFMwqapvHicHJaOi-Uc1yW1FfDg8qTBnpHkrslklKAyvrsqyxjDATQps0CGG6U_1xpGsggDm73C3bZVU24T0wwT8VrAl_ql0GP",
      "notification": {
        "title": title,
        "body": body,
        "mutable_content": true,
        "sound": "Tri-tone"
      },
      // "data": {
      //   "url": "<url of media image>",
      //   "dl": "<deeplink action on tap of notification>"
      // }
    });
    var dio = Dio();
    var response = await dio.request(
      'https://fcm.googleapis.com/fcm/send',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      print(json.encode(response.data));
    } else {
      print(response.statusMessage);
    }
  }

  updateUserInfo(User newInfo, File? imageFile) async {
    var url = "http://192.168.68.51:8083/rest/rest/updateUser";
    String? token = await getToken();
    FormData formData;
    Response response;
    if (imageFile != null) {
      String fileName = imageFile.path.split('/').last;

      formData = FormData.fromMap({
        "file":
            await MultipartFile.fromFile(imageFile.path, filename: fileName),
        ...newInfo.toMap(),
      });

      try {
        response = await dio.post(
          url,
          data: formData,
          options: Options(
            headers: {
              'authorization': token,
              'Content-Type': 'application/json',
            },
          ),
        );
      } catch (e) {
        throw ("network error: " + e.toString());
      }
    } else {
      log(newInfo.toString());
      try {
        response = await dio.post(
          url,
          data: newInfo.toJson(),
          options: Options(
            headers: {
              'authorization': token,
              'Content-Type': 'application/json',
            },
          ),
        );
      } catch (e) {
        throw ("network error: $e");
      }
    }
    // log(response.data.toString());
    userRes = User.fromMap(response.data);
    notifyListeners();
  }

  Future<List<Notification_Description>> getNotification(User user) async {
    var url = "http://192.168.68.51:8083/rest/notification/get";
    log("User: ${user.toJson()}");
    try {
      Response response = await dio.post(url,
          data: user.toJson(),
          options: Options(headers: {
            'Content-Type': 'application/json',
          }));
      notifications = response.data
          .map((e) {
            // log(e);
            return Notification_Description.fromMap(e);
          })
          .toList()
          .cast<Notification_Description>();
      // log(notifications.toString());
      return notifications;
      // notifyListeners();
    } catch (e) {
      throw ("network error: $e");
    }
  }

  addNotification(Notification_Description notification) async {
    var url = "http://192.168.68.51:8083/rest/notification/add";
    log(notification.toString());
    try {
      Response response = await dio.post(url,
          data: notification.toJson(),
          options: Options(headers: {
            'Content-Type': 'application/json',
          }));
      notifications.add(notification);
      notifyListeners();
    } catch (e) {
      throw ("network error: $e");
    }
  }

  deleteProperty(PropertyModel property, bool flag) async {
    String? id = property.id;
    var url = "http://192.168.68.51:8083/rest/properties/delete/$id";
    var url1 = "http://192.168.68.51:8083/rest/properties/addDelProperty";
    String? token = await getToken();

    log(id.toString());
    try {
      Response response = await dio.delete(url,
          options: Options(headers: {
            'authorization': token,
            'Content-Type': 'application/json',
          }));
      userPropertyList.remove(property);
      notifyListeners();
    } catch (e) {
      throw ("network error: $e");
    }
    if (flag) {
      try {
        Response response = await dio.post(url1,
            data: property.toJson(),
            options: Options(headers: {
              'authorization': token,
              'Content-Type': 'application/json',
            }));
      } catch (e) {
        throw ("network error: $e");
      }
    }
  }

  getCount() async {
    var url = "http://192.168.68.51:8083/rest/properties/getCount";
    try {
      Response response = await dio.get(url,
          options: Options(headers: {
            'Content-Type': 'application/json',
          }));
      Map<String, dynamic> responseData = response.data;
      Map<String, Map<String, int>> convertedData = {};

      responseData.forEach((key, value) {
        convertedData[key] = Map<String, int>.from(value);
      });

      cityCounts = convertedData;
      notifyListeners();
    } catch (e) {
      throw ("network error: $e");
    }
  }
}
