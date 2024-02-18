import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_auth/constants.dart';

class EditProfileWidget extends StatelessWidget {
  dynamic imagePath;
  final VoidCallback onClicked;
  bool networkFalg;

  EditProfileWidget({
    Key? key,
    required this.imagePath,
    required this.onClicked,
    required this.networkFalg,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = kPrimaryColor;

    return Center(
      child: Stack(
        children: [
          buildImage(),
          Positioned(
            bottom: 0,
            right: 4,
            child: buildCameraIcon(color),
          ),
        ],
      ),
    );
  }

  Widget buildImage() {
    final image;
    if (networkFalg) {
      if (imagePath != null)
        image = NetworkImage(imagePath);
      else {
        image = AssetImage("assets/images/userAvatar.png");
      }
    } else {
      image = FileImage(imagePath);
    }

    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: image,
          fit: BoxFit.cover,
          width: 128,
          height: 128,
          child: InkWell(onTap: onClicked),
        ),
      ),
    );
  }

  Widget buildCameraIcon(Color color) => buildCircle(
        color: Colors.white,
        all: 3,
        child: buildCircle(
          color: color,
          all: 8,
          child: Icon(
            Icons.camera,
            color: Colors.white,
            size: 20,
          ),
        ),
      );

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );
}
