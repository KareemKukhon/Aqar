import 'dart:convert';
import 'dart:io';

class ChatUser {
  final int id;
  final String name;
  final String? image;

  ChatUser({required this.image, required this.id, required this.name});

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}

List<ChatUser> users() {
  return [
    ChatUser(id: 1, name: 'Yaqeen', image: "assets/images/house1.jpg"),
    ChatUser(id: 2, name: 'Raya', image: "assets/images/house1.jpg"),
    ChatUser(id: 3, name: 'Yaseen', image: "assets/images/house1.jpg"),
    ChatUser(id: 4, name: 'Kareem', image: "assets/images/house1.jpg"),
    ChatUser(id: 5, name: 'Hareth', image: "assets/images/house1.jpg"),
    ChatUser(id: 6, name: 'Mohammad', image: "assets/images/house1.jpg"),
    ChatUser(id: 7, name: 'Bsma', image: "assets/images/house1.jpg"),
  ];
}

void main() {
  List<ChatUser> userList = users();
  String usersJson = jsonEncode(userList.map((user) => user.toJson()).toList());

  print(usersJson);
}
