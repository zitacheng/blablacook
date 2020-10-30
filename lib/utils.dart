import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

dynamic showAlertDialog(BuildContext context, String title, String message) {
  // set up the button
  final Widget okButton = FlatButton(
    child: const Text('OK'),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  final AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(message),
    // ignore: always_specify_types
    actions: [
      okButton,
    ],
  );

  // show the dialog
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
