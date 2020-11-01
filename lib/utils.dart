import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

dynamic showAlertDialog(BuildContext context, String title, String message) {
  final Widget okButton = FlatButton(
    child: const Text('OK'),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  final AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(message),
    actions: <Widget>[
      okButton,
    ],
  );

  showDialog<AlertDialog>(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

// ignore: always_specify_types
Future getImage(int way) async {
  final ImagePicker picker = ImagePicker();
  final dynamic pickedFile = await picker.getImage(
      source: way == 1 ? ImageSource.camera : ImageSource.gallery);

  if (pickedFile != null) {
    return File(pickedFile.path as String);
  }
  return null;
}
