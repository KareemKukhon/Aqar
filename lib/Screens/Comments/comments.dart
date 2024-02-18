import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Comments/commentBox.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/data/SignUpData.dart';
import 'package:flutter_auth/data/commentModel.dart';
import 'package:flutter_auth/services/services.dart';
import 'package:provider/provider.dart';

class Comments extends StatefulWidget {
  String? id;
  Comments(this.id);

  @override
  _CommentsState createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();
  List<CommentModel> filedata = [];
  User? user;

  //  @override
  // void initState() {
  //   super.initState();
  // List<Map<String, dynamic>> usersinfo = userInformation();
  // users = List.generate(usersinfo.length, (index) {
  //     return User(
  //       id: usersinfo[index]['id'],
  //       firstName: usersinfo[index]['firstName'],
  //       imagePath: usersinfo[index]['imagePath'],
  //       lastName: usersinfo[index]['lastName'],
  //       email: usersinfo[index]['email'],
  //       gender: usersinfo[index]['gender'],
  //       phone: usersinfo[index]['phone'],
  //       location: usersinfo[index]['location'],
  //       city: usersinfo[index]['city'],
  //     );
  //   });
  // }

  Widget commentChild(List<CommentModel> data) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(2.0, 8.0, 2.0, 0.0),
          child: ListTile(
            leading: GestureDetector(
              onTap: () async {
                // Display the image in large form.
                print("Comment Clicked");
              },
              child: Container(
                height: 50.0,
                width: 50.0,
                decoration: BoxDecoration(
                    color: kPrimaryLightColor,
                    borderRadius: new BorderRadius.all(Radius.circular(50))),
                child: CircleAvatar(
                    radius: 50,
                    backgroundImage: CommentBox.commentImageParser(
                        imageURLorPath:
                            data[index].pic ?? "./assets/images/home1.jpg")),
              ),
            ),
            title: Text(
              data[index].name ?? "",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(data[index].message ?? ""),
            trailing: Text(data[index].date.toString(),
                style: TextStyle(fontSize: 10)),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // User? user = Provider.of<Services>(context).userRes;
    return FutureBuilder(
        future: Provider.of<Services>(context, listen: false)
            .getComment(widget.id.toString()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(); // Loading indicator while waiting
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            filedata = Provider.of<Services>(context).comments;
            user = Provider.of<Services>(context).userRes;
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  "Comment Page",
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: kPrimaryColor,
                iconTheme: IconThemeData(color: Colors.white),
              ),
              body: Container(
                child: CommentBox(
                  userImage: CommentBox.commentImageParser(
                      imageURLorPath:
                          "http://192.168.68.51:8083${user!.image}"),
                  child: commentChild(filedata),
                  labelText: 'Write a comment...',
                  errorText: 'Comment cannot be blank',
                  withBorder: true,
                  sendButtonMethod: () {
                    if (formKey.currentState!.validate()) {
                      print(commentController.text);
                      setState(() {
                        CommentModel value = (CommentModel(
                            id: widget.id,
                            name: '${user!.firstName} ${user!.lastName}',
                            pic: "http://192.168.68.51:8083${user!.image}",
                            message: commentController.text,
                            date: DateTime.now()));
                        // filedata.insert(0, value);
                        Provider.of<Services>(context, listen: false)
                            .postComment(value);
                      });
                      commentController.clear();
                      //FocusScope.of(context).unfocus();
                    } else {
                      print("Not validated");
                    }
                  },
                  formKey: formKey,
                  commentController: commentController,
                  backgroundColor: kPrimaryColor,
                  textColor: Colors.white,
                  sendWidget:
                      Icon(Icons.send_sharp, size: 30, color: Colors.white),
                ),
              ),
            );
          }
        });
  }
}
